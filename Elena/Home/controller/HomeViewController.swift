//
//  ViewController.swift
//  Elena
//
//  Created by Cain on 2018/3/21.
//  Copyright © 2018年 Cain. All rights reserved.
//
import UIKit
import SnapKit
import AVFoundation

class HomeViewController: UIViewController, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        view.addSubview(toolView)
        view.addSubview(customNavigationView)
        view.addSubview(chatMessageListView)
        view.addSubview(speechStateLabel)
        view.addSubview(speechButton)

        view.bringSubview(toFront: customNavigationView)
        view.bringSubview(toFront: toolView)
        view.bringSubview(toFront: speechButton)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }


    //MARK: -
    //MARK: -- 键盘弹出的通知
    @objc func keyboardWillShow(noti:Notification) {

        let duration = noti.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let changeFrame = noti.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect
        let changeY = Common.screen_height - changeFrame.origin.y

        textField.isHidden = false
        speechButton.isHidden = true
        keyBoardButton.isSelected = true
        sendButton.isSelected = true
        
        UIView.animate(withDuration: duration, animations: {
            self.toolView.transform = CGAffineTransform(translationX: 0, y: -changeY)
            self.chatMessageListView.transform = CGAffineTransform(translationX: 0, y: -changeY)
        }) { (finish) in

        }
    }

    //MARK: -
    //MARK: -- 键盘收起的通知
    @objc func keyboardWillHide(noti:Notification) {

        let duration = noti.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double

        textField.isHidden = true
        speechButton.isHidden = false
        keyBoardButton.isSelected = false
        sendButton.isSelected = false
        
        UIView.animate(withDuration: duration, animations: {
            self.toolView.transform = CGAffineTransform.identity
            self.chatMessageListView.transform = CGAffineTransform.identity
        }) { (finish) in

        }

    }

    //MARK: -
    //MARK: -- 点击键盘按钮
    @objc func clickKeyboardButton(sender:UIButton) {
        if sender.isSelected {
            textField.resignFirstResponder()
        }else{
            textField.becomeFirstResponder()
        }
    }

    //MARK: -
    //MARK: -- 长按语音按钮
    @objc func longPressSpeechButton(gestureRecognizer:UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            
            //关闭播放器(语音播放或音频文件)
            SpeakManager.shareManager.stopSpeaking()
            
            //关闭录音
            self.recordManager.isRecordingFinal = false
            
            speechStateLabel.isHidden = false
            weak var weakSelf = self
            recordManager.startRecording(handle: { (lastSpeech) in
                //加入数据源
                weakSelf?.viewModel.receiveMessage(message: lastSpeech)
                weakSelf?.chatMessageListView.reloadData()

                if weakSelf?.viewModel.question == .Music {
                    SpeakManager.shareManager.player.play()
                }
            })
        }

        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            speechStateLabel.isHidden = true
            self.recordManager.isRecordingFinal = true
        }

    }

    //MARK: -
    //MARK: -- 点击发送按钮
    @objc func clickSendButton(sender:UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if textField.text?.count == 0 {
            return
        }else{
            textField.resignFirstResponder()
            viewModel.receiveMessage(message: textField.text!)
            chatMessageListView.reloadData()
            
            if viewModel.question == .Music {
                SpeakManager.shareManager.player.play()
            }
        }
    }

    @objc func tapChatMessageView() {
        textField.resignFirstResponder()
    }

    //MARK: -
    //MARK: -- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chatMessageMArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if viewModel.isMineChatCell(index: indexPath.row) {

            let mineCell:MineMessageCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MineMessageCell.self), for: indexPath) as! MineMessageCell
            mineCell.message = viewModel.selectModelWith(index: indexPath.row)
            return mineCell

        }else{

            let otherCell:OtherMessageCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(OtherMessageCell.self), for: indexPath) as! OtherMessageCell
            otherCell.message = viewModel.selectModelWith(index: indexPath.row)
            return otherCell

        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        toolView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalTo(view)
            make.height.equalTo(50)
        }

        keyBoardButton.snp.makeConstraints { (make) in
            make.left.equalTo(toolView).offset(10)
            make.centerY.equalTo(toolView)
            make.width.height.equalTo(30)
        }

        sendButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(view).offset(-10)
            make.top.width.height.equalTo(keyBoardButton)
        }

        textField.snp.makeConstraints { (make) in
            make.leading.equalTo(keyBoardButton.snp.trailing).offset(10)
            make.height.top.equalTo(keyBoardButton)
            make.trailing.equalTo(sendButton.snp.leading).offset(-10)
        }

        speechButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(-20)
            make.centerX.equalTo(toolView)
        }
        
        customNavigationView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(0)
            make.height.equalTo(172)
        }
        
        serviceImgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(customNavigationView.snp.centerY).offset(10)
            make.centerX.equalTo(customNavigationView)
        }

        chatMessageListView.snp.makeConstraints { (make) in
            make.top.equalTo(customNavigationView.snp.bottom)
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(toolView.snp.top)
        }

        speechStateLabel.snp.makeConstraints { (make) in
            make.center.equalTo(view)
        }
    }

    //MARK: -
    //MARK: -- 懒加载
    lazy var viewModel:ChatViewModel = {
        let viewModel = ChatViewModel()
        return viewModel
    }()
    
    lazy var serviceImgView:UIImageView = {
       
        let serviceImgView = UIImageView(image: UIImage.init(named: "elena"))
        return serviceImgView
        
    }()
    
    lazy var customNavigationView:UIView = {
       
        let customNavigationView = UIView()
        customNavigationView.backgroundColor = UIColor.convertHexColorToRGBColor(hexColor: "d5ac6c")
        customNavigationView.addSubview(serviceImgView)
        return customNavigationView
        
    }()

    lazy var chatMessageListView:UITableView = {
        let chatMessageListView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        chatMessageListView.backgroundColor = UIColor.convertHexColorToRGBColor(hexColor: "eeeeee")
        chatMessageListView.rowHeight = UITableViewAutomaticDimension
        chatMessageListView.estimatedRowHeight = 100.0
        chatMessageListView.separatorStyle = UITableViewCellSeparatorStyle.none
        chatMessageListView.dataSource = self
        chatMessageListView.register(MineMessageCell.self, forCellReuseIdentifier: NSStringFromClass(MineMessageCell.self))
        chatMessageListView.register(OtherMessageCell.self, forCellReuseIdentifier: NSStringFromClass(OtherMessageCell.self))

        chatMessageListView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapChatMessageView)))
        return chatMessageListView
    }()

    lazy var toolView:UIView = {
        let toolView = UIView()
        toolView.addSubview(keyBoardButton)
        toolView.addSubview(textField)
        toolView.addSubview(sendButton)
        return toolView
    }()
    
    lazy var speechButton:UIButton = {
        let speechButton = UIButton()
        speechButton.setImage(UIImage.init(named: "speech"), for: UIControlState.normal)
        
        //添加长按手势
        let longPress:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressSpeechButton(gestureRecognizer:)))
        longPress.minimumPressDuration = 0
        speechButton.addGestureRecognizer(longPress)
        
        return speechButton
    }()
    
    lazy var keyBoardButton:UIButton = {
        let keyBoardButton = UIButton.init()
        keyBoardButton.setImage(UIImage.init(named: "keyboard"), for: UIControlState.normal)
        keyBoardButton.setImage(UIImage.init(named: "speech"), for: UIControlState.selected)
        keyBoardButton.addTarget(self, action: #selector(clickKeyboardButton(sender:)), for: UIControlEvents.touchUpInside)
        return keyBoardButton
    }()

    lazy var textField:BaseTextField = {
        let textField = BaseTextField(frame:CGRect.zero, holder: "请输入您想要查询的内容")
        textField.isHidden = true
        textField.clearsOnBeginEditing = true
        return textField
    }()

    lazy var sendButton:UIButton = {
        let sendButton = UIButton()
        sendButton.setImage(UIImage.init(named: "add"), for: UIControlState.normal)
        sendButton.setImage(UIImage.init(named: "send"), for: UIControlState.selected)
        sendButton.addTarget(self, action: #selector(clickSendButton(sender:)), for: UIControlEvents.touchUpInside)
        return sendButton
    }()

    lazy var speechStateLabel:UILabel = {
        let speechStateLabel = UILabel()
        speechStateLabel.isHidden = true
        speechStateLabel.text = "录音中..."
        speechStateLabel.textAlignment = NSTextAlignment.center
        return speechStateLabel
    }()

    lazy var recordManager:RecordManager = RecordManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        weak var weakSelf = self
        
        recordManager.getAuthorizationStatus { (isEnable) in
            DispatchQueue.main.async {
                weakSelf?.speechButton.isEnabled = isEnable
            }
        }
    }
    
    deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
    }
}


