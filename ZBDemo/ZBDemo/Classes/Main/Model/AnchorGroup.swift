//
//  AnchorGroup.swift
//  ZBDemo
//
//  Created by hh on 2018/1/14.
//  Copyright © 2018年 inphase. All rights reserved.
//

import Foundation
@objcMembers
class AnchorGroup: NSObject {
    //该组房间信息
    var room_list: [[String:NSObject]]?{
        didSet{
            guard let room_list = room_list else{return}
            for dict in room_list{
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    var tag_name: String = ""
    var icon_url: String = "home_header_normal"
    //定义主播的模型对象数组
    lazy var anchors: [AnchorModel] = [AnchorModel]()
    
    override init() {
        super.init()
    }
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        //print(key)
    }
    
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list"{
//            if let dataArray = value as? [[String: NSObject]]{
//                for dict in dataArray{
//                    anchors.append(AnchorModel(dict: dict))
//                }
//            }
//        }
//    }
    
    
}
