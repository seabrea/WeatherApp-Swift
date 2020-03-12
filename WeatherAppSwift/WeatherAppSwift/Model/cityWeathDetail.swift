//
//  cityWeathDetail.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/6.
//  Copyright © 2020 He Bob. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    
    var aqi: Float?
    var date: String
    var fl: String
    var fx: String
    var high: String
    var low: String
    var notice: String
    var sunrise: String
    var sunset: String
    var type: String
    var week: String
    var ymd: String
}

struct DataInfo: Codable {
    
    var forecast: [Forecast]
    var ganmao: String
    var pm10: Float
    var pm25: Float
    var quality: String
    var shidu: String
    var wendu: String
    var yesterday: Forecast
}

struct CityInfo: Codable {
    
    var city: String
    var citykey: String
    var parent: String
    var updateTime: String
}

struct CityDetailData: Codable {
    
    var cityInfo: CityInfo
    var data: DataInfo
    var date: String
    var message: String
    var status: Float
    var time: String
}
