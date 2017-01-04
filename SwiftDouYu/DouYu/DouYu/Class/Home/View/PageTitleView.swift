//
//  PageTitleView.swift
//  DouYu
//
//  Created by yb on 2016/12/20.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

private let scrollLineH : CGFloat = 2

private let SelectedColor:(CGFloat,CGFloat,CGFloat) = (255,128,0)

private let NormalColor: (CGFloat,CGFloat,CGFloat) = (85,85,85)

//class 说明这个协议只能被类准守
protocol PageTitleViewDelegate: class {
    func pageTitleViewClick(titleView: PageTitleView, seleectedIndex index: Int)
}

class PageTitleView: UIView {
    
    var titles : [String]
    
    fileprivate var lastLabel : UILabel?
    //代理
    weak var delegate : PageTitleViewDelegate?
    
    fileprivate lazy var scrollview : UIScrollView = {
    
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine : UILabel = {
        
        let line = UILabel()
        line.backgroundColor = UIColor.orange

        return line
    }()
    
    
    //装所有label
    fileprivate lazy var labels : [UILabel] = [UILabel]()
    
    
    init(frame:CGRect,param:[String]) {
        self.titles = param
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



}

extension PageTitleView {
    fileprivate func setupUI() {
        
        addSubview(scrollview)
        scrollview.frame = bounds
        setupLabels()
        
    }
    
    fileprivate func setupLabels(){
        let labelW = frame.width / CGFloat(titles.count)
        //使用enumerated能同时拿到index，和title
        for (index,title) in titles.enumerated(){
            
            let label = UILabel()
            label.text = title
            label.tag = index
            label.frame = CGRect(x: labelW * CGFloat(index), y: 0, width: labelW, height: frame.height - scrollLineH)
            label.textAlignment = .center
            label.textColor = UIColor(r: NormalColor.0, g: NormalColor.1, b: NormalColor.2)
            label.font = UIFont.systemFont(ofSize: 16)
            scrollview.addSubview(label)
            labels.append(label)
            
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action:#selector(self.labelClick(tapGes:)) )
            label.addGestureRecognizer(tap)
            
        }
        
        let bottomLine = UILabel()
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - 0.5, width: frame.width, height: 0.5)
        addSubview(bottomLine)
        
        guard let firstLabe = labels.first else{ return }
        firstLabe.textColor = UIColor(r: SelectedColor.0, g: SelectedColor.1, b: SelectedColor.2)
        lastLabel = firstLabe
        scrollview.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabe.frame.origin.x, y: frame.height - scrollLineH, width: firstLabe.frame.width, height: scrollLineH)
        
    }
}


extension PageTitleView {
    
    @objc fileprivate func labelClick(tapGes :UITapGestureRecognizer){
        let currentLabel = tapGes.view as! UILabel
        if currentLabel == lastLabel {return}
        currentLabel.textColor = UIColor(r: SelectedColor.0, g: SelectedColor.1, b: SelectedColor.2)
        lastLabel?.textColor =  UIColor(r: NormalColor.0, g: NormalColor.1, b: NormalColor.2)
        //记录上一个label
        lastLabel = currentLabel
        UIView.animate(withDuration: 0.15) { 
             self.scrollLine.frame = CGRect(x: currentLabel.frame.origin.x, y: self.frame.height - scrollLineH, width: currentLabel.frame.width, height: scrollLineH)
        }
       //
        self.delegate?.pageTitleViewClick(titleView: self, seleectedIndex: currentLabel.tag)
    }
}

extension PageTitleView {
    func setTitleScroll(progress: CGFloat, sourceIndex : Int,targetIndex: Int) {
        let sourceLabel = labels[sourceIndex]
        let targetLabel = labels[targetIndex]
       let totalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
       let moveX = totalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        let colorRange = (SelectedColor.0 - NormalColor.0, SelectedColor.1 - NormalColor.1, SelectedColor.2 - NormalColor.2)
       sourceLabel.textColor = UIColor(r: SelectedColor.0 - colorRange.0 * progress, g: SelectedColor.1 - colorRange.1 * progress, b: SelectedColor.2 - colorRange.2 * progress)
        targetLabel.textColor = UIColor(r: NormalColor.0 + colorRange.0 * progress, g: NormalColor.1 + colorRange.1 * progress, b: NormalColor.2 + colorRange.2 * progress)
        //记录上一个label
        lastLabel = targetLabel
    }
}




