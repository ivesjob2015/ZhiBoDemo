//
//  RecommendGameView.swift
//  ZBDemo
//
//  Created by hh on 2018/1/17.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit

private let KGameCellID = "KGameCellID";
private let KEdgeInsetMargin: CGFloat = 10

class RecommendGameView: UIView {
    //蒂尼数据的属性
    var groups: [AnchorGroup]?{
        didSet{
            //删除前面两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            //添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            gameCollectionView.reloadData()
        }
    }
    //系统属性
    @IBOutlet weak var gameCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = .flexibleBottomMargin
        //gameCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: KGameCellID)
        gameCollectionView.register(UINib.init(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: KGameCellID)
        //给collectionView添加内边距
        gameCollectionView.contentInset = UIEdgeInsets(top: 0, left: KEdgeInsetMargin, bottom: 0, right: KEdgeInsetMargin)
    }
}

extension RecommendGameView{
    class func recommendGameView() ->RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gameCollectionView.dequeueReusableCell(withReuseIdentifier: KGameCellID, for: indexPath) as! CollectionGameCell
        cell.group = groups![indexPath.item]
        
        return cell
    }
    
    
}


