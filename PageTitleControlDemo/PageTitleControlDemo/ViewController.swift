//
//  ViewController.swift
//  PageTitleControlDemo
//
//  Created by cym on 2024/1/9.
//

import UIKit

class ViewController: UIViewController {

    let contents = ["标题和控制器联动","单独使用滑动标题","单独使用滑动控制器"]
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height - 100)
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self),for: indexPath)
        if #available(iOS 14.0, *) {
            var config = UIListContentConfiguration.cell()
            config.text = contents[indexPath.row]
            cell.contentConfiguration = config
        } else {
            cell.textLabel?.text = contents[indexPath.row]
        }
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            let pagetitleVC = PageTitleVC()
            pagetitleVC.modalPresentationStyle = .fullScreen
            self.present(pagetitleVC, animated: true)
        case 1:
            let scrolltitleVC = ScrollTitleVC()
            scrolltitleVC.modalPresentationStyle = .fullScreen
            self.present(scrolltitleVC, animated: true)
        case 2:
            let scrollpageVC = ScrollPageVC()
            scrollpageVC.modalPresentationStyle = .fullScreen
            self.present(scrollpageVC, animated: true)
        default:break
            
        }
        
    }
    
}
