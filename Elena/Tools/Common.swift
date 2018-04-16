//
//  Common.swift
//  Elena
//
//  Created by Cain on 2018/3/21.
//  Copyright © 2018年 Cain. All rights reserved.
//

import Foundation
import UIKit

class Common: NSObject {
    
    class var screen_bounds:CGRect {
        get{
            return UIScreen.main.bounds
        }
    }
    
    class var screen_width:CGFloat {
        get{
            return screen_bounds.width
        }
    }
    
    class var screen_height:CGFloat {
        get{
            return screen_bounds.height
        }
    }

}
