//
//  CityPlistManger.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/13.
//  Copyright © 2020 He Bob. All rights reserved.
//

import Foundation

enum CityPlistDefain {
    static let plistName: String = "cityCode"
    static let plistType: String = "plist"
}

struct CityPlistManger {
    
    static let shared = CityPlistManger()
    
    typealias CityListType = [[[String : String]]]
    
    private var cityList = CityListType()
    private var provinceList = [String]()
    
    public var cities: CityListType {
        get {
            return cityList
        }
    }
    
    public var provinces: [String] {
        get {
            return provinceList
        }
    }
    
    private init(){
        configData()
    }
    
    private mutating func configData() {
        let path = Bundle.main.path(forResource: CityPlistDefain.plistName, ofType: CityPlistDefain.plistType)
        
        guard let plistList = NSArray(contentsOfFile: path!) as? [NSDictionary] else {
            fatalError()
        }
        
        for item in plistList {

            let pid = (item["pid"] as! NSNumber).intValue
            if pid == 0 {
                let name = item.value(forKey: "city_name") as! String
                let id = (item.value(forKey: "id") as! NSNumber).stringValue
                let newValue = "\(name) \(id)"
                provinceList.append(newValue)
            }
        }
        
        for province in provinceList {
            
            let pid = province.components(separatedBy: CharacterSet.whitespaces).last
            var itemList = [[String : String]]()
            
            for item in plistList {
                
                if (item["city_code"] as? NSNumber) != nil {
                    
                    let hasPID = ((item["pid"] as! NSNumber).intValue != 0)
                    let itemPID = hasPID ? (item["pid"] as! NSNumber).stringValue : (item["id"] as! NSNumber).stringValue
                    
                    if pid == itemPID {
                        
                        let cityCode = (item["city_code"] as! NSNumber).stringValue
                        let cityName = item["city_name"] as! String
                        let newDic = [cityCode : cityName]
                        itemList.append(newDic)
                    }
                }
            }
            
            cityList.append(itemList)
        }
    }
}
