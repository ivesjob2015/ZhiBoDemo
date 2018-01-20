//
//  AmuseViewController.swift
//  ZBDemo
//
//  Created by hh on 2018/1/20.
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

class AmuseViewController: UIViewController {
    //懒加载属性
    private lazy var amuseVM: AmuseViewModel = AmuseViewModel()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
}
extension AmuseViewController{
    fileprivate func setupUI(){
        view.addSubview(collectionView)
    }
}

extension AmuseViewController{
    fileprivate func loadData(){
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}

extension AmuseViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return amuseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amuseVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath) as! CollectionViewNormalCell
        cell.anchor = amuseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.group = amuseVM.anchorGroups[indexPath.section]
        return headerView
    }
}
