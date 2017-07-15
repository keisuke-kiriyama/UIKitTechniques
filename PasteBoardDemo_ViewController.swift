//
//  ViewController.swift
//  PasteBoardDemo
//
//  Created by 桐山圭祐 on 2017/07/09.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//



/*


エラー未解決

*/


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var _label: USLabel!
    @IBOutlet weak var _imageView: USImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _label.isUserInteractionEnabled = true
        _imageView.isUserInteractionEnabled = true
        
        //_labelと_imageViewにそれぞれタップのRecognizerを設置する
        let tapRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(self.tapHandler(sender:)))
        _label.addGestureRecognizer(tapRecognizer1)
        
        let tapRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(self.tapHandler(sender:)))
        _imageView.addGestureRecognizer(tapRecognizer2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.menuDidHide(notification:)), name: NSNotification.Name.UIMenuControllerDidHideMenu, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.menuDidHide(notification:)), name: NSNotification.Name.UIMenuControllerDidHideMenu, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIMenuControllerDidHideMenu, object: nil)
    }
    
//    func tapHandler(sender: UITapGestureRecognizer) {
//        let pasteboard = UIPasteboard.general
//        
//        if let v = sender.view {
//            if v is UILabel {
//                print("UIlabelがタップされました")
//                pasteboard.string = (v as! UILabel).text
//            }else if v is UIImageView {
//                print("UIImageViewがタップされました")
//                pasteboard.image = (v as! UIImageView).image
//            }
//        }
//        
//        print("name: \(pasteboard.name), persistent: \(pasteboard.isPersistent), string: \(String(describing: pasteboard.string))), type: \(pasteboard.types)")
//    }
    
    func tapHandler(sender: UITapGestureRecognizer) {
        sender.view?.becomeFirstResponder()
        let menuController = UIMenuController.shared
        //Editingメニューを表示する対象を指定
        menuController.setTargetRect(sender.view!.frame, in: self.view)
        //メニューを表示
        menuController.setMenuVisible(true, animated: true)
        print("\(menuController.isMenuVisible)")
    }
    
    func menuDidHide(notification: NSNotification) {
        print("menuDidHide")
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class USLabel: UILabel {
    //FirstResponderになれると返答する必要がある
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        //アクションがコピーの時は、このインスタンスで処理可能と返答
        if action == #selector(UIResponderStandardEditActions.copy(_:)) {
            return true
        }else {
            //その他すべてfalseとはしてはいけない(Nil-targeted Actionを利用しているため)
            return super.canPerformAction(action, withSender: sender)
        }
    }
    
    //Editingメニューで「Copy」が選択されると呼ばれる
    override func copy(_ sender: Any?) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = self.text
        print("name: \(pasteboard.name), persistent: \(pasteboard.isPersistent), string: \(String(describing: pasteboard.string))), type: \(pasteboard.types)")
    }
}

class USImageView: UIImageView {
    //FirstResponderになれると返答する必要がある
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        //アクションがコピーの時は、このインスタンスで処理可能と返答
        if action == #selector(UIResponderStandardEditActions.copy(_:)) {
            return true
        }else {
            //その他すべてfalseとはしてはいけない(Nil-targeted Actionを利用しているため)
            return super.canPerformAction(action, withSender: sender)
        }
    }
    
    //Editingメニューで「Copy」が選択されると呼ばれる
    override func copy(_ sender: Any?) {
        let pasteboard = UIPasteboard.general
        pasteboard.image = self.image
        print("name: \(pasteboard.name), persistent: \(pasteboard.isPersistent), string: \(String(describing: pasteboard.string))), type: \(pasteboard.types)")
    }
}

