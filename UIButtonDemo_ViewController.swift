//
//  ViewController.swift
//  UIButtonDemo
//
//  Created by 桐山圭祐 on 2017/07/08.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var _button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _button.addTarget(self, action: #selector(self.btnDidPush(sender:)), for: .touchUpInside)
    }
    
    func btnDidPush(sender: UIButton){
        print("押されました")
        sender.removeTarget(self, action: #selector(self.btnDidPush(sender:)), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

