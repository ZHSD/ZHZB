//
//  UIColor-Extension.swift
//  ZHZB
//
//  Created by 张浩 on 2016/11/16.
//  Copyright © 2016年 张浩. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat) {
        
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}
