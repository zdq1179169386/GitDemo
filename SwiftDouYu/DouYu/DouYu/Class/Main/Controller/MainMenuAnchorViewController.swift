//
//  MainMenuAnchorViewController.swift
//  DouYu
//
//  Created by yb on 2016/12/30.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

private let GameMenuViewH : CGFloat = 200


class MainMenuAnchorViewController: BaseAnchorViewController {

    
    lazy var  gameMenuView: GameMenuView = {
        let view = GameMenuView.creatGameMenuView()
        view.frame = CGRect(x: 0, y: -GameMenuViewH, width: ScreenWidth, height: GameMenuViewH)
        return view
    }()

}

extension MainMenuAnchorViewController {
    
    override func setupUI(){
        //执行父类的setupUI方法，添加collectionView
        super.setupUI()
        collectionView.addSubview(gameMenuView)
        collectionView.contentInset = UIEdgeInsets(top: GameMenuViewH, left: 0, bottom: 0, right: 0)
        
    }


}
