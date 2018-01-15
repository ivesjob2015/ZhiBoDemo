//
//  MainViewController.swift
//  ZBDemo
//
//  Created by hh on 2018/1/5.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVc(title: "主页",imageName: "btn_home_normal",storyName: "Home")
        addChildVc(title: "直播",imageName: "btn_live_normal",storyName: "Live")
        addChildVc(title: "关注",imageName: "btn_follow_normal",storyName: "Follow")
        addChildVc(title: "我的",imageName: "btn_user_normal",storyName: "Profile")
    }
    
    private func addChildVc(title: String,imageName: String,storyName: String){
        //添加控制器
        let navigationController = UINavigationController();
        // 底部bar名称
        navigationController.title = title;
        //默认图片
        navigationController.tabBarItem.image = UIImage(named: imageName)
        //选中后的图片¡
        //navigationController.tabBarItem.selectedImage = UIImage(named: "btn_home_normal_selected")
        //创建view控制器
        let storyboard = UIStoryboard(name: storyName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: storyName)
        
        // 顶部名称
        //            navigationController.view.tintColor = UIColor.red;
        //            navigationController.title = "主页"
        //将view控制器添加到导航控制器中
        navigationController.addChildViewController(controller)
        //将nav3添加到UITabBarController中
        addChildViewController(navigationController);
    }
    
}
