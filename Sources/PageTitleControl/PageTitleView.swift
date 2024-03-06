//
//  PageTitleView.swift
//  swiftProjectDemo
//
//  Created by cym on 2024/1/2.
//

import UIKit

@objc public protocol PagetitleViewDelegate{
    func titleViewSelectedAt(_ index: Int)
}

/**********可滑动和点击标题的控件************/
class PageTitleView: UIView{
    /*选中后的闭包回调*/
    var selectClosure: ((Int, String) -> Void)?
    /*选中标题字体颜色*/
    public var selectColor:UIColor = .red{
        didSet{
            for btn in buttons {
                btn.setTitleColor(selectColor, for: .selected)
            }
            lineView.backgroundColor = selectColor
        }
    }
    /*常规标题字体颜色*/
    public var normalColor:UIColor = .black {
        didSet{
            for btn in buttons {
                btn.setTitleColor(normalColor, for: .normal)
            }
        }
    }
    /*选中标题字体大小*/
    public var selectTitleFont:UIFont = .systemFont(ofSize: 18){
        didSet{
            let btn = buttons[selectIndex]
            btn.titleLabel?.font = selectTitleFont
        }
    }
    /*常规标题字体大小*/
    public var normalFont:UIFont = .systemFont(ofSize: 16){
        didSet{
            for btn in buttons {
                if btn.isEqual(buttons[selectIndex]) {continue}
                btn.titleLabel?.font = normalFont
            }
        }
    }
    /*是否显示标题下划线*/
    public var showIndicator:Bool = true {
        didSet{
            lineView.isHidden = !showIndicator
        }
    }
    /*标题下划线颜色*/
    public var indicatorColor: UIColor = .red {
        didSet{
            self.lineView.backgroundColor = self.indicatorColor
        }
    }
    /*选中后的回调代理*/
    public weak var delegate:PagetitleViewDelegate?
    
    /*设置当前选中的标题index*/
    public func select(index:Int){
        btnClick(buttons[index])
    }
    
    private var selectIndex: Int = 0
    private var titles = [String]()
    private var buttons = [UIButton]()
    private let bgView = UIView()
    private lazy var titleLens = {
        var lens = [CGFloat]()
        for text in titles {
            let width = text.textSizeW(font: normalFont, size: CGSize(width: bounds.width, height: bounds.height)) + 25
            lens.append(width)
        }
        return lens
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    private let lineH:CGFloat = 3
    private lazy var lineView: UIView = {
        let lineView = UIView(frame: CGRect(x: 0, y: self.bounds.size.height - self.lineH, width: self.titleLens[self.selectIndex], height: lineH))
        lineView.backgroundColor = self.indicatorColor
        return lineView
    }()
    private let btnTag = 98373
    
    init(frame:CGRect = .zero, titles:[String], selectIndex:Int = 0, completion:@escaping ((Int, String) -> Void)) {
        super.init(frame: frame)

        self.titles = titles
        self.selectIndex = selectIndex
        self.selectClosure = completion
        
        var i = 0
        var btnX = 0.0
        for item in titles {
            let btn = UIButton()
            btn.tag = btnTag + i
            btn.frame = CGRect(x: btnX, y: 0, width: titleLens[i], height: self.bounds.height)
            btn.setTitle(item, for: .normal)
            btn.setTitleColor(normalColor, for: .normal)
            btn.setTitleColor(selectColor, for: .selected)
            btn.titleLabel?.font = normalFont
            btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
            buttons.append(btn)
            scrollView.addSubview(btn)

            if selectIndex == i {
                btnClick(btn)
            }
            i+=1
            btnX = btnX + CGRectGetWidth(btn.frame)
        }
        scrollView.addSubview(lineView)
        addSubview(scrollView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btnClick(_ button:UIButton){
        
        if button.isSelected { return }
        
        let oldbtn: UIButton = buttons[selectIndex]
        oldbtn.isSelected = false
        oldbtn.titleLabel?.font = normalFont
        
        selectIndex = button.tag - btnTag
        button.isSelected = true
        button.titleLabel?.font = selectTitleFont

        if let closure = self.selectClosure{
            closure(selectIndex, button.titleLabel?.text ?? "")
        }
        if showIndicator {
            
            let btnWidth = titleLens[selectIndex]
            let btnx = CGRectGetMinX(button.frame)
            UIView.animate(withDuration: 0.25) {
                self.lineView.frame = CGRect(x: btnx, y: self.bounds.size.height - self.lineH, width: btnWidth, height: self.lineH)
            }
        }
        
        if let del = delegate {
            del.titleViewSelectedAt(selectIndex)
        }
        //自动滑动居中
        let contentx = scrollView.contentSize.width
        let offsetx = button.center.x - self.center.x
        let rightx = contentx - button.center.x
        if offsetx > 0 && rightx > self.center.x {
            scrollView.setContentOffset(CGPoint(x: offsetx, y: 0), animated: true)
        }else if offsetx < 0 {
            scrollView.setContentOffset(.zero, animated: true)
        }else if rightx < self.center.x {
            scrollView.setContentOffset(CGPoint(x: contentx - self.frame.width, y: 0), animated: true)
        }
    }
  
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = bounds.size.width
        let height = bounds.size.height
        
        var btnX = 0.0
        let btnHeight = height - lineH

        for idx in 0..<buttons.count {
            let btn = buttons[idx]
            let btnWidth = titleLens[idx]
            btn.frame = CGRect(x: btnX, y: 0, width: btnWidth, height: btnHeight)
            btnX = btnX + btnWidth
        }
        scrollView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        scrollView.contentSize = CGSize(width: btnX, height: height)
    }
}

extension String {
    
    func textSize(font: UIFont, size: CGSize) -> CGSize {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: size.width, height: size.height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return rect.size
    }
    func textSizeW(font: UIFont, size: CGSize) -> CGFloat {
        return textSize(font: font, size: size).width
    }
    func textSizeH(font: UIFont, size: CGSize) -> CGFloat {
        return textSize(font: font, size: size).height
    }
}
