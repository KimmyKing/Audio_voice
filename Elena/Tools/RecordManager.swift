//
//  RecordManager.swift
//  Elena
//
//  Created by Cain on 2018/3/26.
//  Copyright © 2018年 Cain. All rights reserved.
//

import UIKit
import Speech

class RecordManager: NSObject {
    
    //录音结束标识
    var isRecordingFinal:Bool = false
    
    //声明变量
    var recognitionRequest:SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask:SFSpeechRecognitionTask?
    
    //MARK: -
    //MARK: -- 关闭录音
    func stopRecording() {
        
        self.recognitionTask?.cancel()
        self.audioEngine.stop()
        self.recognitionRequest?.endAudio()
        self.recognitionRequest = nil

    }
    
    //MARK: -
    //MARK: -- 开始录音
    func startRecording(handle: @escaping (String!) -> Swift.Void) {
        
        //抛异常
        do {
            /**
             AVAudioSessionCategoryAmbient 或 kAudioSessionCategory_AmbientSound
             ——用于非以语音为主的应用，使用这个category的应用会随着静音键和屏幕关闭而静音。并且不会中止其它应用播放声音，可以和其它自带应用如iPod，safari等同时播放声音。注意：该Category无法在后台播放声音
             
             AVAudioSessionCategorySoloAmbient 或 kAudioSessionCategory_SoloAmbientSound
             ——类似于AVAudioSessionCategoryAmbient 不同之处在于它会中止其它应用播放声音。 这个category为默认category。该Category无法在后台播放声音
             
             AVAudioSessionCategoryPlayback 或 kAudioSessionCategory_MediaPlayback
             
             ——用于以语音为主的应用，使用这个category的应用不会随着静音键和屏幕关闭而静音。可在后台播放声音
             
             AVAudioSessionCategoryRecord 或 kAudioSessionCategory_RecordAudio
             
             ———用于需要录音的应用，设置该category后，除了来电铃声，闹钟或日历提醒之外的其它系统声音都不会被播放。该Category只提供单纯录音功能。
             AVAudioSessionCategoryPlayAndRecord 或 kAudioSessionCategory_PlayAndRecord
             ——用于既需要播放声音又需要录音的应用，语音聊天应用(如微信）应该使用这个category。
             */
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
            /**
             AVAudioSessionModeDefault：通用
             AVAudioSessionModeVoiceChat：只在AVAudioSessionCategoryPlayAndRecord可用，适合VoIP应用。使得音频路径只为VoIP输出。
             AVAudioSessionModeGameChat：只在AVAudioSessionCategoryPlayAndRecord可用。由Game Kit设定，不要直接设定。
             AVAudioSessionModeVideoRecording：AVAudioSessionCategoryPlayAndRecord或者AVAudioSessionCategoryRecord时可用。修改音频路由选项，并可进行适当的系统提供的信号处理。
             AVAudioSessionModeMeasurement：适用于希望尽量减少系统提供信号影响的应用程序输入和/或输出音频信号的处理。
             AVAudioSessionModeMoviePlayback：对电影回放场景进行适当的输出信号处理。目前仅适用于内置扬声器播放时。
             AVAudioSessionModeVideoChat：>=iOS7.0 只在kAudioSessionCategory_PlayAndRecord可用。减少允许的音频数量仅适用于视频聊天应用程序的路由。可以进行适当的系统提供的信号处理。
             AVAudioSessionModeSpokenAudio：>=iOS9.0 如果其他应用（如导航应用程序）播放语音音频提示时，适用于希望暂停（通过音频会话中断）而不是躲避。使用此应用程序的示例是播客播放器和音频书。
             */
            try AVAudioSession.sharedInstance().setMode(AVAudioSessionModeMeasurement)
            
            //notifyOthersOnDeactivation:通知中断程序中断已经结束，可以恢复播放
            try AVAudioSession.sharedInstance().setActive(true, with: AVAudioSessionSetActiveOptions.notifyOthersOnDeactivation)
            
        } catch {
            fatalError("这里说明有的功能不支持")
        }
        
        //创建识别语音的请求
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        recognitionRequest?.shouldReportPartialResults = true
        
        weak var weakSelf = self
        //音频格式
        let audioFormat:AVAudioFormat = audioEngine.inputNode.outputFormat(forBus: 0)
        //在添加tap之前先移除上一个  不然有可能报"Terminating app due to uncaught exception 'com.apple.coreaudio.avfaudio',"之类的错误
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1025, format: audioFormat) { (buffer, time) in
            weakSelf?.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print(error)
        }

        //语音识别任务的回调
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest!, resultHandler: { (result, error) in
            
            guard let str = result?.bestTranscription.formattedString else {
                return
            }
            
            //识别成功
            if result != nil {

                weakSelf?.strings.add(str)
                
                if weakSelf?.isRecordingFinal == true {
                    //录制结束
                    handle(weakSelf?.strings.lastObject as! String)
                    weakSelf?.strings.removeAllObjects()
                    weakSelf?.isRecordingFinal = false
                    weakSelf?.stopRecording()
                }
                
            }
            

            
            //识别失败,切换为关闭状态
            if error != nil {
                
                print(error as Any)
                weakSelf?.stopRecording()
                
            }
            
        })
    }
    
    
    //MARK: -
    //MARK: -- 语音识别器授权状态
    func getAuthorizationStatus(handler: @escaping (Bool) -> Swift.Void) {
        
        SFSpeechRecognizer.requestAuthorization { (status) in
            
            switch status{
                
            case .notDetermined:
                print("无法获取授权状态")
                handler(false)
                
            case .denied:
                print("未授权")
                handler(false)
                
            case .restricted:
                print("设备不支持")
                handler(false)
                
            case .authorized:
                print("已授权")
                handler(true)
            }
            
        }
    }
    
    lazy var audioEngine:AVAudioEngine = AVAudioEngine()
    
    lazy var speechRecognizer:SFSpeechRecognizer = {
        
        let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "zh_CN"))
        return speechRecognizer!
        
    }()

    lazy var strings:NSMutableArray = {
        var strings:NSMutableArray =  NSMutableArray()
        return strings
    }()
    
}

