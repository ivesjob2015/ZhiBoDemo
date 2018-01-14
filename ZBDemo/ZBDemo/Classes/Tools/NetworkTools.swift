//
//  NetworkTools.swift
//  NetWorkSample
//
//  Created by hh on 2018/1/13.
//  Copyright © 2018年 inphase. All rights reserved.
//

import Foundation
import Alamofire

enum MethodType {
    case GET
    case POST
}
class NetworkTools{
    class func requestData(type: MethodType,urlString: String,parameters: [String:NSString]? = nil, finishedCallBack: @escaping (AnyObject)->()){
        //获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else{
                print("error:\(response.result.error)")
                return
            }
            finishedCallBack(result as AnyObject)
        }
    }
}
