//
//  ViewController.swift
//  Restore2Demo
//
//  Created by 桐山圭祐 on 2017/07/15.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var _modal: USViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnDidPush(_ sender: UIButton) {
        let vc = USViewController()
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        
        //モーダルで表示
        self.present(vc, animated: true, completion: nil)
        self._modal = vc
    }
    
}



class USViewController: UIViewController, UITextFieldDelegate, UIViewControllerRestoration {
    
    var _textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        textField.borderStyle = .roundedRect
        textField.delegate = self
        self.view.addSubview(textField)
        setConstraint(textField: textField)
        self._textField = textField
        
        //復元IDを必ず指定
        self.restorationIdentifier = "modalVC"
        
        //復元を担保するクラスに自信を指定
        self.restorationClass = type(of: self)
    }
    
    func setConstraint(textField: UITextField) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        //垂直方向の設定
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-100-[textField]", options: .directionLeadingToTrailing, metrics: nil, views: ["textField" : textField, "topLayoutGuide" : topLayoutGuide]))
        
        view.addConstraint(NSLayoutConstraint(item: textField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: textField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: textField.frame.width))
        
    }
    
    //復元するデータを保存
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        coder.encode(_textField.text, forKey: "MyText")
        
    }
    
    //復元
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        if let text = coder.decodeObject(forKey: "MyText") as? String {
            _textField.text = text
        }
    }
    
    
    //UIViewControllerRestorationのプロトコルメソッド
    //プロトコルを実装するクラスがインスタンス化されていなくても実行できるようにクラスメソッドになっている
    class func viewController(withRestorationIdentifierPath identifierComponents: [Any], coder: NSCoder) -> UIViewController? {
        print("identifierComponents : \(identifierComponents)")
        
        //ここではstoryboardからインスタンスを作成
        if let restorationId = identifierComponents.last as? String {
            if restorationId == "modalVC" {
                return USViewController()
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
}

