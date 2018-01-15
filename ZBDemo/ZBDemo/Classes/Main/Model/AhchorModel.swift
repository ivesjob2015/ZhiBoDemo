//
//  AhchorModel.swift
//  ZBDemo
//
//  Created by hh on 2018/1/14.
//  Copyright © 2018年 inphase. All rights reserved.
//

import Foundation
@objcMembers
class AnchorModel: NSObject{
    var room_id: String = ""
    var vertical_src: String = ""
    var isVertical: Int = 0
    var room_name: String = ""
    var nickname: String = ""
    //var online: String = ""
    var anchor_city: String = ""
    
    init(dict: [String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
