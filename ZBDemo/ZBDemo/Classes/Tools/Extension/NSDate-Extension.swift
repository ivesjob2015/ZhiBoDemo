//
//  NSDate-Extension.swift
//  ZBDemo
//
//  Created by hh on 2018/1/14.
//  Copyright © 2018年 inphase. All rights reserved.
//

import Foundation

extension NSDate{
    class func getCurrentTime()->NSString{
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return NSString.init(string: "\(interval)")
    }
}
