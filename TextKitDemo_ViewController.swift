//
//  ViewController.swift
//  TextKitDemo
//
//  Created by 桐山圭祐 on 2017/07/09.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var _image: UIImageView!
    @IBOutlet weak var _textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //root viewのlayoutSubviewメソッドが実行された直後に呼ばれる。
    override func viewDidLayoutSubviews() {
        //ルートviewの左上を原点とする座標で示される_imageのframeを、
        //_textViewの左上を原点とする座標に変換
        let rect = CGRect(origin: _image.frame.origin, size: _image.frame.size)
        let exclusionRect = rect.offsetBy(dx: -(_textView.frame.origin.x + _textView.textContainerInset.left), dy: -(_textView.frame.origin.y + _textView.textContainerInset.top))
        
        //ベジェパスを作って_textViewのコンテナの除外領域に追加
        let path = UIBezierPath(rect: exclusionRect)
        _textView.textContainer.exclusionPaths = [path]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

