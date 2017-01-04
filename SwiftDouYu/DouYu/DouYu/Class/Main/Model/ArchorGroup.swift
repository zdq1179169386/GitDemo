//
//  ArchorGroup.swift
//  DouYu
//
//  Created by yb on 2016/12/27.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

class ArchorGroup: NSObject {
    
    var room_list : [[String : Any]]?{
    
        didSet{
            for dict in room_list!{
                self.roomArr.append(ArchorModel(dict: dict))
            }
            
        }
    }
    
    var icon_url : String?
    var tag_name : String?
    var roomArr : [ArchorModel] = [ArchorModel]()
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    override init(){
        super.init()
    }
    

}
