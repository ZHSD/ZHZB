//
//  PageTitleView.swift
//  ZHZB
//
//  Created by 张浩 on 2016/11/15.
//  Copyright © 2016年 张浩. All rights reserved.
//

import UIKit
fileprivate let ZHScrollLineH : CGFloat = 2
class PageTitleView: UIView {
    
     //MARK: -定义属性
        fileprivate var titles : [String]
     //MARK: -懒加载属性
    fileprivate lazy var titleLables:[UILabel] = [UILabel]()
        fileprivate lazy var TitleScrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.scrollsToTop = false
        scrollview.bounces = false
        return scrollview
    }()
    fileprivate lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    //MARK: -自定义构造函数
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        
        super.init(frame: frame)
        //设置titleView的UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleView{
    fileprivate func setupUI(){
        //1.添加scrollView
        addSubview(TitleScrollView)
        TitleScrollView.frame = bounds
        //2.添加title对应的lable
        setupTitleLables()
        //3.添加底线和滚动的滑块
        setupBottomLineAndScrollLine()
    
    }
    private func setupTitleLables() {
        
            //2.0 确定lable的frame的值
        let lableW: CGFloat = frame.width / CGFloat(titles.count)
        let lableH: CGFloat = frame.height - ZHScrollLineH
        let lableY: CGFloat = 0
        for (index,title) in titles.enumerated() {
            //2.1.创建lable
            let lable = UILabel()
            //2.2设置lable属性
            lable.text = title
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 16.0)
            lable.textColor = UIColor.darkGray
            lable.textAlignment = .center
            //2.3 设置lable的frame
            
            let lableX: CGFloat = lableW * CGFloat(index)
        
            
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            //2.4 将lable添加的acrollView中
            TitleScrollView.addSubview(lable)
            titleLables.append(lable)
        }
    }
    private func setupBottomLineAndScrollLine(){
        //3.1添加底线
        let bottomLine = UIView()
        let lineH : CGFloat = 0.5
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        //3.2 添加滚动指示(scrollLine的frame更具lable的frame设置)
        //3.2.1 获取的一个lable
        guard let firstLable = titleLables.first else { return }
        firstLable.textColor = UIColor.orange
        //3.2.2添加滚动指示器
        TitleScrollView.addSubview(scrollLine)
        //3.2.3 更具lable的frame设置滚动指示器的frame
        scrollLine.frame = CGRect(x: firstLable.frame.origin.x, y: frame.height-ZHScrollLineH, width: firstLable.frame.width, height: ZHScrollLineH)
    
    }
}
