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
    
    var textView: UITextView = {
        let newView = UITextView(frame: CGRect(x: 10, y: 200, width: 200, height: 100))
        newView.text = DefineConst.TestString.TestUITextViewContent
        newView.backgroundColor = .yellow
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
            let path = Bundle.main.path(forResource: "cityCode", ofType: "plist")
            let plist = NSArray(contentsOfFile: path!) as? [NSDictionary]
            let cityCode = (plist?.first!["city_code"] as! NSNumber).description
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

// 事件处理
extension ShowViewController {
    
    @objc func onClickHandler(sender: UIButton) {
        
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: 网络请求
extension ShowViewController {

    func requestData(_ cityID: String) {
        
        LoadingManager.show()
        RequestManager.shared.cityWeathDetailRequest(cityID) { [weak self] (data, error) -> (Void) in
            
            LoadingManager.hide()
            
            guard let self = self else {
                return
            }
            
            if error != nil {
                return
            }
            
            do {
                let resultModel = try JSONDecoder().decode(CityDetailData.self, from: data!)
                self.refreshContent(resultModel)
            }
            catch {
                fatalError("JSONDecoder decode error !")
            }
        }
    }
    
    func refreshContent(_ model: CityDetailData) {
        textView.text = model.message
    }
}

// Delegate
extension ShowViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        CommentManager.shared.showCommentInputView()
        return false
    }
}
