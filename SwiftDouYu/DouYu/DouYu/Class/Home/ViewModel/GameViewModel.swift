//
//  GameViewModel.swift
//  DouYu
//
//  Created by yb on 2016/12/30.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

class GameViewModel: BaseViewModel {
    

}

extension GameViewModel {
    
    //http://capi.douyucdn.cn/api/homeCate/getHotRoom?identification=ba08216f13dd1742157412386eee1225&client_sys=ios
    
    func loadGameData(finishedBack:  @escaping ()->Void) {
        
        loadArchorData(URLString: "http://capi.douyucdn.cn/api/homeCate/getHotRoom?identification=ba08216f13dd1742157412386eee1225&client_sys=ios", finishedBack: finishedBack)
    
    }
}
