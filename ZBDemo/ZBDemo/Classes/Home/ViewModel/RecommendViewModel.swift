//
//  RecommendViewModel.swift
//  ZBDemo
//
//  Created by hh on 2018/1/14.
//  Copyright © 2018年 inphase. All rights reserved.
//

import Foundation

class RecommendViewModel{
    //懒加载属性
    private lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
}
//发送网络请求
extension RecommendViewModel{
    func requestData(){
        //1.请求推荐书数据
        
        //2.请求颜值数据
        
        //3.请求后面部分的游戏数据
        NetworkTools.requestData(type: .POST, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate",parameters: ["limit":"4","offset":"0","time":NSDate.getCurrentTime()], finishedCallBack: { (result) in
            //1.将result转换成字典类型
            guard let resultDict = result as? [String:NSObject] else{return}
            //2.根据data获取key，获取数据
            guard let dataArray = resultDict["data"] as? [[String:NSObject]]else {return}
            //3.便利数据，获取字典，并且将字典转换成模型对象
            for dict in dataArray{
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
            for group in self.anchorGroups{
                print("item:\(group.tag_name) : \(group.room_list?.count)")
                for anchor in group.anchors{
                    print(anchor.nickname)
                }
            }
        })
    }
}
