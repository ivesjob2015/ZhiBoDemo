//
//  GameViewModel.swift
//  ZBDemo
//
//  Created by hh on 2018/1/20.
//  Copyright © 2018年 inphase. All rights reserved.
//

import Foundation
import Moya

class GameViewModel{
    lazy var games: [GameModel] = [GameModel]()
}
extension GameViewModel{
    func loadAllGameData(finishCallBack: @escaping ()->()){
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName":""]) { (result) in
            // MARK:- 1.获取到数据
            guard let resultDict = result as? [String:Any] else {return}
            guard let dataArray = resultDict["data"] as?[[String:Any]] else{return}
            //2.字典转模型
            for dict in dataArray{
                self.games.append(GameModel(dict:dict))
            }
            //完成回调
            finishCallBack()
        }
    }
}
