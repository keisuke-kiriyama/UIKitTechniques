//
//  ViewController.swift
//  SegueDemo
//
//  Created by 桐山圭祐 on 2017/07/07.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.performSegue(withIdentifier: "toSecondScene", sender: self)
    }
    
    //Segueが実行される際に呼ばれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case .some("toSecondScene") :
            let dest = segue.destination
            //let color: UIColor = colorWithHexString("#EAA8BF")
            dest.view.backgroundColor = UIColor.green
        default:
            break
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


func colorWithHexString (_ hex:String) -> UIColor {
    
    let cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
    
    if ((cString as String).characters.count != 6) {
        return UIColor.gray
    }
    
    let rString = (cString as NSString).substring(with: NSRange(location: 0, length: 2))
    let gString = (cString as NSString).substring(with: NSRange(location: 2, length: 2))
    let bString = (cString as NSString).substring(with: NSRange(location: 4, length: 2))
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: rString).scanHexInt32(&r)
    Scanner(string: gString).scanHexInt32(&g)
    Scanner(string: bString).scanHexInt32(&b)
    
    return UIColor(
        red: CGFloat(Float(r) / 255.0),
        green: CGFloat(Float(g) / 255.0),
        blue: CGFloat(Float(b) / 255.0),
        alpha: CGFloat(Float(1.0))
    )
}
