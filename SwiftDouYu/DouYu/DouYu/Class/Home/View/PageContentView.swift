//
//  PageContentView.swift
//  DouYu
//
//  Created by yb on 2016/12/20.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit



protocol PageContentViewDelegate:class {
    func pageContentViewScroll(contentView: PageContentView,progress: CGFloat,sourceIndex : Int,targetIndex : Int)
}

class PageContentView: UIView {
    
    weak var delegate : PageContentViewDelegate?
    
    fileprivate var childVcs : [UIViewController]
    
    fileprivate weak var parentViewController : UIViewController?
    
    fileprivate var isForbidScrollDelegate : Bool = false
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
    
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self!.bounds.size
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let frame = CGRect(x: 0, y: 0, width: self!.frame.width, height: self!.frame.height)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self!
        collectionView.dataSource = self!
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    fileprivate var startOffsetX : CGFloat = 0
    
    
    init(frame: CGRect,childVcs: [UIViewController], parentViewController: UIViewController) {
    
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
extension PageContentView {
    fileprivate func setupUI(){
        for (_, childVc) in childVcs.enumerated(){
            self.parentViewController?.addChildViewController(childVc)
        }
        
        addSubview(collectionView)
    }
}

extension PageContentView: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }

        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}
//MARK:-- 对外暴露的方法
extension PageContentView {
    
    
    func setCurrentIndex(index:Int) {
        isForbidScrollDelegate = true
        let offsetx = CGFloat(index) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetx, y: 0), animated: false)
        
    }
}

extension PageContentView: UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        startOffsetX = scrollView.contentOffset.x
        isForbidScrollDelegate = false
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelegate { return }
        
        let currentOffsetX = scrollView.contentOffset.x
        
        var progress : CGFloat = 0.0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let scrollviewW = scrollView.bounds.width
        
        if currentOffsetX < startOffsetX { //右滚
//            print("向右滚")
            progress = 1 - (currentOffsetX/scrollviewW - floor(currentOffsetX/scrollviewW))
//            print(progress)
            
            targetIndex = Int(currentOffsetX / scrollviewW)
            sourceIndex = targetIndex + 1
            if targetIndex <= 0 {
                targetIndex = 0
            }
            
            
        }else{//左滚
//            print("向左滚")
            progress = currentOffsetX/scrollviewW - floor(currentOffsetX/scrollviewW)
//            print(progress)
            sourceIndex = Int(currentOffsetX / scrollviewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            if currentOffsetX - startOffsetX == scrollviewW {
                progress = 1
                targetIndex = sourceIndex
            }

        }
        
//        print(progress,sourceIndex,targetIndex)
        
        self.delegate?.pageContentViewScroll(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}
