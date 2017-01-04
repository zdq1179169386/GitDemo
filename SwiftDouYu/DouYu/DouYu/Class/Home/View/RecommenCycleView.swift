//
//  RecommenCycleView.swift
//  DouYu
//
//  Created by yb on 2016/12/28.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

private let RecommenCycleCellID = "RecommenCycleCellID"

class RecommenCycleView: UIView {
    
    fileprivate var cycleTimer : Timer?
    
    var cycleModels : [CycleModel]?{
    
        didSet{
            guard let cycleModels = cycleModels else { return }
        
            self.collectionView.reloadData()
            self.pageControl.numberOfPages = cycleModels.count
            
            let indexPath = IndexPath(item: cycleModels.count * 50, section: 0)
            
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            //添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.register(UINib(nibName: "RecommenCycleCell", bundle: nil), forCellWithReuseIdentifier: RecommenCycleCellID)
//        //设置该控件不随父控件拉伸二拉伸
//        autoresizingMask = UIViewAutoresizing()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
    }
}

extension RecommenCycleView {
    class func creatRecommenCycleView()-> RecommenCycleView{
    
        return Bundle.main.loadNibNamed("RecommenCycleView", owner: nil, options: nil)?.first as! RecommenCycleView
    }
}

extension RecommenCycleView : UICollectionViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        let currentIndex = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
        self.pageControl.currentPage = currentIndex
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
    
}

extension RecommenCycleView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommenCycleCellID, for: indexPath) as! RecommenCycleCell
        cell.cycleModel = cycleModels![indexPath.item % (cycleModels?.count)!]
        return cell
    }
}

extension RecommenCycleView {
    fileprivate func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    fileprivate func removeCycleTimer(){
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    @objc fileprivate func scrollToNext(){
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
}
