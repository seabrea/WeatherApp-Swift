//
//  PersonalViewController.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/8.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit
import Kingfisher

class PersonalViewController: UIViewController {
    
    lazy var topImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width/1.3))
        return imageView
    }()
    
    lazy var avplayerView: UIView = {
        let playerView = UIView(frame: CGRect(x: 0, y: view.bounds.width/1.3, width: view.bounds.width, height: view.bounds.width * 9 / 16))
        playerView.backgroundColor = .black
        return playerView
    }()
    

    override func viewDidLoad() {

        super.viewDidLoad()
        configUI()
    }
    
    func configUI() {
        
        view.addSubview(topImageView)
        view.addSubview(avplayerView)
        
        topImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: DefineConst.TestImageUrl)!))
        
    }
}
