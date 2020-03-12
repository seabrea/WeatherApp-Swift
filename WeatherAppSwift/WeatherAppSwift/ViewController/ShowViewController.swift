//
//  ShowViewController.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/2.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit
import SnapKit

class ShowViewController: UIViewController {
    
    var searchButton: UIButton!
    var showTxt: UILabel!
    var textView: UITextView!
    
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
        createLable()
        createButton()
    }
    
    func createButton() {
        
        let frame = CGRect(x: 10, y: 400, width: view.bounds.width - 20, height: (navigationController?.navigationBar.bounds.height)!)
        let searchBar = SearchBar(frame: frame)
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        searchButton = {
            let btn = UIButton(frame: CGRect(x: view.bounds.width/2 - 100, y: view.bounds.height/2 + 100, width: 200, height: 50))
            btn.setTitle("点击查看更多城市", for: .normal)
            btn.setTitle("松开跳转城市选择", for: .highlighted)
            btn.backgroundColor = .lightGray
            btn.layer.cornerRadius = 20
            return btn
        }()
        
        view.addSubview(searchButton!)
        
        searchButton.addTarget(self, action: #selector(onClickHandler(sender:)), for: .touchUpInside)
    }
    
    
    
    func createLable() {
        
        showTxt = UILabel(frame: CGRect(x: 10, y: 100, width: 200, height: 50))
        showTxt.text = "文字展示"
        showTxt.textColor = .orange
        showTxt.font = UIFont.systemFont(ofSize: 16)
        showTxt.textAlignment = .left
        showTxt.backgroundColor = .darkGray
        showTxt.numberOfLines = 1
        showTxt.lineBreakMode = .byTruncatingTail
        view.addSubview(showTxt)
        
        let inputFeild = UITextField(frame: CGRect(x: 10, y: 150, width: 200, height: 50))
        inputFeild.backgroundColor = .orange
        inputFeild.placeholder = "请输入内容"
        view.addSubview(inputFeild)
        
        textView = UITextView(frame: CGRect(x: 10, y: 200, width: 200, height: 100))
        textView.text = DefineConst.TestString.TestUITextViewContent
        textView.backgroundColor = .yellow
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
        
        RequestManager.shared.cityWeathDetailRequest(cityID) { [weak self] (data, error) -> (Void) in
            
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
        showTxt.text = model.message
        textView.text = model.message
    }
}

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
