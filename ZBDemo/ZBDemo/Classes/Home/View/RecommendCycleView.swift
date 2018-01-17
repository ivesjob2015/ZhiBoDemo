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
    //定义属性
    var cycleTimer: Timer?
    var cycleModels: [CycleModel]?{
        didSet{
            //1.刷新collectionView
            collectionView.reloadData()
            //2.设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            //3.默认滚动到中间
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            //4.添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    //控件属性
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib(){
        super.awakeFromNib()
        //设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = .flexibleBottomMargin
        //注册cell
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: KCycleCellID)
        
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: KCycleCellID)
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
        return (cycleModels?.count ?? 0) * 10000
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCycleCellID, for: indexPath) as! CollectionCycleCell
        let cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        cell.cycleModel = cycleModel
        return cell
    }
}
//遵守UICollectionView的代理协议
extension RecommendCycleView: UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width/2
        //计算pageCOntrol的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycleTimer()
    }
}

//对定时器的操作方法
extension RecommendCycleView{
    private func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
        
    }
    
    private func removeCycleTimer(){
        cycleTimer?.invalidate()//从运行循环中移除
        cycleTimer = nil
    }
    
    @objc private func scrollToNext(){
        //1.获取滚动的偏移量
        let currentOffSetX = collectionView.contentOffset.x
        let offSetX = currentOffSetX + collectionView.bounds.width
        //2.滚动该位置
        collectionView.setContentOffset(CGPoint(x:offSetX,y:0), animated: true)
    }
}



