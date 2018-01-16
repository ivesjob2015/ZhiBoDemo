//
//  RecommendCycleView.swift
//  ZBDemo
//
//  Created by hh on 2018/1/16.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit
private let KCycleCellID = "KCycleCellID"
class RecommendCycleView: UIView {
    //控件属性
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib(){
        super.awakeFromNib()
        //设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = .flexibleBottomMargin
        //注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: KCycleCellID)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
       
    }
}

extension RecommendCycleView{
    class func recommendCyclerView()-> RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}
//数据源
extension RecommendCycleView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCycleCellID, for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.blue : UIColor.green
        return cell
    }
}
