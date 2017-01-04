//
//  CommonCollectionViewCell.swift
//  DouYu
//
//  Created by yb on 2016/12/23.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit
import Kingfisher

class CommonCollectionViewCell: CollectionBaseCell {

    @IBOutlet weak var roomIcon: UIImageView!
    @IBOutlet weak var tagName: UILabel!


    override var archor : ArchorModel?{
        didSet {
            //将属性传给父类
            super.archor = archor
            
            self.tagName.text = archor?.room_name

        }
    }
}
