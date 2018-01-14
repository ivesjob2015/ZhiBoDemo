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

private let KNormalCellID = "KNormalCellID"
private let KHeaderViewID = "KHeaderViewID"
private let KPrettyViewID = "KPrettyViewID"


class RecommendViewController: UIViewController {
    
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
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: KNormalCellID)
        //collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader.self, withReuseIdentifier: KHeaderCellID)
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: KPrettyViewID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderViewID)
        return collectionView
        }()
    
    private lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    
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
        
    }
}

//请求数据
extension RecommendViewController{
    private func loadData(){
        recommendVM.requestData()
    }
}
//遵守UICollectionView的数据协议
extension RecommendViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 8
        }
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.定义cell
        let cell: UICollectionViewCell
        //2.获取cell
        if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyViewID, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewID, for: indexPath)
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
