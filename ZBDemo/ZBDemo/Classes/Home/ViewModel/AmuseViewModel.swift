//
//  AmuseViewModel.swift
//  ZBDemo
//
//  Created by hh on 2018/1/20.
//  Copyright © 2018年 inphase. All rights reserved.
//

import Foundation

class AmuseViewModel: BaseViewModel{
    func loadAmuseData(finishCallBack: @escaping ()->()){
        loadAnchorData(url: "http://capi.douyucdn.cn/api/v1/getHotRoom/2",  finishCallBack: finishCallBack)
    }
}
