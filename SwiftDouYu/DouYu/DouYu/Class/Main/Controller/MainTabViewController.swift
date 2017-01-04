//
//  MainTabViewController.swift
//  DouYu
//
//  Created by yb on 2016/12/20.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = UIColor.orange
        
        UINavigationBar.appearance().barTintColor = UIColor.orange
        
        addChildVC(childVC: "Home")
        addChildVC(childVC: "Live")
        addChildVC(childVC: "Focus")
        addChildVC(childVC: "Mine")
    }
    

}
extension MainTabViewController {
    fileprivate func addChildVC(childVC: String){
        let sb = UIStoryboard.init(name:childVC, bundle: nil)
        let Homevc = sb.instantiateInitialViewController()!
        self.addChildViewController(Homevc)
    }
}

