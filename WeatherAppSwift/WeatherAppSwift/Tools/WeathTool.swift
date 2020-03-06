//
//  WeathTool.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/6.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

let DefaultCityCode = "defaultCityCode"

class WeathTool {
    
    open class func haveDefaultCityCode() -> Bool {
        
        if let _ = UserDefaults.standard.object(forKey: DefaultCityCode) {
            return true
        }
        return false
    }
    
    open class func saveDefaultCityCode(_ defaultCode: String) {
        
        UserDefaults.standard.set(defaultCode, forKey: DefaultCityCode)
    }
    
    open class func defaultCityCode() -> String {
        
        guard let defaultCode = UserDefaults.standard.object(forKey: DefaultCityCode) else {
            fatalError("defaultCode is nill")
        }
        
        return defaultCode as! String
    }
}
