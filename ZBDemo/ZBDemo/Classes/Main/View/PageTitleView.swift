//
//  PageTitleView.swift
//  ZBDemo
//
//  Created by hh on 2018/1/7.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView: PageTitleView,selectedIndex index: Int)
}

private let KScrollLineH: CGFloat = 2
class PageTitleView: UIView {
    
    //定义属性
    private var currentIndex: Int = 0
    private var titles: [String]
    weak var delegate: PageTitleViewDelegate?
    
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
    func setupUI(){
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
            
            //3.设置label的frame
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.将label添加到scrollview中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //5.给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
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
//监听label的点击
extension PageTitleView{
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer){
        //1.获取当前label
        guard let currentLabel = tapGes.view as?  UILabel else{return}
        //2.获取之前的labe
        let oldLabel = titleLabels[currentIndex]
        
        //3.切换文字的颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        
        //4.保存最新label的下标值
        currentIndex = currentLabel.tag
        
        //5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
    }
}

//暴露对外的方法
extension PageTitleView{
    func setTitleWithProgress(progress:CGFloat,sourceIndex: Int,targetIndex: Int)  {
        
    }
}
