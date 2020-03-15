//
//  PersonalViewController.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/8.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit
import Kingfisher

class PersonalViewController: UIViewController {
    
    let HeaderCellIdentifier = "HeaderCell"
    let CellIdentifier = "Cell"
    
    var tableView: UITableView = {
        let newView = UITableView(frame: CGRect.zero, style: .grouped)
        newView.estimatedRowHeight = 0;
        newView.estimatedSectionHeaderHeight = 0;
        newView.estimatedSectionFooterHeight = 0;
        return newView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
}

extension PersonalViewController {
    
    private func configUI() {
        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}

extension PersonalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0) ? 100 : 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section == 0) ? 0.1 : 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let isHeader = (indexPath.section == 0)
        let identifier = isHeader ? HeaderCellIdentifier : CellIdentifier
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            let style = isHeader ? UITableViewCell.CellStyle.subtitle : .default
            cell = UITableViewCell(style: style, reuseIdentifier: identifier)
        }
        
        if isHeader {
            cell?.imageView?.image = UIImage(named: DefineConst.AssetsName.PersonalImageName)
            cell?.textLabel?.text = "个人中心"
            cell?.detailTextLabel?.text = "登录后可以记录相关天气信息"
        }
        else {
            cell?.accessoryType = .disclosureIndicator
            cell?.textLabel?.text = (indexPath.row == 0) ? "未完成界面" : "关于"
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            let web = WebViewController()
            navigationController?.pushViewController(web, animated: true)
            break
        case 1:
            if indexPath.row == 0 {
                navigationController?.pushViewController(CollectionViewController(), animated: true)
            }
            else {
                navigationController?.pushViewController(AboutViewController(), animated: true)
            }
            break
        default: break
        }
    }
}
