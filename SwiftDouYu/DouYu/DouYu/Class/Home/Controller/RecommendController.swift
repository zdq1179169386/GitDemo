//
//  CommonController.swift
//  DouYu
//
//  Created by yb on 2016/12/22.
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
 
private let CycleViewH = ScreenWidth * 3 / 7

private let GameViewH : CGFloat = 90


class RecommendController: BaseAnchorViewController {
    
    fileprivate lazy var recommenVM : RecommenViewModel = RecommenViewModel()
    
    fileprivate lazy var recommenCyleView: RecommenCycleView = {
        
        let view = RecommenCycleView.creatRecommenCycleView()
        view.frame = CGRect(x: 0, y: -(CycleViewH + GameViewH), width: ScreenWidth, height: CycleViewH)
        return view
    }()
    fileprivate lazy var recommenGameView : RecommenGameView = {
        let view = RecommenGameView.creatRecommenGameView()
        view.frame = CGRect(x: 0, y: -GameViewH, width: ScreenWidth, height: GameViewH)
        return view
        
    }()
    
}
extension RecommendController {
    override func setupUI(){
        super.setupUI()
        self.view.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        collectionView.addSubview(recommenCyleView)
        collectionView.addSubview(recommenGameView)
        collectionView.contentInset = UIEdgeInsetsMake(CycleViewH + GameViewH, 0, 0, 0)
    }
}
extension RecommendController {
    override func loadData(){
        baseVM = recommenVM
        
        recommenVM.requestData(finishedBack: {
            self.collectionView.reloadData()
            var groups = self.recommenVM.dataArr
            //删掉最热
            groups.removeFirst()
            groups.removeFirst()
            
            //将颜值移到第二位
            //            let archorGroup = groups.first
            //            groups.removeFirst()
            //            groups.insert(archorGroup!, at: 1)
            //添加更多
            let more = ArchorGroup()
            more.tag_name = "更多"
            groups.append(more)
            print(groups.count)
            self.recommenGameView.archorModels = groups
            
            self.loadDataFinished()
            
        })
        //请求轮播数据
        recommenVM.requestCycleData {
            self.recommenCyleView.cycleModels = self.recommenVM.cycleModels
        }
        
    }
}

extension RecommendController{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1{
            
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: PrettyCellID, for: indexPath) as! CollectionPrettyCell
            prettyCell.archor = recommenVM.dataArr[indexPath.section].roomArr[indexPath.item]
            return prettyCell
        }else{
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
}
extension RecommendController{
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: NormalCellW, height: PrettyCellH)
        }
        return CGSize(width: NormalCellW, height: NormalCellH)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let group = recommenVM.dataArr[section]
        if group.room_list?.count == 0 {
            return CGSize.zero
        }
        return CGSize(width: ScreenWidth, height: 50)
    }
}



