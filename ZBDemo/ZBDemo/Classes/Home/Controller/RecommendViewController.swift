//
//  RecommandViewController.swift
//  ZBDemo
//
//  Created by hh on 2018/1/12.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit

private let KItemMargin: CGFloat = 10
private let KItemW = (KScrrenW - 3 * KItemMargin) / 2
private let KNormalItemH = KItemW * 3 / 4
private let KPrettyItemH = KItemW * 4 / 3
private let KHeaderViewH: CGFloat = 50
private let KCyclerViewH: CGFloat = KScrrenW * 3 / 8
private let KGameViewH: CGFloat = 90

private let KNormalCellID = "KNormalCellID"
private let KHeaderViewID = "KHeaderViewID"
private let KPrettyViewID = "KPrettyViewID"


class RecommendViewController: UIViewController {
    private lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    //懒加载属性
    private lazy var collectionView: UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KItemW, height: KNormalItemH)
        layout.minimumLineSpacing = 0 //行间距
        layout.minimumInteritemSpacing = KItemMargin //item之间的间距
        layout.headerReferenceSize = CGSize(width: KScrrenW, height: KHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin)//设置内间距
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: KPrettyViewID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderViewID)
        return collectionView
        }()
    
    private lazy var recycleView: RecommendCycleView = {
        let recyclerView = RecommendCycleView.recommendCyclerView()
        recyclerView.frame = CGRect(x: 0, y: -(KCyclerViewH + KGameViewH), width: KScrrenW, height: KCyclerViewH)
        return recyclerView
    }()
    
    private lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -KGameViewH, width: KScrrenW, height: KGameViewH)
        return gameView
    }()
    
    
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI()
        loadData()
    }
    
}
//设置UI界面内容
extension RecommendViewController{
    private func setupUI(){
        //1.将UICollectionView添加到控制器的View中
        view.addSubview(collectionView)
        //2.将cycleView添加到UICollectionView中
        collectionView.addSubview(recycleView)
        //3.将gameView添加到UICollectionView中
        collectionView.addSubview(gameView)
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: (KCyclerViewH + KGameViewH), left: 0, bottom: 0, right: 0)
    }
}

//请求数据
extension RecommendViewController{
    private func loadData(){
        //1.请求推荐数据
        recommendVM.requestData(){
            //1.展示推荐数据
            self.collectionView.reloadData()
            //2.将数据传递给GageView
            var groups = self.recommendVM.anchorGroups
            //2.1删除前面两组数据
            groups.removeFirst()
            groups.removeFirst()
            //2.2添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            self.gameView.groups = groups
        }
        //2.请求轮播数据
        recommendVM.requestCycleData {
           self.recycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}
//遵守UICollectionView的数据协议
extension RecommendViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //0.取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        //1.获取cell
        var cell: BaseCollectionViewCell
        if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyViewID, for: indexPath) as! CollectionPrettyCell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath) as! CollectionViewNormalCell
        }
        //4.将模型赋值给cell
        cell.anchor = anchor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewID, for: indexPath) as! CollectionHeaderView
        //2.取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: KItemW, height: KPrettyItemH)
        }else{
            return CGSize(width: KItemW, height: KNormalItemH)
        }
    }
}
