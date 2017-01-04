//
//  MoblieGameViewModel.swift
//  DouYu
//
//  Created by yb on 2016/12/30.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

class MoblieGameViewModel: BaseViewModel {

}

extension MoblieGameViewModel {
    
    
    func loadMoblieGameData(finishedBack:  @escaping ()->Void) {
        
        loadArchorData(URLString: "http://capi.douyucdn.cn/api/homeCate/getHotRoom?identification=3e760da75be261a588c74c4830632360&client_sys=ios", finishedBack: finishedBack)
        
    }

}
