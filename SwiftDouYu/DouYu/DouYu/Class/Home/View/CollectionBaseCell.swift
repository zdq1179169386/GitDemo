//
//  CollectionBaseCell.swift
//  DouYu
//
//  Created by yb on 2016/12/28.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var roomUrlImg: UIImageView!
    @IBOutlet weak var onlineUser: UIButton!
    
    
    var archor : ArchorModel? {
    
        didSet {
        
            guard let archor = archor else { return }
            
            var onlineStr : String = ""
            if archor.online >= 10000 {
                onlineStr = "\(Int(archor.online / 10000))万人在线"
            }else{
                onlineStr = "\(archor.online)人在线"
            }
            onlineUser.setTitle(onlineStr, for: .normal)
            
            self.roomName.text = archor.nickname
            
            guard let iconURL = URL(string: archor.vertical_src!) else { return }
            roomUrlImg.kf.setImage(with: iconURL)
            
        }
        
    }
    
    
}
