//
//  ViewController.swift
//  RestoreDemo
//
//  Created by 桐山圭祐 on 2017/07/15.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate{
    @IBOutlet weak var _textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self._textField.delegate = self
    }
    
    //UIViewComtrollerのメソッドをオーバーライド
    
    //復元するデータを保存。データは暗号化されて保存されるためencodeと名前がついてる
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        //ここではUITextFieldの文字列を保存
        coder.encode(_textField.text, forKey: "MyText")
    }
    
    //復元するデータを複合
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        if let text = coder.decodeObject(forKey: "MyText") as? String {
            print("restore : \(text)")
            _textField.text = text
        }
    }
    
    //UITextFieldDelegateプロトコルのメソッド
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

