//
//  UIColor+Extension.swift
//  Elena
//
//  Created by Cain on 2018/3/21.
//  Copyright © 2018年 Cain. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    
    //MARK: -
    //MARK: -- 将16进制颜色转换为三原色
    class func convertHexColorToRGBColor(hexColor:String) -> UIColor {
        
        //截取前2个字符
        let redString = String.init(hexColor.prefix(2))
        
        //截取前2个字符
        let blueString = String.init(hexColor.suffix(2))
        
        let greenString = hexColor.subStringWith(nsRange: NSMakeRange(2, 2))
        
        var red:CUnsignedInt = 0, green:CUnsignedInt = 0, blue:CUnsignedInt = 0
        
        Scanner(string: redString).scanHexInt32(&red)
        Scanner(string: greenString ?? "").scanHexInt32(&green)
        Scanner(string: blueString).scanHexInt32(&blue)
        
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random()%256)/256.0, green: CGFloat(arc4random()%256)/256.0, blue: CGFloat(arc4random()%256)/256.0, alpha: 1.0)  
    }
    
}

