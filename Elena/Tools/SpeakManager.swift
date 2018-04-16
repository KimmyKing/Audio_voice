//
//  SpeakManager.swift
//  Elena
//
//  Created by Cain on 2018/3/26.
//  Copyright © 2018年 Cain. All rights reserved.
//

import UIKit
import AVFoundation

class SpeakManager: NSObject {
    
    static let shareManager = SpeakManager()
    
    override func copy() -> Any {
        return self
    }
    
    override func mutableCopy() -> Any {
        return self
    }
    
    lazy var synthesizer:AVSpeechSynthesizer = AVSpeechSynthesizer()
    
    /// 朗读message
    ///
    /// - Parameters:
    ///   - message: 朗读内容
    ///   - filePath: 音频文件路径
    func startSpeaking(message:String) {
        //语音合成器
        //        let synthesizer:AVSpeechSynthesizer = AVSpeechSynthesizer()
        
        synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        let utterance:AVSpeechUtterance = AVSpeechUtterance(string: message)
        //音调调节  调节范围 ：[0.5 - 2]  默认是：1
        utterance.pitchMultiplier = 1
        //音量调节  调节范围 ：[0-1]  默认是 ：1
        utterance.volume = 1
        //语速调节  调节范围 ：[0-1]  0最慢  1 最快
        utterance.rate = 0.5
        let voice:AVSpeechSynthesisVoice = AVSpeechSynthesisVoice(language: "zh_CN")!
        utterance.voice = voice
        synthesizer.speak(utterance)
    }
    
    //MARK: -
    //MARK: -- 停止播放
    func stopSpeaking() {
        SpeakManager.shareManager.player.stop()
        SpeakManager.shareManager.player.currentTime = 0
        synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
    }
    
    //MARK: -
    //MARK: -- 播放器
    lazy var player:AVAudioPlayer = {
        
        print(self)
        
        let path = Bundle.main.path(forResource: "VoicePocket", ofType: "bundle")!.appendingFormat("/example.mp3")
        let url:URL = URL(fileURLWithPath: path)
        do{
            let audioManager:AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
            audioManager.prepareToPlay()
            
            return audioManager
            
        }catch{
            fatalError("多媒体播放器创建失败")
        }
        
    }()
}

