//
//  BaseViewModel.swift
//  ZBDemo
//
//  Created by hh on 2018/1/20.
//  Copyright © 2018年 inphase. All rights reserved.
//

import Foundation

class BaseViewModel{
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel{
    func loadAnchorData(url:String, params: [String:Any]? = nil,finishCallBack: @escaping()->()){
        NetworkTools.requestData(type: .GET, urlString: url,parameters: params) { (result) in
            guard let resultDict = result as? [String:Any] else{return}
            guard let dataArray = resultDict["data"] as? [[String:Any]] else {return}
            for dict in dataArray{
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            finishCallBack()
           
        }
    }
}
