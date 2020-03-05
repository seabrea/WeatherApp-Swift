//
//  DetailViewController.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/2.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var tableView: UITableView!
    var bannerData = ["home","personal"]
    var dataSource: [NSDictionary]?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configView()
    }
    
    deinit {
        logDealloc(className: self.classForCoder)
    }
    
    func configView() {
        
        let path = Bundle.main.path(forResource: "cityCode", ofType: "plist")
        dataSource = NSArray(contentsOfFile: path!) as? [NSDictionary]
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        let headerView = BannerScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 200))
        headerView.refreshUI(data: bannerData)
        tableView.tableHeaderView = headerView
        
        view.addSubview(tableView)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            let dic = dataSource?[indexPath.row]
            cell.textLabel?.text = dic?["city_name"] as? String
            cell.detailTextLabel?.text = dic?["city_code"] as? String
            cell.imageView?.image = UIImage(named: "personal")
            return cell
        }
        else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            let dic = dataSource?[indexPath.row]
            cell.textLabel?.text = dic?["city_name"] as? String
            cell.detailTextLabel?.text = dic?["city_code"] as? String
            cell.imageView?.image = UIImage(named: "personal")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let collectionView = CollectionViewController()
        navigationController?.pushViewController(collectionView, animated: true)
    }
}
