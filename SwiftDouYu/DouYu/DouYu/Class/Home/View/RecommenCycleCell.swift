//
//  RecommenCycleCell.swift
//  DouYu
//
//  Created by yb on 2016/12/28.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit
import Kingfisher
class RecommenCycleCell: UICollectionViewCell {

    @IBOutlet weak var imgName: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    var cycleModel : CycleModel?{
        
        didSet{
        
            guard let cycleModel = cycleModel else { return }
            let imgURL = URL(string: cycleModel.pic_url ?? "")!
            imgName.kf.setImage(with: imgURL)
            title.text = cycleModel.title
            
        }
    }
    

}
