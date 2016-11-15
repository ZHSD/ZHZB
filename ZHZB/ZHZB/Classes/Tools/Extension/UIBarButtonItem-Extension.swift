//
//  UIBarButtonItem-Extension.swift
//  ZHZB
//
//  Created by 张浩 on 2016/11/15.
//  Copyright © 2016年 张浩. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    //类方法
    class func creatItem(imageName: String, highImageName:String, size:CGSize) -> UIBarButtonItem{
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        btn.frame = CGRect(origin:CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
    //便利构造方法1.以convenience init 不需要写返回值 2.必须调用设计的构造函数(self)
    
    convenience init(imageName: String, highImageName:String = "", size:CGSize = CGSize.zero) {
        //1创建Btn
        let btn = UIButton()
        
        //2.设置btn图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
        
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        //3.设置btn大小
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
        
            btn.frame = CGRect(origin:CGPoint.zero, size: size)
        }
        //4.创建uibarbuttonItem
        self.init(customView:btn)
    }
}
