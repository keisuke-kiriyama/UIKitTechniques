//
//  USViewController.swift
//  PopoverDemo
//
//  Created by 桐山圭祐 on 2017/07/12.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class USViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var _webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _webView.delegate = self as! UIWebViewDelegate
        self.loadRequest(urlString: "http://www.jibunstyle.com")
        
        // Do any additional setup after loading the view.
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
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //ステータスバーのインジケータ削除
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

