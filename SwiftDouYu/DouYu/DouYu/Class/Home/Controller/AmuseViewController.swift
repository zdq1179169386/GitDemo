//
//  AmuseViewController.swift
//  DouYu
//
//  Created by yb on 2016/12/30.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

class AmuseViewController: MainMenuAnchorViewController {

    fileprivate lazy var amuseViewModel : AmuseViewModel = AmuseViewModel()
    
}

extension AmuseViewController {
    
    
    override func loadData(){
        super.loadData()
        baseVM = amuseViewModel
        
        amuseViewModel.loadAmuseData{
            self.collectionView.reloadData()
            var group = self.amuseViewModel.dataArr
            group.removeFirst()
            self.gameMenuView.dataArr = group
            self.loadDataFinished()
        }
    }
}
