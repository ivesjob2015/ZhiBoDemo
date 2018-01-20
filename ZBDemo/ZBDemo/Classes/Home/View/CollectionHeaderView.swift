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
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
//从xib中快速创建的类方法
extension CollectionHeaderView{
    class func collectionHeaderView()-> CollectionHeaderView{
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}

