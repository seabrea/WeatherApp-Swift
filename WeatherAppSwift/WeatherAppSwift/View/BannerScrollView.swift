//
//  BannerScrollView.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/4.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

class BannerScrollView: UIScrollView {
    
    var scroViewSize = CGSize.zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        configUI(size: CGSize(width: frame.width, height: frame.height))
    }
    
    required init?(coder: NSCoder) {
        fatalError("no coder init")
    }
    
    func configUI(size: CGSize) {
        scroViewSize = size
        isPagingEnabled = true
    }
    
    func refreshUI(data: [String]) {
        
        guard data.count > 0 else {
            fatalError("data error: no data")
        }
        
        contentSize = CGSize(width: scroViewSize.width * CGFloat(data.count), height: scroViewSize.height)
        contentOffset = CGPoint.zero
        
        for index in 0..<data.count {
            let imageName = data[index]
            let showImageView = UIImageView(image: UIImage(named: imageName))
            showImageView.frame = CGRect(x: CGFloat(index) * scroViewSize.width, y: 0, width: scroViewSize.width, height: scroViewSize.height)
            addSubview(showImageView)
        }
    }
}
