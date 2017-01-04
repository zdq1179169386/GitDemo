//
//  NetworkTool.swift
//  DouYu
//
//  Created by yb on 2016/12/23.
//  Copyright © 2016年 朱德强. All rights reserved.
//

import UIKit
import Alamofire

enum RequestType {
    case Get
    case Post
}

class NetworkTool: NSObject {
    
    class func request(type : RequestType, URLString : String, parameters : [String: Any]? = nil, finished: @escaping (( _ result : AnyObject?,  _ error : NSError?)->())){
        let method = type == RequestType.Get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON{(response) in
            guard let result = response.result.value else{
                print("请求失败= %@",response.result.error)
                finished(nil, response.result.error! as NSError)
                return
            }
            finished(result as AnyObject?, nil)
        
        }
    
        
        
    }

}
