//
//  MoblieGameViewController.swift
//  DouYu
//
//  Created by yb on 2016/12/30.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit


class MoblieGameViewController: MainMenuAnchorViewController {
    
    fileprivate lazy var moblieGameViewModel : MoblieGameViewModel = MoblieGameViewModel()

}

extension MoblieGameViewController {
    

    override func loadData(){
        super.loadData()
        baseVM = moblieGameViewModel
        
        moblieGameViewModel.loadMoblieGameData {
            self.collectionView.reloadData()
            var group = self.moblieGameViewModel.dataArr
            group.removeFirst()
            self.gameMenuView.dataArr = group
            self.loadDataFinished()

        }
    
    }
}
