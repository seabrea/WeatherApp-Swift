//
//  RequestManager.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/12.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

enum RequestConstant {
    static let RequestURL = "http://t.weather.sojson.com/api/weather/city/"
}

class RequestManager {
    
    typealias RequestHander = (Data?, Error?) -> (Void)
    
    static let shared = RequestManager()
    
    private init(){}
    
    private func baseRequest(_ urlString: String, _ receiveHander: @escaping RequestHander) {
        
        let url = URL(string: urlString)
        
        let request = URLRequest(url: url!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 3600)
        
        let session = URLSession.shared
          let task = session.dataTask(with: request) { (data, response, error) in
              DispatchQueue.main.async {
                  receiveHander(data, error)
              }
          }
          task.resume()
    }
}

// 业务请求函数
extension RequestManager {
    
    func cityWeathDetailRequest(_ cityID: String, _ receiveHander: @escaping RequestHander) {
        
        let urlSting = RequestConstant.RequestURL + cityID
        baseRequest(urlSting, receiveHander)
    }
}
