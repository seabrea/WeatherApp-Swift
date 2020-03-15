//
//  WeathTool.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/6.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit
import AdSupport

enum DefineConst {
    static let DefaultCityCode = "defaultCityCode"
    static let TestMap4Url = "http://vfx.mtime.cn/Video/2019/03/19/mp4/190319212559089721.mp4"
    static let TestImageUrl = "https://i0.hdslb.com/bfs/article/32d57fcafe36df2896d47be0031b33ab8f46eaad.jpg"
    
    static let WScreen = UIScreen.main.bounds.width
    static let HScreen = UIScreen.main.bounds.height
    
    static let KeyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    
    enum TestString {
        static let TestUITextViewContent = "红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚"
    }
    
    enum AssetsName {
        static let PersonalImageName = "personal"
        static let HomeImageName     = "home"
    }
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
    
    open class func UUIDString() -> String {
        
        let manager = ASIdentifierManager.shared()
        if manager.isAdvertisingTrackingEnabled {
            return ASIdentifierManager.shared().advertisingIdentifier.uuidString
        }
        return "0"
    }
}
