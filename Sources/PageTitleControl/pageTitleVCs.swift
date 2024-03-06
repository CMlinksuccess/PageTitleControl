//
//  pageTitleVCs.swift
//  swiftProjectDemo
//
//  Created by cym on 2024/1/8.
//

import UIKit

@objc public protocol PageTitleVCsDelegate{
    func pageControlsSelectedAt(_ index:Int)
}

/**********可滑动控制器的控件************/
class PageTitleVCs: UIViewController{
    
    //初始显示控制器index
    public var currentIndex:Int = 0
    
    //滑动回调代理
    public weak var delegate: PageTitleVCsDelegate?
    
    private var _viewControllers:[UIViewController]!
    private var _collectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .top
        
        _collectionView = self.collectionView()
        view.addSubview(_collectionView)
    }
    
    public init(controllers:[UIViewController], frame viewFrame:CGRect, delegate:PageTitleVCsDelegate? = nil){
        super.init(nibName: nil, bundle: nil)
        
        _viewControllers = controllers
        self.delegate = delegate
        view.frame = viewFrame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView() -> UICollectionView{
        let rect = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let _layout = UICollectionViewFlowLayout()
        _layout.itemSize = rect.size
        _layout.minimumLineSpacing = 0
        _layout.minimumInteritemSpacing = 0
        _layout.scrollDirection = .horizontal
        
        let collectionview = UICollectionView(frame: rect, collectionViewLayout: _layout)
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))
        collectionview.backgroundColor = .white
        collectionview.isPagingEnabled = true
        collectionview.showsVerticalScrollIndicator = false
        collectionview.showsHorizontalScrollIndicator = false
        return collectionview
    }
    
    public func scrollToPageAtIndex(_ index:Int){
        _collectionView.scrollToItem(at:IndexPath(row: index, section: 0), at:.right, animated:false)
    }
}
extension PageTitleVCs:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _viewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UICollectionViewCell.self), for: indexPath)
        let v = _viewControllers[indexPath.row]
        for _v in cell.contentView.subviews{
            _v.removeFromSuperview()
        }
        v.removeFromParent()
        v.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        self.addChild(v)
        cell.contentView.addSubview(v.view)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        _scroll(scrollView)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        _scroll(scrollView)
    }
    
    func _scroll(_ scrollView:UIScrollView){
        let index = scrollView.contentOffset.x / scrollView.frame.width
        let i = lrintf(Float(index))
        guard i != currentIndex else { return }
        currentIndex = i
        if let delegate = self.delegate {
            delegate.pageControlsSelectedAt(i)
        }
    }
}
