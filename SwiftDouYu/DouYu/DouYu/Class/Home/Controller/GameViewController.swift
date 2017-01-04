//
//  GameViewController.swift
//  DouYu
//
//  Created by yb on 2016/12/29.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit


class GameViewController: MainMenuAnchorViewController {
    
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    
}
//这个页面会先执行父类的viewdidload 方法， setupUI 和 loadData
extension GameViewController {
      override func loadData(){
        baseVM = gameVM//将数据源交给父类
        gameVM.loadGameData {
            self.collectionView.reloadData()
            var group = self.gameVM.dataArr
            group.removeFirst()
            self.gameMenuView.dataArr = group
            self.loadDataFinished()

            
        }
    }
}

