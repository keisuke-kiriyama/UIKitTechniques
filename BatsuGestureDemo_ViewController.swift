//
//  ViewController.swift
//  BatsuGestureDemo
//
//  Created by 桐山圭祐 on 2017/07/08.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let batsuGestureRecognizer = USBatsuGestureRecognizer(target: self, action: #selector(self.batsuGestureHandler(sender:)))
        self.view.addGestureRecognizer(batsuGestureRecognizer)
        print("検知開始 (state : \(batsuGestureRecognizer.state.rawValue))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func batsuGestureHandler(sender: USBatsuGestureRecognizer) {
        print("バツ")
    }


}

class USBatsuGestureRecognizer: UIGestureRecognizer {
    var start:CGPoint?
    var isSecondStroke = false
    
    struct BatsuCount {
        static let MIN_SLOPE: CGFloat = 0.4
        static let MAX_SLOPE: CGFloat = 2
        static let MIN_DISTANCE: CGFloat = 50
        static let MAX_DISTANCE: CGFloat = 300
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        
        //タッチが一本指でなかったらリターン
        if touches.count != 1 {
            self.state = UIGestureRecognizerState.failed
            return
        }
        
        //タッチした座標の取得
        if let touch = touches.first {
            let start = touch.location(in: self.view)
            self.start = start
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        
        if self.state == .possible {
            if let touch = touches.first, let start = self.start {
                let end = touch.location(in: self.view)
                
                //２点間の距離と傾き
                let x = start.x - end.x
                let y = start.y - end.y
                
                let slope = y/x
                let distance = sqrt(x*x + y*y)
                if isSecondStroke{//２画目
                    let rev = -slope
                    if BatsuCount.MIN_SLOPE < rev && rev < BatsuCount.MAX_SLOPE && BatsuCount.MIN_DISTANCE < distance && distance < BatsuCount.MAX_DISTANCE {
                        self.state = .ended
                    }
                    print("2画目 傾き: \(slope), 距離: \(distance), 結果: \(self.state == .ended)")
                    self.isSecondStroke = false
                }else{//１画目
                    if BatsuCount.MIN_SLOPE < slope && slope < BatsuCount.MAX_SLOPE && BatsuCount.MIN_DISTANCE < distance && distance < BatsuCount.MAX_DISTANCE {
                        self.isSecondStroke = true
                    }
                    print("1画目 傾き: \(slope), 距離: \(distance), 結果: \(self.isSecondStroke)")
                }
            }
        }
    }
    
}
