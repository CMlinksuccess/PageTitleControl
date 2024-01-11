# PageTitleControl
一个标题点击和页面滑动联动的控件

## 效果图

 

## CocoaPods使用

在Podfile文件中添加：

pod 'PageTitleControl'
然后，执行下面命令：
```
$ pod install
```
## 使用方法

# 创建标题和控制器联动
```swift
 var page:PageControl!

 let vcs = createControls()
        page = PageControl(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: 550), viewControllers: vcs, titles: texts, select: 0)
        //添加到当前控制器
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
```
# 单独创建标题点击和滑动
```swift 
var titleView:PageTitleView!

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
```
# 单独创建滑动控制器
```swift
var pageVC:PageTitleVCs!

 let vcs = createControls()
        pageVC = PageTitleVCs(controllers: vcs, frame: CGRect(x: 0, y: 150, width: view.frame.width, height: view.frame.height - 160),delegate:self)
        pageVC.currentIndex = 3
        
        self.addChild(pageVC)
        self.view.addSubview(pageVC.view)
监听滑动时返回当前控制器index 监听代理 PageTitleVCsDelegate

func pageControlsSelectedAt(_ index: Int) {
        print("控制器选中了\(index)")
    }
```
上述代码公用参数：
```swift
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
```
