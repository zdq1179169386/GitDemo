//
//  GameMenuView.swift
//  DouYu
//
//  Created by yb on 2016/12/30.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

private let GameMenuCellID = "GameMenuCellID"

class GameMenuView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var dataArr : [ArchorGroup]? {
        didSet{
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "GameMenuViewCell", bundle: nil), forCellWithReuseIdentifier: GameMenuCellID)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
    }

}

extension GameMenuView {
    class func creatGameMenuView() -> GameMenuView{
        return Bundle.main.loadNibNamed("GameMenuView", owner: nil, options: nil)?.first as! GameMenuView
    }
}

extension GameMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataArr = dataArr else { return 0 }
        let page = (dataArr.count - 1) / 8 + 1
        pageControl.numberOfPages = page
        return page
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameMenuCellID, for: indexPath) as! GameMenuViewCell
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        if endIndex > (dataArr?.count)! - 1 {
            endIndex = (dataArr?.count)! - 1
        }
        
        cell.dataArr = Array(dataArr![startIndex...endIndex])
        return cell
        
    }
    
}

extension GameMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
