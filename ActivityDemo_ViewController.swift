//
//  ViewController.swift
//  ActivityDemo
//
//  Created by 桐山圭祐 on 2017/07/13.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnDidPush(_ sender: UIButton) {
        let items = ["ジブンスタイルのホームページ",URL(string: "http://www.jibunstyle.com/")!] as [Any]
        
        //渡したいデータを並列で指定して、インスタンスを生成
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        //UIAlertController同様,iPad向けの設定が必要
        if let presenter = avc.popoverPresentationController{
            presenter.sourceView = sender
            presenter.sourceRect = sender.bounds
            presenter.permittedArrowDirections = .any
        }
        
        //UIActivityViewControlerを表示
        self.present(avc, animated: true, completion: nil)
        
    }

}

