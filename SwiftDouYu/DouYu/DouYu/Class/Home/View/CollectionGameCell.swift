//
//  CollectionGameCell.swift
//  DouYu
//
//  Created by yb on 2016/12/28.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var title: UILabel!

    
    var archor : ArchorGroup?{
    
        didSet{
            guard let archor = archor else { return }
            
            title.text = archor.tag_name
            
            if let iconURL = URL(string: archor.icon_url ?? ""){
                iconImg.kf.setImage(with: iconURL)

            }else{
                iconImg.image = UIImage(named: "")
            }
        
        }
    }
    
}
