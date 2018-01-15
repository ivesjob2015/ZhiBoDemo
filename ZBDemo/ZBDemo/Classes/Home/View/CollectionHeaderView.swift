//
//  CollectionHeaderView.swift
//  ZBDemo
//
//  Created by hh on 2018/1/13.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    
    //定义模型属性
    var group: AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_url ?? "home_header_normal")
            
//            //定义URL对象
//            let url = URL(string: "http://hangge.com/blog/images/logo.png")
//            //从网络获取数据流
//            let data = try! Data(contentsOf: url!)
//            //通过数据流初始化图片
//            let newImage = UIImage(data: data)
//            iconImageView.image = newImage
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
