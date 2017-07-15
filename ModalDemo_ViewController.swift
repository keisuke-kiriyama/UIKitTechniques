//
//  ViewController.swift
//  ModalDemo
//
//  Created by 桐山圭祐 on 2017/07/07.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController, USViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let modal = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? USViewController {
            //modalTransitionStyleで移り変わり方変更可能
            modal.modalTransitionStyle = .flipHorizontal
            modal.modalPresentationStyle = .popover
            modal.view.backgroundColor = UIColor.green
            
            modal.delegate = self
            self.present(modal, animated: animated, completion: nil)
        }
    }
    
    func closeBtnDidPush(sender: USViewController) {
        self.dismiss(animated: true, completion: nil)
    }


}

