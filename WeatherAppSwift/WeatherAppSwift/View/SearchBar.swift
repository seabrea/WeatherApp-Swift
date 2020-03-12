//
//  SearchBar.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/10.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

class SearchBar: UITextField {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchBar {
    
    func configUI() {
        
        backgroundColor = .lightGray
        placeholder = "请输入相关内容"
        leftView = UIImageView(image: UIImage(named: "search_top_gray"))
        leftViewMode = .always
        clearButtonMode = .always
    }
}
