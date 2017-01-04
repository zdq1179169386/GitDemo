//
//  GameMenuViewCell.swift
//  DouYu
//
//  Created by yb on 2016/12/30.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

private let CollectionGameCellID = "CollectionGameCell"


class GameMenuViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!

    var dataArr : [ArchorGroup]?{
    
        didSet{
        
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: CollectionGameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cellW = (self.bounds.width - 1) / 4
        let cellH = (self.bounds.height - 1) / 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellW, height: cellH)
        
    }
    
    
}

extension GameMenuViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionGameCellID, for: indexPath) as! CollectionGameCell
        cell.archor = dataArr![indexPath.item]
        return cell
    }
}

extension GameMenuViewCell : UICollectionViewDelegate {
    
}
