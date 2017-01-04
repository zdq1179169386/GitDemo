//
//  BaseViewController.swift
//  DouYu
//
//  Created by yb on 2016/12/20.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var contentView : UIView?
    
    fileprivate lazy var animImageView : UIImageView = {[weak self] in
    
        let imgView = UIImageView(image: UIImage(named: "img_loading_1"))
        imgView.center = self!.view.center
        imgView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        imgView.animationDuration = 0.5
        imgView.animationRepeatCount = LONG_MAX
        imgView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin];
        return imgView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

extension BaseViewController {
    func setupUI() {
        contentView?.isHidden = true
        view.addSubview(animImageView)
        animImageView.startAnimating()
        contentView?.backgroundColor = UIColor.white
        view.backgroundColor = UIColor.white
    }
    func loadDataFinished() {
        animImageView.stopAnimating()
        animImageView.isHidden = true
        contentView?.isHidden = false
    }
}
