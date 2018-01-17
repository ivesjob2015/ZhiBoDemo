//
//  CycleModel.swift
//  ZBDemo
//
//  Created by hh on 2018/1/17.
//  Copyright © 2018年 inphase. All rights reserved.
//

import Foundation
@objcMembers
class CycleModel: NSObject{
    var title: String = ""
    var pic_url: String = ""
    var anchor: AnchorModel?
    var room: [String:NSObject]?{
        didSet{
            guard let room = room else{return}
            anchor = AnchorModel(dict: room)
        }
    }
    
    init(dict: [String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
