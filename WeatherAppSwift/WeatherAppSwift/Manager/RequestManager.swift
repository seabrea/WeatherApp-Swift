//
//  RequestManager.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/12.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit
import Kingfisher

enum RequestConstant {
    static let RequestURL = "http://t.weather.sojson.com/api/weather/city/"
    
    enum DefineString {
        static let TokenKey = "KEY_TOKEN"
    }
}

// 加载图
class LoadingManager: UIView {
    
    static let loading = LoadingManager()
    
    let widthView = UIScreen.main.bounds.width
    let heightView = UIScreen.main.bounds.height
    let KeyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    
    let loadingGIF: AnimatedImageView = {
        let gifView = AnimatedImageView()
        let path = Bundle.main.path(forResource: "loading", ofType: "gif")
        let url = URL(fileURLWithPath: path!)
        gifView.kf.setImage(with: url)
        return gifView
    }()
    
    private override init(frame: CGRect) {
        
        let newFrame = CGRect(x: 0, y: 0, width: widthView, height: heightView)
        super.init(frame: newFrame)
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configView() {
        backgroundColor = .black
        loadingGIF.frame = CGRect(x: (widthView/2) - 30, y: (heightView/2) - 30, width: 60, height: 60)
        addSubview(loadingGIF)
    }
    
    private func keyWindow() -> UIWindow? {
        
        if #available(iOS 13.0, *) {
            
            for scene in UIApplication.shared.connectedScenes {

                if scene.activationState == .foregroundActive {
                    let windowScene = scene as! UIWindowScene
                    return windowScene.windows.first
                }
            }
            
            return UIApplication.shared.windows.first
        }
        else {
            return UIApplication.shared.keyWindow
        }
    }
    
    func showLoadingView() {
        
        if let keywindow = keyWindow() {
            keywindow.addSubview(self)
        }
    }
    
    func hideLoadingView() {
        
        if superview != nil {
            removeFromSuperview()
        }
    }
    
    class func show() {
        LoadingManager.loading.showLoadingView()
    }
    
    class func hide() {
        LoadingManager.loading.hideLoadingView()
    }
}

// 请求工具类
class RequestManager {
    
    typealias RequestHander = (Data?, Error?) -> (Void)
    
    private var dataTask: URLSessionDataTask?
    
    static let shared = RequestManager()
    
    private var token: String {
        get {
            return UserDefaults.standard.object(forKey: RequestConstant.DefineString.TokenKey) as! String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: RequestConstant.DefineString.TokenKey)
        }
    }
    
    private init(){}
}

// 私有函数
extension RequestManager {

    private func baseRequest(_ urlString: String, _ receiveHander: @escaping RequestHander) {
        
        let url = URL(string: urlString)
        
        let request = URLRequest(url: url!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 3600)
        
        let session = URLSession.shared
        
        dataTask = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                receiveHander(data, error)
            }
        }
        dataTask?.resume()
    }
}

// 业务请求函数
extension RequestManager {
    
    func tokenString() -> String {
        return token
    }
    
    func cancelRequest() {
        
        guard dataTask != nil else {
            return
        }
        
        dataTask?.cancel()
    }
    
    
    /// 请求具体城市天气数据
    /// - Parameters:
    ///   - cityID: 城市ID
    ///   - receiveHander: 数据返回Block
    func cityWeathDetailRequest(_ cityID: String, _ receiveHander: @escaping RequestHander) {
        
        let urlSting = RequestConstant.RequestURL + cityID
        baseRequest(urlSting, receiveHander)
    }
}
