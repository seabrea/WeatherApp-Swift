//
//  WeathTool.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/6.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

enum DefineConst {
    static let DefaultCityCode = "defaultCityCode"
    static let TestMap4Url = "http://vfx.mtime.cn/Video/2019/03/19/mp4/190319212559089721.mp4"
    static let TestImageUrl = "https://i0.hdslb.com/bfs/article/32d57fcafe36df2896d47be0031b33ab8f46eaad.jpg"
    static let WeatherRequestUrl = "http://t.weather.sojson.com/api/weather/city/"
}

class WeathTool {
    
    open class func haveDefaultCityCode() -> Bool {
        
        if let _ = UserDefaults.standard.object(forKey: DefineConst.DefaultCityCode) {
            return true
        }
        return false
    }
    
    open class func saveDefaultCityCode(_ defaultCode: String) {
        
        UserDefaults.standard.set(defaultCode, forKey: DefineConst.DefaultCityCode)
    }
    
    open class func defaultCityCode() -> String {
        
        guard let defaultCode = UserDefaults.standard.object(forKey: DefineConst.DefaultCityCode) else {
            fatalError("defaultCode is nill")
        }
        
        return defaultCode as! String
    }
}
