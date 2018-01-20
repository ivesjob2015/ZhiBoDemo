//
//  BaseGameModel.swift
//  ZBDemo
//
//  Created by hh on 2018/1/20.
//  Copyright © 2018年 inphase. All rights reserved.
//

import Foundation

@objcMembers
class BaseGameModel: NSObject{
    var tag_name: String = ""
    var icon_url: String = ""
    
    override init() {
        
    }
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
