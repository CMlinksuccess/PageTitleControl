//
//  PageControlVC.swift
//  swiftProjectDemo
//
//  Created by cym on 2024/1/8.
//

import UIKit

//标题和控制器视图同时创建，需为全局实例变量才能保证事件联动
class PageControl:UIViewController {
    //内部标题视图，提供外部设置
    public var titleView:PageTitleView!
    //内部控制器集合，提供外部设置
    public var pageVC:PageTitleVCs!
    //选中后的回调
    public var selectItem: ((Int, String) -> Void)?
    
    public func addViewController(vc:UIViewController){
        vc.view.addSubview(titleView)
        vc.view.addSubview(pageVC.view)
        vc.addChild(pageVC)
    }
    
    convenience init(frame:CGRect,viewControllers:[UIViewController],titles:[String],select:Int) {
        self.init()
        titleView = PageTitleView(frame: CGRect(x: 0, y: frame.origin.y, width: frame.width, height: 45), titles: titles, completion: { index, title in
            if let select = self.selectItem {
                
                select(index,title)
            }
        })
        titleView.delegate = self
        pageVC = PageTitleVCs(controllers: viewControllers, frame: CGRect(x: 0, y: CGRectGetMaxY(titleView.frame), width: frame.width, height: frame.height - CGRectGetHeight(titleView.frame)),delegate: self)
        pageVC.currentIndex = select
    }
}

extension PageControl : PagetitleViewDelegate, PageTitleVCsDelegate {
    
    func titleViewSelectedAt(_ index: Int) {
        pageVC.scrollToPageAtIndex(index)
    }
    
    func pageControlsSelectedAt(_ index: Int) {
        titleView.select(index: index)
    }
}
