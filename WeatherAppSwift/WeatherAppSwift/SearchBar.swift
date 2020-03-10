//
//  SearchBar.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/10.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit
import SnapKit

class SearchBar: UIView {
    
    var inputFeild: UITextField {
        let inputLabel = UITextField(frame: CGRect.zero)
        inputLabel.backgroundColor = .lightGray
        inputLabel.delegate = self
        inputLabel.placeholder = "请输入相关内容"
//        inputLabel.leftView = UIImageView(image: UIImage(named: "search_top_gray"))
//        inputLabel.leftViewMode = .always
//        inputLabel.clearButtonMode = .always
        return inputLabel
    }
    
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
        self.addSubview(inputFeild)
        inputFeild.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
    }
}

extension SearchBar: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print(textField.text ?? "empty")
        return true
    }
}
