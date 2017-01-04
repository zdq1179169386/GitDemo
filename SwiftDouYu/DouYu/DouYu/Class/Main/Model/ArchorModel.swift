//
//  ArchorModel.swift
//  DouYu
//
//  Created by yb on 2016/12/27.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

class ArchorModel: NSObject {
    
    var nickname : String?
    
    var vertical_src :String?
    
    var room_src : String?
    
    var game_name : String?
    
    var online : Int = 0
    
    var room_name : String?
    
    var room_id : String?
    
    var isVertical : Int = 0
    
    /// 所在城市
    var anchor_city : String?
    
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }

}
