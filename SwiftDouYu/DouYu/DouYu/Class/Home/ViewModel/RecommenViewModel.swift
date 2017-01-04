//
//  RecommenViewModel.swift
//  DouYu
//
//  Created by yb on 2016/12/27.
//  Copyright © 2016年 朱德强. All rights reserved.
//

//http://capi.douyucdn.cn/api/v1/slide/6?version=2.410&client_sys=ios 轮播图

import UIKit

class RecommenViewModel: BaseViewModel {
    
    
    fileprivate var fisrtGroup : ArchorGroup?
    fileprivate var secondGroup : ArchorGroup?

    lazy var cycleModels : [CycleModel] = [CycleModel]()
}

extension RecommenViewModel {
    
    func requestData(finishedBack:@escaping () -> Void){
        //http://capi.douyucdn.cn/api/v1/getHotCate?aid=ios&client_sys=ios&time=1482803100&auth=46c51256fee942f82ffb7563ce018c5b
        //        http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&client_sys=ios&offset=0
        //        http://capi.douyucdn.cn/api/v1/getbigDataRoom?client_sys=ios
        
        //创建线程组
        let Dgroup = DispatchGroup()
        
        //推荐
        Dgroup.enter()
        NetworkTool.request(type: .Get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom?client_sys=ios") { (result, error) in
            guard let resultDict = result as? [String : Any] else{ return }
            guard let data = resultDict["data"] as? [[String : Any]] else{ return }
            let group = ArchorGroup()
            var arr : [ArchorModel] = [ArchorModel]()
            for dict in data {
                let model = ArchorModel(dict: dict)
                arr.append(model)
                //                print(model.game_name,model.room_name)
            }
            group.roomArr = arr
            group.tag_name = "最热"
            //请求到数据leave
            self.secondGroup = group
            Dgroup.leave()
            //            print("请求到最热数据")
            
        }
        
        //颜值
        Dgroup.enter()
        NetworkTool.request(type: .Get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&client_sys=ios&offset=0") { (result, error) in
            //            print(result,error)
            
            guard let resultDict = result as? [String : Any] else{ return }
            guard let data = resultDict["data"] as? [[String : Any]] else{ return }
            
            let group = ArchorGroup()
            var arr : [ArchorModel] = [ArchorModel]()
            for dict in data {
                let model = ArchorModel(dict: dict)
                arr.append(model)
            }
            group.roomArr = arr
            group.tag_name = "颜值"
            //请求到数据leave
            self.fisrtGroup = group
            Dgroup.leave()
            //            print("请求到颜值数据")
            
        }
        let param = ["aid":"ios","client_sys":"ios","auth":"46c51256fee942f82ffb7563ce018c5b","time":NSDate.getCurrentTime()]
        //进入
        Dgroup.enter()
        //将下面的请求抽取到父类中去实现
        loadArchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: param) { 
            Dgroup.leave()

        }
//        NetworkTool.request(type: .Get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: param) { (result, error) in
//            guard let resultDict = result as? [String : AnyObject] else{ return }
//            guard let data = resultDict["data"] as? [[String : Any]] else{ return }
//            for (_,dataDict) in data.enumerated(){
//                
//                let archor = ArchorGroup(dict: dataDict)
//                self.dataArr.append(archor)
//                //                print(archor.roomArr.first?.game_name)
//            }
//            //请求到数据leave
//            Dgroup.leave()
//            //            print("请求到8个数据")
//        }
        
        
        //通知分线程,上面几个请求按顺序完成了
        Dgroup.notify(queue: DispatchQueue.main) {
            
            //这里面的颜值数据是空的，所以把它删掉
//            for (index,group) in self.dataArr.enumerated() {
//                if group.tag_name == "颜值"{
//                    self.dataArr.remove(at: index)
//                }
//            }
            self.dataArr.insert(self.fisrtGroup!, at: 0)//插入颜值数据
            self.dataArr.insert(self.secondGroup!, at: 0)//插入最热数据
            //再回调
            finishedBack()
        }
        
    }
    
    //请求无线轮播数据
    func requestCycleData(finishBack:@escaping () -> Void) {
        NetworkTool.request(type: .Get, URLString: "http://capi.douyucdn.cn/api/v1/slide/6?version=2.410&client_sys=ios") { (result, error) in
            guard let resultDict = result as? [String : Any] else{return}
            guard let data = resultDict["data"] as? [[String : Any]] else{ return }
            for dict in data{
               
                self.cycleModels.append( CycleModel(dict: dict))
            }
            finishBack()
        }
        
    }
}
