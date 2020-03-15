//
//  AboutViewController.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/15.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    var textView: UITextView = {
        let newView = UITextView()
        newView.textAlignment = .center
        newView.font = UIFont.boldSystemFont(ofSize: 20)
        newView.textContainerInset = UIEdgeInsets(top: 100, left: 50, bottom: 50, right: 50)
        newView.dataDetectorTypes = .link
        newView.isEditable = false
        return newView
    }()
    
    let showString =
    "版本: 0.1 \n \n" +
    "本APP采用 Swift5.0 + iOS 13 完成，用于熟练iOS开发的相关功能。 \n \n" +
    "Github: https://github.com/seabrea/WeatherApp-Swift"

    override func viewDidLoad() {
        
        super.viewDidLoad()
        configUI()
    }
    
    private func configUI() {
        
        textView.frame = view.bounds
        textView.text = showString
        view.addSubview(textView)
    }
}
