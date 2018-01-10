//
//  Home1ViewController.swift
//  ZBDemo
//
//  Created by hh on 2018/1/6.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit
private let KTitlteViewH:CGFloat = 40
class HomeViewController: UINavigationController {
    
    //懒加载属性
    private lazy var  pageTitleView: PageTitleView = {[weak self]in
        let titleFram = CGRect(x: 0, y: KStatusBarH+KNavigationBarH, width: KScrrenW, height: KTitlteViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFram, titles:titles)
        titleView.backgroundColor = UIColor.white
        titleView.delegate = self
        return titleView
        }()
    
    private lazy var pageContentView: PageContentView = {[weak self] in
        //1.确认内容的frame
        let contentH = KScrrenH - KStatusBarH - KNavigationBarH - KTitlteViewH
        let contentFrame = CGRect(x: 0, y: KStatusBarH+KNavigationBarH+KTitlteViewH, width: KScrrenW, height: contentH)
        //2.确定所有的子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
//设置UI界面
extension HomeViewController{
    func setupUI(){
        //不需要调整UIScrollView的内边距 
        automaticallyAdjustsScrollViewInsets = false
        //设置导航栏
        setupNavigationBar()
        //添加titleView
        view.addSubview(pageTitleView)
        //添加ContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.green
    }
    private func setupNavigationBar(){
        let size = CGSize(width:40,height:40)
        //设置左侧的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "image_my_history", highImgeName: "logo", size: size)
        self.navigationItem.hidesBackButton = false
        
        //设置右侧的item
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImgeName: "image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImgeName: "btn_search_click", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImgeName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
}
//遵守PageTitleViewDelete协议
extension HomeViewController: PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}
//遵循PageContentViewDelegate协议
extension HomeViewController: PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
