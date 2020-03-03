//
//  DetailViewController.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/2.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var tableView: UITableView?
    var dataSource = ["1","1","1","1","1","1","1","1","1","1","1"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configView()
    }
    
    deinit {
        logDealloc(className: self.classForCoder)
    }
    
    func configView() {
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell.textLabel?.text = dataSource[indexPath.row]
            cell.detailTextLabel?.text = "副"
            cell.imageView?.image = UIImage(named: "personal")
            return cell
        }
        else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            cell.textLabel?.text = dataSource[indexPath.row]
            cell.detailTextLabel?.text = "副"
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
