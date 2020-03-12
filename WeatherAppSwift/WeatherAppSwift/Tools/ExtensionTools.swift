//
//  ExtensionTools.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/3.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func logDealloc(className: AnyClass) {
        print("\(className) 已销毁")
    }
    
    func cancelCurViewControllerRequst() {
        RequestManager.shared.cancelRequest()
    }
}
