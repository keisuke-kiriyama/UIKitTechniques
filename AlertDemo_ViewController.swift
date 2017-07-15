//
//  ViewController.swift
//  AlertDemo
//
//  Created by 桐山圭祐 on 2017/07/12.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        let alertController = UIAlertController(title: "ご利用ありがとうございます", message: "Twitterアカウントをお持ちですか？このアプリはTwitterアカウントでご利用できます。", preferredStyle: .alert)
//        let otherAction = UIAlertAction(title: "設定する", style: .default, handler: {action in print("\(String(describing: action.title))が押されました")})
//        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: { action in print("\(String(describing: action.title))が押されました")})
//        
//        //cancelは追加する順序に関わらず左側に表示される
//        alertController.addAction(otherAction)
//        alertController.addAction(cancelAction)
//        
//        self.present(alertController, animated: true, completion: nil)
//    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let alertController = UIAlertController(title: "新規登録", message: nil, preferredStyle: .alert)
        
        //テキストフィールドを追加
        alertController.addTextField(configurationHandler: ({(textField: UITextField) -> Void in textField.placeholder = "メールアドレス"}))
        
        alertController.addTextField(configurationHandler: ({(textField: UITextField) -> Void in
            textField.placeholder = "パスワード"
            textField.isSecureTextEntry = true}
        ))
        
        let otherAction = UIAlertAction(title: "登録する", style: .default, handler: { action in
            print("\(String(describing: action.title))が押されました")
            if let textField = alertController.textFields?.first {
                print("メールアドレス" + textField.text!)
            }
            if let textField = alertController.textFields?.last {
                print("パスワード" + textField.text!)
            }})
            
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: {action in print("\(String(describing: action.title))が押されました")})
            
        //.cancelは右側に表示される
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
            
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnDidPush(_ sender: UIButton) {
        let alertController = UIAlertController(title: "ユーザ登録", message: "すべての機能を利用するには、ユーザ登録が必要です。", preferredStyle: .actionSheet)
        
        let makeAccount1 = UIAlertAction(title: "Twitterアカウントを作成", style: .default, handler: { action in print("\(String(describing: action.title))が押されました") })
        
        let makeAccount2 = UIAlertAction(title: "メールアドレスとパスワードで登録", style: .default, handler: { action in print("\(String(describing: action.title))が押されました") })
        
        let notMakeAccount = UIAlertAction(title: "登録しないで利用", style: .cancel, handler: { action in print("\(String(describing: action.title))が押されました")})
        
        alertController.addAction(makeAccount1)
        alertController.addAction(makeAccount2)
        alertController.addAction(notMakeAccount)
        
        //ポップオーバーのための設定
        if let presenter = alertController.popoverPresentationController {
            //吹き出しの位置や向きを決定するため、
            //ポップオーバーが出る要因になったUI部品を指定
            presenter.sourceView = sender
            presenter.sourceRect = sender.bounds
            
            //吹き出しの三角部分の向きを制御できる
            presenter.permittedArrowDirections = .any
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    

}

