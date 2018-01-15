//
//  CollectionViewNormalCell.swift
//  ZBDemo
//
//  Created by hh on 2018/1/13.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: BaseCollectionViewCell {

    @IBOutlet weak var roomNameLabel: UILabel!
    
   
    //定义模型属性
    override var anchor: AnchorModel?{
        didSet{
              super.anchor = anchor
            
            //房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
