//
//  UIBarButtonItem+Extension.swift
//  DouYu
//
//  Created by yb on 2016/12/20.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    class func barButtonItem(img: String,higlihtImg: String?, size : CGSize?) -> UIBarButtonItem{
        
        let btn = UIButton()
        btn.setImage(UIImage(named: img), for: .normal)
        if higlihtImg != nil {
            btn.setImage(UIImage(named: higlihtImg!), for: .highlighted)
        }
        if size != nil {
            btn.frame = CGRect(origin: .zero, size: size!)
        }else{
            btn.sizeToFit()
        }
        let Item = UIBarButtonItem(customView: btn)
        return Item
    }
    //便利构造函数
    convenience init(img: String,higlihtImg: String = "", size : CGSize = CGSize.zero,target: Any?, action: Selector?){
        
        let btn = UIButton()
        btn.setImage(UIImage(named: img), for: .normal)
        if higlihtImg != "" {
            btn.setImage(UIImage(named: higlihtImg), for: .highlighted)
        }
        if size != CGSize.zero {
            btn.frame = CGRect(origin: .zero, size: size)
        }else{
            btn.sizeToFit()
        }
        if target != nil && action != nil {
            btn.addTarget(target!, action: action!, for: .touchUpInside)
        }
        self.init(customView: btn)
        
    }
}
