//
//  MineMessageCell.swift
//  Elena
//
//  Created by Cain on 2018/3/21.
//  Copyright © 2018年 Cain. All rights reserved.
//

import UIKit

class MineMessageCell: UITableViewCell {

    var message:String? {

        didSet{
            
            let style:NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            style.minimumLineHeight = 5
            //行间距
            style.lineSpacing = 5
            //首行缩进
            style.firstLineHeadIndent = 10
            //头部缩进
            style.headIndent = 10
            //尾部缩进
            style.tailIndent = -10
            let attributeString:NSAttributedString = NSAttributedString(string: String.init(format: "\n%@\n", message!), attributes: [NSAttributedStringKey.paragraphStyle : style])
            label.attributedText = attributeString
            
            //计算message的宽度
            let rect:CGRect = message!.boundingRect(with: CGSize(), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: label.font], context: nil);
            
            //如果不需要换行
            if rect.size.width < Common.screen_width - (10 + 10 + 10 + 100) {

                label.textAlignment = NSTextAlignment.center
                label.snp.remakeConstraints { (make) in
                    make.top.equalTo(5)
                    make.trailing.equalTo(-10)
                    make.width.equalTo(rect.size.width + 20)
                    make.bottom.equalTo(contentView.snp.bottom).offset(-5)
                }
                
            }else{
                
                //多行显示时
                label.textAlignment = NSTextAlignment.left
                label.snp.remakeConstraints({ (make) in
                    make.top.equalTo(5)
                    make.leading.equalTo(100)
                    make.trailing.equalTo(-10)
                    make.bottom.equalTo(contentView.snp.bottom).offset(-5)
                })
                
            }
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.convertHexColorToRGBColor(hexColor: "eeeeee")
        selectionStyle = UITableViewCellSelectionStyle.none
        contentView.addSubview(label)

    }

    private lazy var label:UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.convertHexColorToRGBColor(hexColor: "d6e5f0")
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.layer.cornerRadius = 7
        label.clipsToBounds = true
        return label;
        
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
