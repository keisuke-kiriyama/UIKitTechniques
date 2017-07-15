//
//  ViewController.swift
//  RecognizerDemo
//
//  Created by 桐山圭祐 on 2017/07/08.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var _label: UILabel!
    @IBOutlet var tapRecognizer: UITapGestureRecognizer!
    var doubleTapRecognizer: UITapGestureRecognizer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _label.isUserInteractionEnabled = true
        
        //recognizerをインスタンス化する。どのオブジェクトが持つどのメソッドにイベントをディスパッチするか設定する。
        let swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRightHandler(sender:)))
        
        swipeRightRecognizer.direction = .right
        _label.addGestureRecognizer(swipeRightRecognizer)
        
        //回転
        let rotateRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(self.rotateHandler(sender:)))
        self.view.addGestureRecognizer(rotateRecognizer)
        print("検知開始 (state : \(rotateRecognizer.state.rawValue))")
        
        //ダブルタップ
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapHandler(sender:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        _label.addGestureRecognizer(doubleTapRecognizer)
        self.doubleTapRecognizer = doubleTapRecognizer
        
        //ダブルタップの検出がfailedになるまでタップの検出を待ち合わせる。
        tapRecognizer.require(toFail: doubleTapRecognizer)
        //tapRecognizer.delegate = self as? UIGestureRecognizerDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapHandler(_ sender: UITapGestureRecognizer) {
//        let location = sender.location(in: self.view)
//        print("ラベルがタッチされました (x : \(location.x), y : \(location.y))")
        print("ラベルがタップされました(tap state: \(sender.state.rawValue) double tap state: \(self.doubleTapRecognizer.state.rawValue))")
    }
    
    func swipeRightHandler(sender: UISwipeGestureRecognizer) {
        print("右にスワイプされました")
    }
    
    func rotateHandler(sender: UIRotationGestureRecognizer) {
        let location = sender.location(in: self.view)
        //回転角
        let transform = CGAffineTransform(rotationAngle: sender.rotation)
        
        //ラベルを回転させる
        _label.transform = transform
        print("Viewがrotateを検知しました(x: \(location.x) y: \(location.y) state: \(sender.state.rawValue)")
        
        if(sender.state == .ended) {
            //CGTransformIdentityは元の回転角、縮尺に戻す単位行列
            _label.transform = CGAffineTransform.identity
        }
    }
    
    func doubleTapHandler(sender: UITapGestureRecognizer){
        print("ラベルがダブルタップされました。(tap state: \(sender.state.rawValue) double tap state: \(self.doubleTapRecognizer.state.rawValue))")
    }
    
    //MARK: - UIGestureRecognizerDelegatenのメソッド
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRequiredFailerOfGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) ->Bool {
        if(self.tapRecognizer! == gestureRecognizer && self.doubleTapRecognizer! == otherGestureRecognizer) {
            print("待ち合わせします \(gestureRecognizer), \(otherGestureRecognizer)")
            return true
        }else{
            print("待ち合わせしません \(gestureRecognizer), \(otherGestureRecognizer)")
            return false
        }
    }

}

