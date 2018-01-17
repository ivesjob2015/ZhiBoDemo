//
//  CollectionGameCell.swift
//  ZBDemo
//
//  Created by hh on 2018/1/17.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit
import  Kingfisher

class CollectionGameCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    //定义模型属性
    var group: AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            let iconUrl = URL(string: group?.icon_url ?? "")
            //iconImageView.kf.setImage(with: iconUrl)
            
            iconImageView.kf.setImage(with: iconUrl, placeholder: UIImage(named: "home_more_btn"))
            //home_more_btn
        }
    }
    
    override func awakeFromNib() {
        
    }
}
