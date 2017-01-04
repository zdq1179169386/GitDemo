//
//  FunnyViewModel.swift
//  DouYu
//
//  Created by yb on 2016/12/30.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

//http://capi.douyucdn.cn/api/homeCate/getHotRoom?identification=393b245e8046605f6f881d415949494c&client_sys=ios
class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel {
    
    func loadFunnyData(finishedBack:  @escaping ()->Void) {
        
        loadArchorData(URLString: "http://capi.douyucdn.cn/api/homeCate/getHotRoom?identification=393b245e8046605f6f881d415949494c&client_sys=ios", finishedBack: finishedBack)
        
    }

}
