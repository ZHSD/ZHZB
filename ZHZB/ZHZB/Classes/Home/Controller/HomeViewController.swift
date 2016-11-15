//
//  HomeViewController.swift
//  ZHZB
//
//  Created by 张浩 on 2016/11/15.
//  Copyright © 2016年 张浩. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }

    
}
 //MARK: -设置UI界面
extension HomeViewController {
    
     func setupUI() {
        //设置导航栏
        setupNavigationBar()
    
    }
    private func setupNavigationBar(){
        //1.设置左侧item
                navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        //2.设置右侧items
        let size = CGSize(width: 40, height: 40);
        

       let hister = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        
    
        let search = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
        let qrcode = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        navigationItem.rightBarButtonItems = [hister,search,qrcode]
    }
    
}
