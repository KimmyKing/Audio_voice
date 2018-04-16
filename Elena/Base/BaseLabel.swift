//
//  BaseLabel.swift
//  Elena
//
//  Created by Cain on 2018/3/29.
//  Copyright © 2018年 Cain. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {
    
    var contentInsets:UIEdgeInsets!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentInsets = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, contentInsets))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
