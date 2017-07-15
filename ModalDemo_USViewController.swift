//
//  USViewController.swift
//  ModalDemo
//
//  Created by 桐山圭祐 on 2017/07/07.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit


protocol USViewControllerDelegate {
    func closeBtnDidPush(sender: USViewController)
}


class USViewController: UIViewController {
    
    var delegate : USViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnDidPushed(_ sender: Any) {
        self.delegate?.closeBtnDidPush(sender: self)
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
