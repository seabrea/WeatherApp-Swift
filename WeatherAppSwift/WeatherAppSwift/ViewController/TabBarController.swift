//
//  TabBarController.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/2.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configSubViewControllers()
    }

    private func configSubViewControllers() {
        
        let firstNavi = UINavigationController(rootViewController: ShowViewController())
        firstNavi.viewControllers.first?.view.backgroundColor = .white
        firstNavi.tabBarItem.title = "天气显示"
        firstNavi.tabBarItem.image = UIImage(named: "home")
            
        let secondNavi = UINavigationController(rootViewController: PersonalViewController())
        secondNavi.viewControllers.first?.view.backgroundColor = .blue
        secondNavi.tabBarItem.title = "个人展示"
        secondNavi.tabBarItem.image = UIImage(named: "personal")
        
        viewControllers = [firstNavi, secondNavi]
    }
}
