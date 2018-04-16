//
//  BaseTextField.swift
//  Elena
//
//  Created by Cain on 2018/3/21.
//  Copyright © 2018年 Cain. All rights reserved.
//

import UIKit

class BaseTextField: UITextField,UITextFieldDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareTextFieldWithDefaultSetting()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareTextFieldWithDefaultSetting()
    }
    
    //MARK: -
    //MARK: -- 自定义构造方法
    init(frame:CGRect, holder:String?) {
        super.init(frame: frame)
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 2
        clipsToBounds = true
        placeholder = holder
        prepareTextFieldWithDefaultSetting()
        
    }
    
    //MARK: -
    //MARK: -- 默认设置
    func prepareTextFieldWithDefaultSetting() {
        let spaceView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        leftView = spaceView
        leftViewMode = UITextFieldViewMode.always
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

