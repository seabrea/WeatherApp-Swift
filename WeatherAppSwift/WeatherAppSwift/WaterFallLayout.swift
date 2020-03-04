//
//  WaterFallLayout.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/4.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

protocol WaterFallLayoutDelegate: AnyObject {
    
    func waterFall(layout: WaterFallLayout, heightForCellAtIndexPath:IndexPath) -> Float;
}

class WaterFallLayout: UICollectionViewLayout {
    
    weak var delegate: WaterFallLayoutDelegate?
    
    var itemHeightArray = [Float]()
    
    var itemSizeArray = [CGSize]()
    
    var miniLineSpacing = 0 {
        didSet {
            update()
        }
    }
    
    var miniItemSpacing = 0 {
        didSet {
            update()
        }
    }
    
    var edgeInsets = UIEdgeInsets.zero {
        didSet {
            update()
        }
    }
    
    func update() {
        
    }
    
    // 准备布局，计算item的信息
    override func prepare() {
        super.prepare()
    }
}
