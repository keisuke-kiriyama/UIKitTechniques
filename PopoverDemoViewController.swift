//
//  ViewController.swift
//  PopoverDemo
//
//  Created by 桐山圭祐 on 2017/07/12.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIPopoverPresentationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnDidPush(_ sender: UIButton) {
        //storyboardから、対象のViewControllerのインスタンスを取得
        if let popoverWebView = self.storyboard?.instantiateViewController(withIdentifier: "popoverWebView") as? UIViewController {
            //表示形式をポップオーバーにし、大きさを指定する。
            popoverWebView.modalPresentationStyle = .popover
            popoverWebView.preferredContentSize = CGSize(width: 300, height: 200)
            
            let presenter = popoverWebView.popoverPresentationController
            presenter?.sourceView = sender
            presenter?.sourceRect = sender.bounds
            presenter?.permittedArrowDirections = .any
            
            //表示に関する処理をViewControllerに委譲するように設定
            presenter?.delegate = self
            
            self.present(popoverWebView, animated: true, completion: nil)
        }
    }
    
    //iphoneでもポップオーバーを表示するにはこのメソッドを実装して、
    //UIModalPresentationStyle.Noneを返す必要がある。
    //ないとpフルスクリーンで表示されてしまう
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

}

