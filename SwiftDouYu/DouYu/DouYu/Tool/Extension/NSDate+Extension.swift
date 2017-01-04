//
//  NSDate+Extension.swift
//  DouYu
//
//  Created by yb on 2016/12/27.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import Foundation

extension NSDate {
    ///获取当前时间
    class func getCurrentTime() ->(String){
        
        let now = NSDate()
       let interval = Int(now.timeIntervalSince1970)
        return "\(interval)"
        
    }
}
