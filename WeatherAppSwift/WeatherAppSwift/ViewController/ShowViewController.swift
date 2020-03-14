//
//  ShowViewController.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/2.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
    
    var searchButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: DefineConst.WScreen/2 - 100, y: DefineConst.HScreen/2 + 100, width: 200, height: 50))
        btn.setTitle("点击查看更多城市", for: .normal)
        btn.setTitle("松开跳转城市选择", for: .highlighted)
        btn.backgroundColor = .lightGray
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    var textView: UILabel = {
        let newView = UILabel(frame: CGRect(x: 20, y: 100, width: DefineConst.WScreen - 40, height: 300))
        newView.font = UIFont.italicSystemFont(ofSize: 20)
        newView.textAlignment = .center
        newView.lineBreakMode = .byCharWrapping
        newView.numberOfLines = 0
        newView.text = DefineConst.TestString.TestUITextViewContent
        newView.backgroundColor = .white
        newView.layer.cornerRadius = 20
        newView.layer.borderWidth = 0.5
        newView.layer.borderColor = UIColor.lightGray.cgColor
        return newView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configData()
        configView()
    }
    
    func configData() {
        
        
        if WeathTool.haveDefaultCityCode() {
            let cityCode = WeathTool.defaultCityCode()
            requestData(cityCode)
        }
        else {
            // 默认城市plist第一个
             let path = Bundle.main.path(forResource: CityPlistDefain.plistName, ofType: CityPlistDefain.plistType)
            let plist = NSArray(contentsOfFile: path!) as? [NSDictionary]
            let cityCode = (plist?.first?["city_code"] as! NSNumber).description
            WeathTool.saveDefaultCityCode(String(cityCode))
            requestData(cityCode)
        }
    }
    
    func configView() {
        
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(onClickHandler(sender:)), for: .touchUpInside)
        
        view.addSubview(textView)
    }
}

// MARK: 内部函数
extension ShowViewController {
    
    private func formatCityInfoForString(_ model: CityDetailData) -> String {
        
        var showString = ""
        
        guard let todayWeath = model.data.forecast.first else {
            return showString
        }
        
        showString.append("\(model.cityInfo.city) \n")
        showString.append("\(todayWeath.type) \n")
        showString.append("温度：\(todayWeath.low) ~ \(todayWeath.high) \n")
        showString.append("\(todayWeath.fx)  \(todayWeath.fl) \n")
        showString.append("湿度：\(model.data.shidu)  空气：\(model.data.quality) \n")
        showString.append("注意人群：\(model.data.ganmao) \n")
        showString.append("\(todayWeath.notice) \n")
        showString.append("数据更新时间：\(model.time) \n")
        
        return showString
    }
    
    private func refreshContent(_ model: CityDetailData) {
        textView.text = formatCityInfoForString(model)
    }
}

// MARK: 事件处理
extension ShowViewController {
    
    @objc func onClickHandler(sender: UIButton) {
        
        let cityListViewController = DetailViewController()
        cityListViewController.delegate = self
        present(cityListViewController, animated: true, completion: nil)
    }
}

// MARK: 网络请求
extension ShowViewController {

    func requestData(_ cityID: String) {
        
        RequestManager.shared.cityWeathDetailRequest(cityID) { [weak self] (data, error) -> (Void) in
            
            guard let self = self else {
                return
            }
            
            if error != nil {
                return
            }
            
            do {
                print(try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves))
                let resultModel = try JSONDecoder().decode(CityDetailData.self, from: data!)
                self.refreshContent(resultModel)
            }
            catch {
                fatalError("JSONDecoder decode error !")
            }
        }
    }
}

// Delegate
extension ShowViewController: DetailViewControllerProtocol {
    
    func selectedCity(code: String) {
        WeathTool.saveDefaultCityCode(code)
        requestData(code)
    }
}
