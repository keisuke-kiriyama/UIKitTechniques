//
//  ViewController.swift
//  DragImageVIewDemo
//
//  Created by 桐山圭祐 on 2017/07/08.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


class USImageView: UIImageView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //ユーザー操作に反応するようにする
        self.isUserInteractionEnabled = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        if let aTouch = touches.first as! UITouch? {
            //viewのいちとサイズを取得
            var frame = self.frame
            //タッチの位置を取得
            let location = aTouch.location(in: self.superview!)
            //前回のタッチの位置
            let prev = aTouch.previousLocation(in: self.superview!)
            //viewの位置を指が動いた分だけ移動
            frame.origin.x = frame.origin.x + (location.x - prev.x)
            frame.origin.y = frame.origin.y + (location.y - prev.y)
            self.frame = frame
        }
    }
}

