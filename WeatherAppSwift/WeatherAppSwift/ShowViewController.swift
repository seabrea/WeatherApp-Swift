//
//  ShowViewController.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/2.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit


class ShowViewController: UIViewController {
    
    var searchButton: UIButton!
    var showTxt: UILabel!
    
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
        
        let nextLable = UILabel(frame: CGRect(x: 210, y: 100, width: 0, height: 0))
        nextLable.text = "下一段话语"
        nextLable.sizeToFit()
        nextLable.textColor = .orange
        nextLable.backgroundColor = .blue
        view.addSubview(nextLable)
        
        let finalLabel = UILabel(frame: CGRect(x: 210 + nextLable.bounds.width, y: 100, width: 0, height: 0))
        finalLabel.text = "结束话题"
        finalLabel.textColor = .orange
        finalLabel.backgroundColor = .green
        finalLabel.sizeToFit()
        view.addSubview(finalLabel)
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
