//
//  BaseCollectionViewCell.swift
//  ZBDemo
//
//  Created by hh on 2018/1/15.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    //定义模型属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameBtn: UILabel!
    @IBOutlet weak var onLineBtn: UIButton!
    var anchor: AnchorModel?{
        didSet{
            //0.校验模型是否有值
            guard let anchor = anchor else{return}
            //1.取出在线人数显示的文字
            let online = 666
            var onLineStr: String = ""
            if online >= 10000{
                onLineStr = "\(Int(online / 10000))万在线"
            }else{
                onLineStr = "\(online)在线"
            }
            onLineBtn.setTitle(onLineStr, for: .normal)
            
            //2.昵称的显示
            nickNameBtn.text = anchor.nickname
            //3.设置封面
            guard let iconURL = URL(string: anchor.vertical_src) else {return}
            iconImageView.kf.setImage(with: iconURL)
        }
    }
}
