//
//  ShowViewController.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/2.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit


class ShowViewController: UIViewController {
    
    var searchButton: UIButton?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        
        createLable()
        createImageView()
        creatGestureRecognizer()
        
        searchButton = UIButton(frame: CGRect(x: 0, y: view.bounds.height/2, width: 100, height: 50))
        searchButton?.setTitle("点击", for: .normal)
        searchButton?.setTitle("按住", for: .highlighted)
        searchButton?.backgroundColor = .gray
        view.addSubview(searchButton!)
        
        searchButton?.addTarget(self, action: #selector(onClickHandler(sender:)), for: .touchUpInside)

    }
    
    @objc func onClickHandler(sender: UIButton) {
       
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    @objc func onClickRequestHandler() {
        
        let url = URL(string: "http://t.weather.sojson.com/api/weather/city/101030100")
        var request = URLRequest(url: url!)
        request.httpMethod = "Get"
        
        print("请求URL:",url?.description ?? "")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            let dicStr = String(data: data ?? Data(), encoding: .utf8)
            print("data: \(dicStr ?? "")")
        }
        task.resume()
    }
    
    func createLable() {
        
        let showTxt = UILabel(frame: CGRect(x: 10, y: 100, width: 200, height: 50))
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
    
    func createImageView() {
        
        let image0 = UIImage(named: "home")
        let image1 = UIImage(named: "personal")
        
        let imageView = UIImageView(image: image0)
        imageView.backgroundColor = .white
        imageView.frame = CGRect(x: 0, y: 300, width: 100, height: 100)
        view.addSubview(imageView)
        
        let animationImageView = UIImageView()
        animationImageView.frame = CGRect(x: 100, y: 300, width: 100, height: 100)
        animationImageView.animationImages = [image0!, image1!]
        animationImageView.animationDuration = 0.5
        animationImageView.startAnimating()
        view.addSubview(animationImageView)
        
        imageView.contentMode = .scaleAspectFit
        
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        keyframeAnimation.keyTimes = [0, 0.2, 1]
        keyframeAnimation.values = [1, 2, 1]
        keyframeAnimation.duration = 5
        
        let keyframeAnimationMove = CAKeyframeAnimation(keyPath: "transform.scale")
        keyframeAnimationMove.keyTimes = [0, 0.2, 1]
        keyframeAnimationMove.values = [1, 2, 1]
        keyframeAnimationMove.beginTime = 5
        keyframeAnimationMove.duration = 5
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 10
        animationGroup.animations = [keyframeAnimation, keyframeAnimationMove]
        
        animationImageView.layer.add(animationGroup, forKey: "animationGoup")
    }
    
    func creatGestureRecognizer() {
        
        let tapView = UIView(frame: CGRect(x: 0, y: 500, width: 200, height: 100))
        tapView.backgroundColor = .cyan
        view.addSubview(tapView)
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(onClickRequestHandler))
        tapView.addGestureRecognizer(tapGR)
    }
}
