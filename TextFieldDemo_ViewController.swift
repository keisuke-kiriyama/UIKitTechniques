//
//  ViewController.swift
//  TextFieldDemo
//
//  Created by 桐山圭祐 on 2017/07/09.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var _textField: UITextField!
    @IBOutlet weak var _textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let accessoryBar = UIToolbar()
        accessoryBar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(ViewController.doneBtnDidPushed))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryBar.setItems([spacer, doneBtn], animated: true)
        
        _textField.delegate = self as? UITextFieldDelegate
        
        //ツールバーをtextViewのアクセサリViewに設定
        _textView.inputAccessoryView = accessoryBar
    }
    
    //UITextFieldDelegeteプロトコルのメソッド
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //textFieldをFirst Responderから外す
        textField.resignFirstResponder()
        return true
    }
    
    func doneBtnDidPushed() {
        self._textView.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

