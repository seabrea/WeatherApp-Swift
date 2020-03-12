//
//  WebViewController.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/5.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView: WKWebView!
    var progressview:UIProgressView!
    var observation: NSKeyValueObservation?
    
    deinit {
        logDealloc(className: self.classForCoder)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configUI()
        refreshWeb()
    }

    func configUI() {
        
        webView = {
            let webConfig = WKWebViewConfiguration()
            
            let webview = WKWebView(frame: self.view.bounds, configuration: webConfig)
            webview.uiDelegate = self
            webview.navigationDelegate = self
            
            return webview
        }()
        
        progressview = {
            let navigationHeigt = CGFloat((navigationController?.navigationBar.frame.size.height) ?? 0)
            let stateHeigt = (UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height) ?? 0
            let pview = UIProgressView(frame: CGRect(x: 0, y: (navigationHeigt + stateHeigt), width: webView.bounds.width, height: 5))
            return pview
        }()

        view.addSubview(webView)
        webView.addSubview(progressview)
        
        observation = webView.observe(\WKWebView.estimatedProgress, options: .new) { [weak self] (wkwebview, change) in
            
            guard let self = self else {
                return
            }
            print("已经加载 \(change.newValue! * 100)%")
            self.progressview.progress = Float(wkwebview.estimatedProgress)
        }
    }
    
    func refreshWeb() {
        
        if let urlPath = URL(string: "https://m.baidu.com") {
            webView.load(URLRequest(url: urlPath))
        }
    }
}

extension WebViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("是否加载")
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Load Finish")
    }
}
