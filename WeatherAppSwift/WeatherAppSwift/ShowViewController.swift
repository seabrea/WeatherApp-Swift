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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configData()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
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
        
//        let searchBar = SearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 20, height: (navigationController?.navigationBar.bounds.height)!))
//        navigationItem.titleView = {
//            let frame = CGRect(x: 0, y: 0, width: view.bounds.width - 20, height: (navigationController?.navigationBar.bounds.height)!)
//            let searchBar = SearchBar(frame: frame)
//            let view = UIView(frame: frame)
//            view.addSubview(searchBar)
//            return view
//        }()
        
        let frame = CGRect(x: 0, y: 300, width: view.bounds.width - 20, height: (navigationController?.navigationBar.bounds.height)!)
        let searchBar = SearchBar(frame: frame)
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
    
    @objc func onClickHandler(sender: UIButton) {
        
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
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
        
        let textView = UITextView(frame: CGRect(x: 10, y: 200, width: 200, height: 100))
        textView.text = "红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚，红红火火恍恍惚惚"
        textView.backgroundColor = .yellow
        view.addSubview(textView)
    }
    
    func refreshContent(_ model: CityDetailData) {
        showTxt.text = model.message
    }
    
    func requestData(_ cityID: String) {
        
        let url = URL(string: DefineConst.WeatherRequestUrl + cityID)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { [weak self] (data, response, error) in
            
            guard let self = self else {
                return
            }
            
            if error != nil {
                return
            }
            
            var resultModel: CityDetailData?
            do {
                resultModel = try JSONDecoder().decode(CityDetailData.self, from: data!)
            }
            catch {
                fatalError()
            }
            
            DispatchQueue.main.async {
                self.refreshContent(resultModel!)
            } 
        }
        task.resume()
    }
}
