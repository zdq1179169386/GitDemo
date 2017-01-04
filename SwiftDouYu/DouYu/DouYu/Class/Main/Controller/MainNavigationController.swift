//
//  MainNavigationController.swift
//  DouYu
//
//  Created by yb on 2016/12/20.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController,UIGestureRecognizerDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        interactivePopGestureRecognizer?.delegate = self
//        interactivePopGestureRecognizer?.isEnabled = true
        setupFullScreenPop()
        
    }


    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }

}
//MARK：-- 设置全屏返回
extension MainNavigationController {
    func setupFullScreenPop() {
        
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        guard let gesView = systemGes.view else { return }
        
        //        var count : UInt32 = 0
        //
        //        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        //
        //        for i in 0..<count {
        //            let ivar = ivars[Int(i)]
        //
        //            let name = ivar_getName(ivar)
        //            print(String(cString:name!))
        //
        //        }
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        
        guard let targetObjc = targets?.first else { return }
        
        guard let target = targetObjc.value(forKey: "target") else { return }
        
        let action = Selector(("handleNavigationTransition:"))
        
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)

    }
}
