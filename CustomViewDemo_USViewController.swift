//
//  USViewController.swift
//  CustomViewDemo
//
//  Created by 桐山圭祐 on 2017/07/10.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class USViewController: UIViewController {
    
    @IBOutlet weak var _webView: UIWebView!
    var pdfPath: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let path = pdfPath {
            let url: NSURL = NSURL(fileURLWithPath: path)
            let req = NSURLRequest(url: url as URL)
            _webView.loadRequest(req as URLRequest)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
