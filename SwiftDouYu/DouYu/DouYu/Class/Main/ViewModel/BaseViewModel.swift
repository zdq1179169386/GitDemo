//
//  BaseViewModel.swift
//  DouYu
//
//  Created by yb on 2016/12/30.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var dataArr: [ArchorGroup] = [ArchorGroup]()
    
}

extension BaseViewModel {
    
    func  loadArchorData(URLString : String,parameters : [String : Any]? = nil, finishedBack:@escaping ()-> Void) {
        
        NetworkTool.request(type: .Get, URLString: URLString ,parameters: parameters) { (result, error) in
            
            guard let resultDict = result as? [String : Any] else{return}
            guard let data = resultDict["data"] as? [[String : Any]] else{return}
            
            for dict in data{
                self.dataArr.append(ArchorGroup(dict: dict))
            }
            
            finishedBack()
            
        }

    }
    
}
