//
//  ViewController.swift
//  AnimateDemo
//
//  Created by 桐山圭祐 on 2017/07/10.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var duration: TimeInterval = 2.0
    var width: UInt32?
    var height: CGFloat?
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        width = UInt32(self.view.bounds.size.width)
        height = self.view.bounds.size.height
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if timer == .none{
            //一定間隔でrainnyメソッドを呼ぶ
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.rainny), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    
    func rainny() {
        //print(Thread.isMainThread)
        
        //雨粒の発生する水平方向の位置をランダム
        let x = CGFloat(arc4random_uniform(self.width!))
        //雨粒生成
        let v = UIView(frame: CGRect(x: x, y: 0, width: 2, height: 2))
        v.backgroundColor = UIColor.blue
        //UISliderで設定した値を基準にランダムで+-0.5のばらつきを与える
        let d = self.duration + TimeInterval((CGFloat(arc4random_uniform(10))-5)/10)
        //UIViewをアニメートするメソッド
//        UIView.animate(withDuration: d, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in v.center.y = self.height!}, completion: {(finish) -> Void in v.removeFromSuperview()})
        UIView.animateKeyframes(withDuration: d, delay: 0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: { () -> Void in
            //全体の動きの９割を定義
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 9/10, animations: {
            v.center.y = self.height!
        })
            //残りの１割
            //水平方向に-5 <= x <= 5,垂直方向に0<=y<=-10
            UIView.addKeyframe(withRelativeStartTime: 9/10, relativeDuration: 1/10, animations: {
                let rnd = CGFloat(arc4random_uniform(10))
                let dx = rnd - 5
                let dy = -2*rnd
                v.center.y = v.center.y + dy
                v.center.x = v.center.x + dx
            })
        }, completion:{ (finish) -> Void in v.removeFromSuperview()})
        self.view.addSubview(v)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderDidValueChange(_ sender: UISlider) {
        //1.0 <= duration <= 3.0
        print("\(sender.value)")
        self.duration = 3 - TimeInterval(sender.value) * 2
    }
    


}

