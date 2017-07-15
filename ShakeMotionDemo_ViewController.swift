//
//  ViewController.swift
//  ShakeMotionDemo
//
//  Created by 桐山圭祐 on 2017/07/08.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //view表示時にfirstresponderになる
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    
    //viewが非表示になる時にfirstresponderをやめる
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.resignFirstResponder()
    }
    
    override var canBecomeFirstResponder: Bool { get { return true } }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        var alertController = UIAlertController(title: "シェイクモーション", message: "イベントを検出", preferredStyle: .alert)
        let action = UIAlertAction(title: "了解", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

