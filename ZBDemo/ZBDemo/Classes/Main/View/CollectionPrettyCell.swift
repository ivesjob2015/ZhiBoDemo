//
//  CollectionPrettyCell.swift
//  ZBDemo
//
//  Created by hh on 2018/1/13.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionPrettyCell: BaseCollectionViewCell {
    //定义模型属性
    @IBOutlet weak var cityBtn: UIButton!
   
    
    override var anchor: AnchorModel?{
        didSet{
            super.anchor = anchor
            //3.所在的城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
