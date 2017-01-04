//
//  CollectionPrettyCell.swift
//  DouYu
//
//  Created by yb on 2016/12/23.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit
import Kingfisher


class CollectionPrettyCell: CollectionBaseCell {

    @IBOutlet weak var location: UIButton!


   override var archor : ArchorModel?{
        didSet {
            super.archor = archor
            location.setTitle(archor?.anchor_city, for: .normal)
        }
    }
}
