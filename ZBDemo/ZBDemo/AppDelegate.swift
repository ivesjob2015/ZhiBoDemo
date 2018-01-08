//
//  AppDelegate.swift
//  ZBDemo
//
//  Created by hh on 2018/1/4.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        //1 创建根控制器，在根控制器中添加三个字控制器
//        let tab = UITabBarController();
//        tab.title = "tabtabtab";
//        //2 根据类名Test01NC添加控制器
//        let n1 = createController(childControllerName:"Test01NC", title: "测试项一", image: "logo")
//        tab.addChildViewController(n1);
//        //3 根据类名Test02NC添加控制器
//        let n2 = createController(childControllerName:"Test02NC", title: "测试项二", image: "logo")
//        tab.addChildViewController(n2);
//        //4 添加控制器
//        let nav3 = HomeViewController();
//        // 底部bar名称
//        nav3.title = "测试项三";
//        //默认图片
//        nav3.tabBarItem.image = UIImage(named: "logo")
//        //选中后的图片
//        nav3.tabBarItem.selectedImage = UIImage(named: "logo")
//        //创建view控制器
//        let vc3 = UIViewController();
//        //设置view为灰色
//        vc3.view.backgroundColor = UIColor.gray;
//        // 顶部名称
//        vc3.view.tintColor = UIColor.red;
//        vc3.title = "测试项三"
//        //将view控制器添加到导航控制器中
//        nav3.addChildViewController(vc3)
//        //将nav3添加到UITabBarController中
//        tab.addChildViewController(nav3);
//        // 设置根控制器
//        window?.rootViewController = tab;
//        // 显示
//        window?.makeKeyAndVisible();
        return true
    }
    func createController(childControllerName: String, title: String, image: String) ->UINavigationController {
        // 创建对象
        let childController:UIViewController = UIViewController()
        // 1.1 设置首页tabbar对应的数据
        childController.tabBarItem.image = UIImage(named: image)
        childController.tabBarItem.selectedImage = UIImage(named: image + "_highlighted")

        childController.title = title
        // 2 给首页包装一个导航控制器
        let nav = UINavigationController()
        nav.addChildViewController(childController)
        return nav;
        
    }
}

