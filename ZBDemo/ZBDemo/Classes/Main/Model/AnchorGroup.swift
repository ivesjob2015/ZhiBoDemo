//
//  AnchorGroup.swift
//  ZBDemo
//
//  Created by hh on 2018/1/14.
//  Copyright © 2018年 inphase. All rights reserved.
//

import Foundation
@objcMembers
class AnchorGroup: BaseGameModel {
    //该组房间信息
    var room_list: [[String:NSObject]]?{
        didSet{
            guard let room_list = room_list else{return}
            for dict in room_list{
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    //定义主播的模型对象数组
    lazy var anchors: [AnchorModel] = [AnchorModel]()
}
