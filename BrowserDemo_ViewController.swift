//
//  ViewController.swift
//  BrowserDemo
//
//  Created by 桐山圭祐 on 2017/07/12.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var _webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _webView.delegate = self
        //self.loadRequest(urlString: "http://www.jibunstyle.com")
        if let targetURL = Bundle.main.path(forResource: "index", ofType: "html") {
            self.loadRequest(urlString: targetURL)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadRequest(urlString: String) {
        let queryUrl = URL(string: urlString)
        let req = URLRequest(url: queryUrl!)
        _webView.loadRequest(req)
        
        //ステータスバーのインジケータを表示
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    }
    
    //UIWebViewDelegateプロトコルのメソッド
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //ステータスバーのインジケータ削除
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if let title =  webView.stringByEvaluatingJavaScript(from: "document.title;") {
            print("page title: \(title)")
        }
        
        if let ret = webView.stringByEvaluatingJavaScript(from: "comfirm('知っていました？") {
            print("return values: \(ret)")
        }
    }
}

