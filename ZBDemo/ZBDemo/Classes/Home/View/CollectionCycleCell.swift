//
//  CollectionCycleCell.swift
//  ZBDemo
//
//  Created by hh on 2018/1/17.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    //定义模型属性
    var cycleModel: CycleModel?{
        didSet{
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with: iconURL)
           // iconImageView.kf.setImage(with: iconURL as! Resource,placeholder:UIImage(named: "Img_default"))
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
