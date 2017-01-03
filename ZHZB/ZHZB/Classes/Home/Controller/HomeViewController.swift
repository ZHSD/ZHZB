//
//  HomeViewController.swift
//  ZHZB
//
//  Created by 张浩 on 2016/11/15.
//  Copyright © 2016年 张浩. All rights reserved.
//

import UIKit

fileprivate let ZHTitleViewH: CGFloat = 40
class HomeViewController: UIViewController {

     //MARK: -懒加载属性
       fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        
        let titleframe = CGRect(x: 0, y: ZHStatusBarH+ZHNavigationBarH, width: ZHScreenW, height: ZHTitleViewH )
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleframe, titles: titles)
        titleView.delegate = self
            
        return titleView
    }()
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        //1.确定pageContentView的frame
        let contentViewH = ZHScreenH - ZHStatusBarH - ZHNavigationBarH*2 - ZHTitleViewH
        let ContentFrame = CGRect(x: 0, y: ZHStatusBarH+ZHNavigationBarH+ZHTitleViewH, width: ZHScreenW, height: contentViewH)
        //2.添加ContentView的子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let Vc = UIViewController()
            
            Vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(Vc)
        }
        let contentView = PageContentView(frame: ContentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        
        return contentView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI()
        
    }

    
}
 //MARK: -设置UI界面
extension HomeViewController {
    
    fileprivate func setupUI() {
        //0.不需要调整uiscrollView的内边距(有导航栏系统自动设置64的内边距)
        automaticallyAdjustsScrollViewInsets = false
        //1.设置导航栏
        setupNavigationBar()
        //2.添加titleView
        view.addSubview(pageTitleView)
        //3.添加内容contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.blue
    
    }
    
    private func setupNavigationBar(){
        //1.1设置左侧item
                navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        //1.2设置右侧items
        let size = CGSize(width: 40, height: 40);
        

       let hister = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        
    
        let search = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
        let qrcode = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        navigationItem.rightBarButtonItems = [hister,search,qrcode]
    }
    
}
 //MARK: -遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate {
    func pagetitleView(titleView: PageTitleView, selectIndex index: Int) {
        pageContentView.setCurrentIndent(currentIndex: index)
    }

}
 //MARK: -遵守pageContentViewDelegate协议
extension HomeViewController : pageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}
