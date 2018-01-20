//
//  GameViewController.swift
//  ZBDemo
//
//  Created by hh on 2018/1/20.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit

private let KEdgeMargin: CGFloat = 10
private let KItemW: CGFloat = (KScrrenW - 2 * KEdgeMargin) / 3
private let KItemH: CGFloat = KItemW * 6 / 5
private let KGameCellID = "KGameCellID"
private let KGameHeaderID = "KGameHeaderID"
private let KHeaderViewH: CGFloat = 50
private let KGameViewH: CGFloat = 90

class GameViewController: UIViewController {
    // MARK: 懒加载属性
    fileprivate lazy var gameVM: GameViewModel = GameViewModel()
    fileprivate lazy var topHeaderView: CollectionHeaderView = {
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(KHeaderViewH + KGameViewH), width: KScrrenW, height: KHeaderViewH)
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.titleLabel.text = "常见"
        headerView.moreBtn.isHidden = true
        return headerView
    }()
    fileprivate lazy var gameView: RecommendGameView = {
       let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -KGameViewH, width: KScrrenW, height: KGameViewH)
        return gameView
    }()
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KItemW, height: KItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: KEdgeMargin, bottom: 0, right: KEdgeMargin)
        layout.headerReferenceSize = CGSize(width: KScrrenW, height: KHeaderViewH)
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: KGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KGameHeaderID)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.dataSource = self
        return collectionView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}
extension GameViewController{
    fileprivate func setupUI(){
        //1.添加UICollectionView
        view.addSubview(collectionView)
        //2.添加顶部的HeaderView
        collectionView.addSubview(topHeaderView)
        //3.将常用游戏的view添加到CollectionView中
        collectionView.addSubview(gameView)
        //4.设置CollectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: KHeaderViewH + KGameViewH, left: 0, bottom: 0, right: 0)
    }
}
extension GameViewController{
    fileprivate func loadData(){
        gameVM.loadAllGameData {
            //1.展示全部游戏
            self.collectionView.reloadData()
            //2.展示常用游戏
            let groups = self.gameVM.games[0..<10]
            self.gameView.groups = Array(groups)
        }
    }
}

extension GameViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // MARK:- 获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameCellID, for: indexPath) as! CollectionGameCell
        
        let gameModel = gameVM.games[indexPath.item]
        cell.baseGame = gameModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出headerview
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KGameHeaderID, for: indexPath) as! CollectionHeaderView
        //2.给headerView设置属性
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }
}

