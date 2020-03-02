//
//  ShowViewController.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/2.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
    
    var searchButton:UIButton?
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        
        searchButton = UIButton(frame: CGRect(x: view.bounds.width/2, y: view.bounds.height/2, width: 100, height: 50))
        searchButton?.backgroundColor = .gray
        view.addSubview(searchButton!)
        
        searchButton?.addTarget(self, action: #selector(onClickHandler(sender:)), for: .touchUpInside)
    }
    
    @objc func onClickHandler(sender: UIButton) {
        navigationController?.pushViewController(DetailViewController(), animated: true)
    }

}
