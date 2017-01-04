//
//  HomeViewController.swift
//  DouYu
//
//  Created by yb on 2016/12/20.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    fileprivate lazy var stopView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 20))
        view.backgroundColor = UIColor.black
        return view
    }()
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let view = PageTitleView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 40), param: ["推荐","手游","娱乐","游戏","趣玩"])
        view.delegate = self!
        return view
    }()
    
    fileprivate lazy var pagecontentView : PageContentView = {[weak self] in
        let frame = CGRect(x: 0, y:  40, width: ScreenWidth, height: ScreenHeight - (60 + TabbarH))
        var  childVcs = [UIViewController]()
        let vc = RecommendController()
        let moblieVC = MoblieGameViewController()
        let gameVC = GameViewController()
        let amuseVC = AmuseViewController()
        let funnyVC = FunnyViewController()
        childVcs.append(vc)
        childVcs.append(moblieVC)
        childVcs.append(amuseVC)
        childVcs.append(gameVC)
        childVcs.append(funnyVC)
        let view = PageContentView(frame: frame, childVcs: childVcs, parentViewController: self!)
        view.delegate = self!
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    //重新修改 HomeViewController 的view的frame
    override func viewDidLayoutSubviews() {
        if (self.navigationController?.navigationBar.isHidden)! {
            self.view.frame = CGRect(x: 0, y: 20, width: ScreenWidth, height: ScreenHeight - TabbarH + 20)
        }else{
            self.view.frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight - StatusBarH - NavgavitionBarH - TabbarH )
        }
    }
}

extension HomeViewController {
    fileprivate func setupUI(){
        
        if self.responds(to: #selector(getter: edgesForExtendedLayout)) {
            self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        }
        
        let window = UIApplication.shared.keyWindow
        window?.backgroundColor = UIColor.white
        

        setupNavBar()
        automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(pageTitleView)
        self.view.addSubview(pagecontentView)
        
    }
    func scrollNotify(notify: Notification) {
        if notify.name == Notification.Name(rawValue: "ScrollToTop"){
            print("ScrollToTop")
            self.view.frame = CGRect(x: 0, y: -44, width: ScreenWidth, height: ScreenHeight - 20)
        }else{
        }
    }
    
    
    fileprivate func setupNavBar(){
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(img: "logo",target: nil, action: nil)
        let size = CGSize(width: 35, height: 35)
        let searchItem = UIBarButtonItem(img: "btn_search", higlihtImg: "btn_search_clicked", size: size, target: self, action: #selector(HomeViewController.searchClick))
        let scanItem = UIBarButtonItem(img: "Image_scan", higlihtImg: "Image_scan_click", size: size, target: self, action: #selector(HomeViewController.scanClick))
        
        let clockItem = UIBarButtonItem(img: "btn_clock",size: size, target: self, action: #selector(HomeViewController.clockClick))
        
        self.navigationItem.rightBarButtonItems = [searchItem,scanItem,clockItem];

    }
    
    
}
//MARK:-- 点击事件
extension HomeViewController{
    @objc fileprivate func searchClick(){
        
    }
    @objc fileprivate func scanClick(){
        
    }
    @objc fileprivate func clockClick(){
        
    }
}

//MARK:-- PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate{
    
    func pageTitleViewClick(titleView: PageTitleView, seleectedIndex index: Int) {
        print(index)
        pagecontentView.setCurrentIndex(index: index)
    }
}
//MAR:// -- PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate {
    func pageContentViewScroll(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        pageTitleView.setTitleScroll(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

extension HomeViewController {
    override var prefersStatusBarHidden: Bool{
        return false
    }
}


