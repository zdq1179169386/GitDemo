//
//  UIColor+Extension.swift
//  DouYu
//
//  Created by yb on 2016/12/21.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r:CGFloat,g: CGFloat,b: CGFloat) {

        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}
