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
    
    private var plistList:[NSDictionary]?
    
    public var plist: [NSDictionary] {
        get {
            return plistList ?? []
        }
    }
    
    private init(){
        configData()
    }
    
    private mutating func configData() {
        let path = Bundle.main.path(forResource: CityPlistDefain.plistName, ofType: CityPlistDefain.plistType)
        plistList = NSArray(contentsOfFile: path!) as? [NSDictionary]
    }
}
