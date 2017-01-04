//
//  FunnyViewController.swift
//  DouYu
//
//  Created by yb on 2016/12/30.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

class FunnyViewController: MainMenuAnchorViewController {

    fileprivate lazy var funnyViewModel : FunnyViewModel = FunnyViewModel()
    
}
//这个页面会先执行父类的viewdidload 方法， setupUI 和 loadData
extension FunnyViewController {
   
    override func loadData(){
        baseVM = funnyViewModel//将数据源交给父类
        funnyViewModel.loadFunnyData {
            self.collectionView.reloadData()
            var group = self.funnyViewModel.dataArr
            group.removeFirst()
            self.gameMenuView.dataArr = group
            self.loadDataFinished()
        }
    }
}

