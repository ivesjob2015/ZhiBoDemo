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
    class func requestData(type: MethodType,urlString: String,parameters: [String:NSString]? = nil,encoding: ParameterEncoding = URLEncoding.default,
                           headers: HTTPHeaders? = nil,finishedCallBack: @escaping (Any)->()){
        //获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(urlString, method: method, parameters: parameters,encoding: encoding, headers: headers).responseJSON { (response) in
            guard let result = response.result.value else{
                print("error:\(String(describing: response.result.error))")
                return
            }
            print("Request: \(String(describing: response.request))")   // original url request
            finishedCallBack(result as Any)
        }
    }
}
