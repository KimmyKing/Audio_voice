//
//  String+Extension.swift
//  Elena
//
//  Created by Cain on 2018/3/27.
//  Copyright © 2018年 Cain. All rights reserved.
//

import Foundation

extension String {
    
    //MARK: -
    //MARK: -- 截取范围字符串
    func subStringWith(nsRange: NSRange) -> String? {
        //将NSRange转换为Range类型
        guard let range:Range = Range(nsRange ,in: self) else { return nil }
        let subSting = self[range]
        return String.init(subSting)
    }
    
    
}
