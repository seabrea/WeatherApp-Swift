//
//  CommentManager.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/11.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

class CommentManager: NSObject {
    
    var backgroudView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        return view
    }()
    
    var textView: UITextView = {
        let view = UITextView(frame: CGRect(x: 0, y: DefineConst.HScreen, width: DefineConst.WScreen, height: 100))
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    
    static let shared: CommentManager = {
        let manager = CommentManager()
        return manager
    }()
    
    private override init() {
        super.init()
        configView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configView() {
        
        textView.delegate = self
        backgroudView.addSubview(textView)
        
        backgroudView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backGroudTaphander)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFameChangeHander(notif:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}

// MARK: 对外开放的接口
extension CommentManager {
    
    public func showCommentInputView() {
        
        let window = DefineConst.KeyWindow
        window?.addSubview(backgroudView)
        
        textView.becomeFirstResponder()
    }
}

// MARK: 事件处理
extension CommentManager {
    
    @objc private func backGroudTaphander() {
        textView.resignFirstResponder()
        backgroudView.removeFromSuperview()
    }
    
    @objc private func keyboardFameChangeHander(notif: Notification) {
        
        let duration = notif.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Float
        let keyFrame = notif.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        
        if keyFrame.origin.y >= backgroudView.bounds.height {
            
            UIView.animate(withDuration: TimeInterval(duration)) {
                self.textView.frame = CGRect(x: 0, y: DefineConst.HScreen, width: DefineConst.WScreen, height: 100)
            }
        }
        else {
            textView.frame = CGRect(x: 0, y: DefineConst.HScreen, width: DefineConst.WScreen, height: 100)
            let curKeyboardFrameH = DefineConst.HScreen - keyFrame.size.height - textView.bounds.height
            UIView.animate(withDuration: TimeInterval(duration)) {
                self.textView.frame = CGRect(x: 0, y: curKeyboardFrameH, width: DefineConst.WScreen, height: 100)
            }
        }
    }
}

// MARK: UITextViewDelegate
extension CommentManager: UITextViewDelegate {
    
}
