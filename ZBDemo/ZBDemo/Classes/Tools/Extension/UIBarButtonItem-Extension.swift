//
//  UIBarButtonItem-Extension.swift
//  ZBDemo
//
//  Created by hh on 2018/1/6.
//  Copyright © 2018年 inphase. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    //扩展构造方法(便利构造函数：)
    convenience init(imageName: String,highImgeName: String = "",size: CGSize = CGSize.zero){
        let btn = UIButton()
        
        btn.setImage(UIImage(named:imageName), for: UIControlState.normal)
        if highImgeName != ""{
            btn.setImage(UIImage(named:highImgeName), for: UIControlState.highlighted)
        }
        
        if size == CGSize.zero{
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView: btn)
    }
    
    //    //扩展类方法
    //    class func createItem(imageName: String,highImgeName: String,size: CGSize)->UIBarButtonItem{
    //        let btn = UIButton()
    //
    //        btn.setImage(UIImage(named:imageName), for: UIControlState.normal)
    //        btn.setImage(UIImage(named:highImgeName), for: UIControlState.highlighted)
    //        btn.frame = CGRect(origin: CGPoint.zero, size: size)
    //        return UIBarButtonItem(customView: btn)
    //    }
}
