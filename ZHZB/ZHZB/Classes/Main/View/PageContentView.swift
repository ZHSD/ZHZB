//
//  PageContentView.swift
//  ZHZB
//
//  Created by 张浩 on 2016/11/16.
//  Copyright © 2016年 张浩. All rights reserved.
//

import UIKit

 //MARK: -定义代理协议用来告诉HomeViewController,然后传给pageTitleView
protocol pageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView, progress : CGFloat,sourceIndex : Int, targetIndex : Int )
}
fileprivate let contentCellID = "contentCellID"
class PageContentView: UIView {
     //MARK: -定义属性
    weak var delegate : pageContentViewDelegate?
    fileprivate var childVcs : [UIViewController]
     // weak只能修饰可选类型
    fileprivate weak var parentViewController : UIViewController?
    // MARK:- 记录开滑动的offsetX
    fileprivate var startOffsetX : CGFloat = 0
    // MARK:- 禁止滚动,避免重复的执行事件
     fileprivate var isForbidScrollDelegate: Bool = false
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
        collectionV.delegate = self
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
 //MARK: -遵守UIcollectionView的代理
extension PageContentView :UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0.判断是否是点击事件
        if isForbidScrollDelegate { return}
        //1.定义需要获取的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        //2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX{//左滑
            //2.1计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            //2.2计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            //2.3计算targetIndexs
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            //2.4 如果完全划过去
            if currentOffsetX  - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else {//右滑
            //2.1计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            //2.2计算targetIndexs
            targetIndex = Int(currentOffsetX / scrollViewW)
            //2.3计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }

        }
        //3.通知代理,将progress/sourceIndex/targetIndex传递给TitleView
        
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
//        print("progress:\(progress), sourceIndex:\(sourceIndex),targetIndex:\(targetIndex)")
        
    }
}
 //MARK: -对外暴露的方法
extension PageContentView {
    

      func setCurrentIndent(currentIndex : Int)  {
        // 1.记录需要禁止执行代理方法
        isForbidScrollDelegate = true
        // 2.滚到正确的位置
        let  offsetX = CGFloat(currentIndex) * ZHScreenW
        collectionView.setContentOffset(CGPoint(x : offsetX,y:0 ), animated: false)
    }
}
