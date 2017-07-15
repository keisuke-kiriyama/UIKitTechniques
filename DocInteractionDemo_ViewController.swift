//
//  ViewController.swift
//  DocInteractionDemo
//
//  Created by 桐山圭祐 on 2017/07/13.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    
    var diControler: UIDocumentInteractionController?
    var sender: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnDidPush(_ sender: UIButton) {
        self.sender = sender //追加
        
        let url = Bundle.main.url(forResource: "SNSBack", withExtension: "png")
        let diController = UIDocumentInteractionController(url: url!)
        
        //annotationプロパティでDictionaryを渡すことが可能
        diController.annotation = ["param1" : "xxx", "param2" : "yyy", "param3" : "zzz"]
        //必ずしもutiの指定は必要ではない
        diController.uti = "public.png"
        
        diController.delegate = self
        
        //プレビュー画面を表示
        if !diController.presentPreview(animated: true) {
            let alertController = UIAlertController(title: "アプリ連携に失敗しました", message: "このファイルを処理できるアプリがありません", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        self.diControler = diController
    
    
        //DocumentInteraction画面を表示
//        if !diController.presentOptionsMenu(from: sender.bounds, in: sender, animated: true) {
//            
//            let alertController = UIAlertController(title: "アプリ連携に失敗しました", message: "このファイルを処理できるアプリがありません", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alertController, animated: true, completion: nil)
//        }
//        self.diControler = diController
    }
    
    //UIDocumentInteractionControllerDelegateプロトコルのメソッド
    //Modalでプレビューを表示するViewControllerを返すように実装
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    //画像が飛び出すようにできる
    func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
        return self.sender
    }
    
    func documentInteractionControllerRectForPreview(_ controller: UIDocumentInteractionController) -> CGRect {
        //documentInteractionControllerVIewForPreviewメソッドがnilを返す場合
        //このメソッドは呼ばれない
        return self.sender!.bounds
    }
    
    
}

