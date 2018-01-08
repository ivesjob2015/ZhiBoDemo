//
//  PageContentView.swift
//  ZBDemo
//
//  Created by hh on 2018/1/8.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit

class PageContentView: UIView {

    //定义属性
    private var childVcs: [UIViewController]
    private var parentViewController: UIViewController
    
     init(frame: CGRect,childVcs: [UIViewController], parentViewController: UIViewController) {
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
    private func setupUI(){
        
    }
}
