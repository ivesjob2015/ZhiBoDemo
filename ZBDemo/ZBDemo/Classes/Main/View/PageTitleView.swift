//
//  PageTitleView.swift
//  ZBDemo
//
//  Created by hh on 2018/1/7.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit
private let KScrollLineH: CGFloat = 2
class PageTitleView: UIView {
    
    private var titles: [String]
    
    private lazy var titleLabels: [UILabel] = [UILabel]()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    init(frame: CGRect,titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    //自定义构造函数或者重写构造函数必须实现的方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension PageTitleView{
    private func setupUI(){
        //添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        //添加title对应的label
        setupTitleLabels()
        //设置底线和滚动的滑块
        setupBottomLineAddScrollLine()
    }
    
    private func setupTitleLabels(){
        //确定label的一些framge值
        let labelW: CGFloat = frame.width/CGFloat(titles.count)
        let labelH: CGFloat = frame.height
        let labelY: CGFloat = 0
        for(index,title) in titles.enumerated(){
            //创建UILabel
            let label = UILabel()
            //设置label属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            //设置label的frame
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //将label添加到scrollview中
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    private func setupBottomLineAddScrollLine(){
        //添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //添加scrollLine
        guard let firstLabel = titleLabels.first else {return }
        firstLabel.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - KScrollLineH, width: firstLabel.frame.width, height: KScrollLineH)
    }
}
