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
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModels: [CycleModel] = [CycleModel]()
    lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    lazy var prettyGroup: AnchorGroup = AnchorGroup()
    
}
//发送网络请求
extension RecommendViewModel{
    func requestData(finishCallback: @escaping ()->()){
        //0.定义参数
        let parameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]
        //创建group
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        //1.请求推荐书数据
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getCurrentTime()]) { (result) in
            //1.将result转换成字典类型
            guard let resultDict = result as? [String:NSObject] else{return}
            //2.根据data获取key，获取数据
            guard let dataArray = resultDict["data"] as? [[String:NSObject]]else {return}
            //3.遍历字典，转换模型对象
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_url = "home_header_normal"
            //获取主播数据
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            dispatchGroup.leave()
        }
        //2.请求颜值数据
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom",parameters: parameters) { (result) in
            //1.将result转换成字典类型
            guard let resultDict = result as? [String:NSObject] else{return}
            //2.根据data获取key，获取数据
            guard let dataArray = resultDict["data"] as? [[String:NSObject]]else {return}
            //3.遍历字典，转换模型对象
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_url = "home_header_phone"
            //获取主播数据
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dispatchGroup.leave()
        }
        //3.请求2-12后面部分的游戏数据
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate",parameters: parameters, finishedCallBack: { (result) in
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
                //print("item:\(group.tag_name) : \(group.room_list?.count)")
                for anchor in group.anchors{
                    //print(anchor.nickname)
                }
            }
            dispatchGroup.leave()
        })
        //4.所有的数据都请求到，之后进行排序
        dispatchGroup.notify(queue: .main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()
        }
    }
    
    //请求无线轮播的数据
    func requestCycleData(finishCallback: @escaping ()->()){
        NetworkTools.requestData(type: .GET, urlString: "http://www.douyutv.com/api/v1/slide/6",parameters: ["version":"2.300"]) { (result) in
            //1.获取整体字典数据
            guard let resultDict = result as? [String: NSObject ] else {return}
            //2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else {return}
            //3.字典转换模型对象
            for dict in dataArray{
                self.cycleModels.append(CycleModel(dict: dict))
            }
            finishCallback()
        }
    }
}
