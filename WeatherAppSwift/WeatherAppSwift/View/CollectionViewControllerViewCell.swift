//
//  CollectionViewControllerViewCell.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/16.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

class CollectionViewControllerViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel?
    @IBOutlet weak var contentLabel: UILabel?
    @IBOutlet weak var containView: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        containView?.layer.cornerRadius = 10
    }

    public func refreshCell(with forecast: Forecast, isToday: Bool) {
        
        containView?.backgroundColor = isToday ? UIColor.systemOrange : .lightGray
        
        timeLabel?.text = "日期: \(forecast.ymd)"
        
        var showString = ""
        showString.append("\(forecast.type) \n")
        showString.append("温度：\(forecast.low) ~ \(forecast.high) \n")
        showString.append("\(forecast.fx)  \(forecast.fl) \n")
        showString.append("\(forecast.notice) \n")
        
        contentLabel?.text = showString
    }
}
