//
//  PageContentView.swift
//  ZBDemo
//
//  Created by hh on 2018/1/8.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    func pageContentView(contentView: PageContentView,progress: CGFloat,sourceIndex: Int,targetIndex: Int)
}

private let ContentCellID = "ContentCellID";
class PageContentView: UIView {
    
    //定义属性
    private var childVcs: [UIViewController]
    private weak var parentViewController: UIViewController?
    private var startoffsetX: CGFloat = 0
    weak var delegate: PageContentViewDelegate?
    private var isForbidSourceDelegate: Bool = false
    
    private lazy var collectionView: UICollectionView = {[weak self] in
        //1.创建layout
        let layout  = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!//强制解包
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
        }()
    
    init(frame: CGRect,childVcs: [UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame:frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView{
    fileprivate func setupUI(){
        //将所有的子控制器添加到父控制器中
        for childVc in childVcs{
            parentViewController?.addChildViewController(childVc)
        }
        //添加UICollectionView，用于在cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}

//遵守UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        for view in cell.subviews{
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.bounds
        cell.addSubview(childVc.view)
        
        return cell
    }
}

//遵守UICollectionViewDelegate监听滚动
extension PageContentView: UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidSourceDelegate = false
        startoffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //0.判断是否是点击事件
        if isForbidSourceDelegate{return}
        //获取必要的数据
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        //2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startoffsetX{//左滑
            //1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)//floor为取整数
            //2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            //3.计算targetIndex
            targetIndex = sourceIndex+1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count-1
            }
            //4.如果完全划过去
            if currentOffsetX - startoffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
        }else{//右滑
            //计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))//floor为取整数
            //2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            //3.计算sourceIndex
            sourceIndex = targetIndex+1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count-1
            }
        }
        //3.将progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//对外暴露的方法
extension PageContentView{
    func setCurrentIndex(currentIndex: Int) {
        //记录需要禁止直行代理方法
        isForbidSourceDelegate = true
        //2.滚动到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
    }
}


