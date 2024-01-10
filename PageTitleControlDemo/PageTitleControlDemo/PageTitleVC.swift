//
//  PageTitleVC.swift
//  PageTitleControlDemo
//
//  Created by cym on 2024/1/9.
//

import UIKit

class ItemVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

let texts = ["标题1","标题2","标题比较长3","标题很长很长4","标题5","标题6","标题7"]

func createControls() -> [UIViewController] {
    var vcs = [ItemVC]()
    for i in 0..<texts.count{
        let vc = ItemVC()
        vc.view.backgroundColor = UIColor(red: 55.0 * CGFloat(i)/255.0, green: 25.0 * CGFloat(i)/255.0, blue: 15.0 * CGFloat(i)/255.0, alpha: 1)
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "控制器\(i)"
        label.sizeToFit()
        label.center = CGPoint(x: vc.view.center.x, y: 150)
        vc.view.addSubview(label)
        vcs.append(vc)
    }
    return vcs
}

//标题和控制器联动demo
class PageTitleVC: BaseVC {
    
    var page:PageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let vcs = createControls()
        page = PageControl(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: 550), viewControllers: vcs, titles: texts, select: 0)
        page.addViewController(vc: self)
        //设置不同样式
        page.titleView.selectColor = .blue
        page.titleView.normalColor = .brown
        page.titleView.selectTitleFont = .systemFont(ofSize: 19)
        page.titleView.normalFont = .systemFont(ofSize: 16)
        page.titleView.select(index: 2)
        page.selectItem = {(idx, title) in
            print("选中了\(idx),\(title)")
        }
    }
}
//滑动标题demo
class ScrollTitleVC: BaseVC {
    
    var titleView:PageTitleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        titleView = PageTitleView(frame: CGRect(x: 0, y: 150, width: view.frame.width, height: 45), titles: texts, completion: { index, title in
            print("选中的标题\(index),\(title)")
        })
        titleView.selectColor = .brown
        titleView.normalColor = .gray
        titleView.select(index: 2)
        titleView.selectClosure = {idx, title in
            print("标题选中了\(idx),\(title)")
        }
        view.addSubview(titleView)
    }
}
//滑动控制器demo
class ScrollPageVC: BaseVC,PageTitleVCsDelegate {
    func pageControlsSelectedAt(_ index: Int) {
        print("控制器选中了\(index)")
    }
    
    var pageVC:PageTitleVCs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let vcs = createControls()
        pageVC = PageTitleVCs(controllers: vcs, frame: CGRect(x: 0, y: 150, width: view.frame.width, height: view.frame.height - 160),delegate:self)
        pageVC.currentIndex = 3
        
        self.addChild(pageVC)
        self.view.addSubview(pageVC.view)
    }
                              
                              
}

class BaseVC: UIViewController {

    lazy var backBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 50, y: 50, width: 100, height: 50))
        btn.setTitle("返回页面", for: .normal)
        btn.setTitleColor(.orange, for: .normal)
        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return btn
    }()
    @objc func backAction() {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backBtn)
    }
}
