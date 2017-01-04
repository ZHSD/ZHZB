//
//  RecommendViewController.swift
//  ZHZB
//
//  Created by 张浩 on 2017/01/04.
//  Copyright © 2017年 张浩. All rights reserved.
//

import UIKit
fileprivate let ZItemMargin : CGFloat = 10
fileprivate let ZItemW : CGFloat = (ZHScreenW - 3 * ZItemMargin)/2
fileprivate let ZNormalItemH : CGFloat = ZItemW * 3 / 4
fileprivate let ZPrettyItemH : CGFloat = ZItemW * 4 / 3

fileprivate let ZHeaderH : CGFloat = 50
fileprivate let ZNormalCellID = "ZNormalCellID"
fileprivate let ZHeaderViewID = "ZHeaderViewID"
fileprivate let ZPrettyCellID = "ZPrettyCellID"
class RecommendViewController: UIViewController {
     //MARK:- 懒加载属性
    fileprivate  lazy var collevtionView : UICollectionView = {[weak  self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ZItemW, height: ZNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = ZItemMargin
        layout.headerReferenceSize = CGSize(width: ZHScreenW, height: ZHeaderH)
        //设置内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: ZItemMargin, bottom: 0, right: ZItemMargin)
        //2.创建uicollectionView
        let collevtionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collevtionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]

        collevtionView.backgroundColor = UIColor.white
        //3.设置代理
        collevtionView.dataSource = self
        collevtionView.delegate = self
        
        //4.注册cell
        collevtionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: ZNormalCellID)
        collevtionView.register(UINib(nibName: "CollectionP rettyCell", bundle: nil), forCellWithReuseIdentifier: ZPrettyCellID)
        //注册组头view
        collevtionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ZHeaderViewID)
        return collevtionView
    }()
 //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI()
        
       
        
        
        
    }
    
    
}

 //MARK:- 设置UI界面
extension RecommendViewController{
    
    fileprivate func setupUI(){
        view.addSubview(collevtionView)
    
    }
}
 //MARK:- 遵守UICollectionView的数据源协议
extension RecommendViewController : UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.定义cell
        var cell : UICollectionViewCell
        //1.获取cell
        if indexPath.section == 1 {
            
             cell = collevtionView.dequeueReusableCell(withReuseIdentifier: ZPrettyCellID, for: indexPath)
        }else {
         cell = collevtionView.dequeueReusableCell(withReuseIdentifier: ZNormalCellID, for: indexPath)
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的header
        let headerView = collevtionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ZHeaderViewID, for: indexPath)
            return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: ZItemW, height: ZPrettyItemH)
        }else {
            return CGSize(width: ZItemW, height: ZNormalItemH)
        }
    }
}
