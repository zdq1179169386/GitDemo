//
//  AmuseViewModel.swift
//  DouYu
//
//  Created by yb on 2016/12/30.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {
    
}


extension AmuseViewModel {
    func loadAmuseData(finishedBack:  @escaping ()->Void) {
        
        loadArchorData(URLString: "http://capi.douyucdn.cn/api/homeCate/getHotRoom?identification=9acf9c6f117a4c2d02de30294ec29da9&client_sys=ios", finishedBack: finishedBack)
        
    }
}
