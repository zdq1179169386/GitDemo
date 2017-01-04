//
//  CycleModel.swift
//  DouYu
//
//  Created by yb on 2016/12/28.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    
    var title : String?
    
    var pic_url : String?
    
    var room : [String : Any]?{
        didSet{
            guard let room = room else { return }
            anchor = ArchorModel(dict: room)
        }
    }
    
    // 主播信息对应的模型对象
    var anchor : ArchorModel?
    
    init(dict: [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    

}
