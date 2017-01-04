//
//  BaseAnchorViewController.swift
//  DouYu
//
//  Created by yb on 2016/12/30.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

private let Cellmargin: CGFloat = 10

private let NormalCellID = "normalcell"
private let PrettyCellID = "PrettyCellID"
private let SectionHeaderID = "SectionHeaderID"

private let NormalCellW : CGFloat = (ScreenWidth - 3 * Cellmargin)/2.0
private let NormalCellH : CGFloat = NormalCellW * 3 / 4
private let PrettyCellH : CGFloat = NormalCellW * 4 / 3

class BaseAnchorViewController: BaseViewController {
    
    lazy var baseVM : BaseViewModel = BaseViewModel()
    
    fileprivate lazy var lastScrollOffsetY : CGFloat = 0

    lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: Cellmargin, bottom: 0, right: Cellmargin)
        layout.minimumInteritemSpacing = Cellmargin
        let view = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
        view.delegate = self!
        view.dataSource = self!
        view.backgroundColor = UIColor.white
        view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        view.register(UINib(nibName: "CommonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: NormalCellID)
        view.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: PrettyCellID)
        view.register(UINib(nibName: "CommonReusableHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: SectionHeaderID)
        return view
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadData()
    }

    
}

extension BaseAnchorViewController {
    
    override func setupUI(){
        contentView = collectionView
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(collectionView)
        super.setupUI()
    }
    
    func loadData(){
        
    
    }
}

extension BaseAnchorViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return baseVM.dataArr.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = baseVM.dataArr[section]
        return group.roomArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group = baseVM.dataArr[indexPath.section]
        let model = group.roomArr[indexPath.item]
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCellID, for: indexPath) as! CommonCollectionViewCell
        cell.archor = model
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionElementKindSectionHeader, withReuseIdentifier: SectionHeaderID, for: indexPath) as! CommonReusableHeadView
        if (baseVM.dataArr.count > 0) {
            header.archorGroup = self.baseVM.dataArr[indexPath.section]
        }
        return header
    }
}

extension BaseAnchorViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: NormalCellW, height: NormalCellH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let group = baseVM.dataArr[section]
        if group.room_list?.count == 0 {
            return CGSize.zero
        }
        return CGSize(width: ScreenWidth, height: 50)
    }
}
//MARK:-- 隐藏导航条
extension BaseAnchorViewController : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pan = scrollView.panGestureRecognizer
        let velocity = pan.velocity(in: scrollView).y
        if velocity < -5 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else if velocity > 5 {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let archor = baseVM.dataArr[indexPath.section].roomArr[indexPath.item]
        
        archor.isVertical == 0 ? normalRoom() : showRoom()
        
    }
    
    func normalRoom() {
        
        navigationController?.pushViewController(RoomNormalViewController(), animated: true)
        
    }
    func showRoom() {
        present(RoomShowViewController(), animated: true, completion: nil)
    }

    
}




