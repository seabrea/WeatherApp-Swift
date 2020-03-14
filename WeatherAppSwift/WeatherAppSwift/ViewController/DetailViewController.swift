//
//  DetailViewController.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/2.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

@objc protocol DetailViewControllerProtocol {
    
    func selectedCity(code: String);
}

class DetailViewController: UIViewController {

    var tableView: UITableView!
    var dataSource: CityPlistManger.CityListType?
    var sectionSource: [String]?
    
    weak var delegate: DetailViewControllerProtocol?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configView()
    }
    
    deinit {
        logDealloc(className: self.classForCoder)
    }
    

}

extension DetailViewController {
    
    private func configView() {
        
        sectionSource = CityPlistManger.shared.provinces
        dataSource = CityPlistManger.shared.cities
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let sectionContent = sectionSource?[section]
        let showString = sectionContent?.components(separatedBy: CharacterSet.whitespaces).first
        return showString ?? " "
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let list = dataSource?[section]
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            
            let list = dataSource?[indexPath.section]
            let dic = list?[indexPath.row]
            cell.textLabel?.text = dic?.values.first
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let list = dataSource?[indexPath.section]
        let dic = list?[indexPath.row]
        
        guard let cityCode = dic?.keys.first else {
            return
        }
        
        if delegate != nil {
            
            delegate?.selectedCity(code: cityCode)
            dismiss(animated: true, completion: nil)
        }
    }
}
