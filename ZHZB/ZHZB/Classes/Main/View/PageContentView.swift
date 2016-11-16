//
//  PageContentView.swift
//  ZHZB
//
//  Created by 张浩 on 2016/11/16.
//  Copyright © 2016年 张浩. All rights reserved.
//

import UIKit
fileprivate let contentCellID = "contentCellID"
class PageContentView: UIView {
     //MARK: -定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    //MARK: -懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        //1.创建layuot
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //创建collectionView
        let collectionV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.isPagingEnabled = true
        collectionV.bounces = false
         //设置数据源
        collectionV.dataSource = self
        //注册cell
        collectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionV
    }()
     //MARK: -自定义构造函数
    init(frame: CGRect, childVcs:[UIViewController],parentViewController:UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        //1.设置界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
     //MARK: -设置UI界面
extension PageContentView {
    
    fileprivate func setupUI(){
        //1.将所有的子控制器添加到父控制器中
        for childeVc in childVcs {
            parentViewController?.addChildViewController(childeVc)
        }
        //2.添加UICollectionView 用于在cell添加控制器
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}
     //MARK: -遵守UIcollectionView的dataSource
extension PageContentView:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        //2.设置cell内容
        //以为循环使用,避免多次添加需要先移除一下
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
        
    }
}
 //MARK: -对外暴露的方法
extension PageContentView {
      func setCurrentIndent(currentIndex : Int)  {
                let  offsetX = CGFloat(currentIndex) * ZHScreenW
        collectionView.setContentOffset(CGPoint(x : offsetX,y:0 ), animated: false)
    }
}
