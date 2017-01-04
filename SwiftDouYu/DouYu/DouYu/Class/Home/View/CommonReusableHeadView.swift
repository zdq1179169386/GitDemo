//
//  CommonReusableHeadView.swift
//  DouYu
//
//  Created by yb on 2016/12/23.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

class CommonReusableHeadView: UICollectionReusableView {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var sectionName: UILabel!

    
    var archorGroup : ArchorGroup?{
        didSet{
            self.sectionName.text = archorGroup?.tag_name
            self.icon.image = UIImage(named: "btn_live_selected")
        }
    }
    
}


