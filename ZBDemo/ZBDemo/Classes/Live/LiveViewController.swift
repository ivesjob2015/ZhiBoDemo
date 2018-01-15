//
//  LiveViewController.swift
//  ZBDemo
//
//  Created by hh on 2018/1/6.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit

class LiveViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//设置UI界面
extension LiveViewController{
     func setupUI(){
        // 1.设置导航栏
        setupNavigationBar()
    }
    private func setupNavigationBar(){
        // 1.设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
    }
}
