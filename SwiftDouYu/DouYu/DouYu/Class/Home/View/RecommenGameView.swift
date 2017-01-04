//
//  RecommenGameView.swift
//  DouYu
//
//  Created by yb on 2016/12/28.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

private let CollectionGameCellID = "CollectionGameCell"

class RecommenGameView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var archorModels : [ArchorGroup]?{
    
        didSet{
//            guard let archorModels = archorModels else { return }
            collectionView.reloadData()
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: CollectionGameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 80, height: 90)
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
    }

}




extension RecommenGameView {
    
    class func creatRecommenGameView() -> RecommenGameView{
        return Bundle.main.loadNibNamed("RecommenGameView", owner: nil, options: nil)?.first as! RecommenGameView
    }
}

extension RecommenGameView : UICollectionViewDelegate {
    
}

extension RecommenGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return archorModels?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionGameCellID, for: indexPath) as! CollectionGameCell
        cell.archor = archorModels![indexPath.item]
        return cell
    }
}
