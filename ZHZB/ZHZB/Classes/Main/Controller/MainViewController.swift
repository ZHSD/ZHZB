//
//  MainViewController.swift
//  ZHZB
//
//  Created by 张浩 on 2016/11/15.
//  Copyright © 2016年 张浩. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
    }

    private func addChildVC(storyName:String) {
        //通过storyboard获取控制器
        let Vc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(Vc)
    }
    


}
