//
//  ViewController.swift
//  DynamicsDemo
//
//  Created by 桐山圭祐 on 2017/07/11.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    @IBOutlet weak var ochiruLabel: UILabel!
    @IBOutlet weak var jyamalabel: UILabel!
    @IBOutlet weak var kuttsukiLabel: UILabel!
    //メンバ変数にし、メモリ上に残るようにする
    var animator: UIDynamicAnimator? = nil
    var attachmentBehavior:UIAttachmentBehavior? = nil
    var snapBehavior: UISnapBehavior? = nil
    var pushBehavior: UIPushBehavior? = nil
    var itemBehavior: UIDynamicItemBehavior? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //引数にルートviewを指定
        let animator = UIDynamicAnimator(referenceView: self.view)
        
        //重力をエミュレートするBehaviorをUIlabelに対して生成
        let gravity = UIGravityBehavior(items: [ochiruLabel])
        //gravity.setAngle(10.0, magnitude: 0.1)
        animator.addBehavior(gravity)
        
        //衝突の振る舞いを追加
        let collision = UICollisionBehavior(items: [ochiruLabel, jyamalabel])
        
        //referenceViewの教会でぶつかるように設定
        collision.translatesReferenceBoundsIntoBoundary = true
        
        //衝突の振る舞い時の処理をViewControllerにdelegate
        collision.collisionDelegate = self
        
        //コード上でUIViewを追加
//        let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 150, height: 20))
//        barrier.backgroundColor = UIColor.blue
//        self.view.addSubview(barrier)
//        
//        //追加したUIViewのframeプロパティで、そのまま衝突の境界を作成
//        collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrier.frame))
        
        animator.addBehavior(collision)
        
        //落ちるラベルと接続する点を座標で指定
        //ここでは落ちるラベルの上、100px
        let anchor = CGPoint(x: ochiruLabel.center.x, y: ochiruLabel.center.y - 100.0)
        
        //アンカーポイントと落ちるラベルを接続
        let attachment = UIAttachmentBehavior(item: ochiruLabel, attachedToAnchor: anchor)
        
        //弾性力を指定
        attachment.frequency = 0.8
        attachment.damping = 0.1
        
        animator.addBehavior(attachment)
        
        //邪魔なラベルに力の振る舞いを追加
        //let push = UIPushBehavior(items: [jyamalabel], mode: .continuous)
        let push = UIPushBehavior(items: [jyamalabel], mode: .instantaneous)
        //向き　(ここでは２次元なので角度)始めは０
        push.angle = 0.0
        
        //大きさを指定
        push.magnitude=0.0
        animator.addBehavior(push)
        
        //UIDynamicItemBehaviorで、「邪魔なラベル」の回転の可否
        //をallowsRotationプロパティで設定
        
        let itemBehavior = UIDynamicItemBehavior(items: [jyamalabel])
        itemBehavior.allowsRotation = false
        animator.addBehavior(itemBehavior)
        
        self.attachmentBehavior = attachment
        self.pushBehavior = push
        self.animator = animator
        self.itemBehavior = itemBehavior
        kuttsukiLabel.center = attachment.anchorPoint
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        (item as! UILabel).textColor = UIColor.red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapHandler(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: self.view)
        if let behavior = self.attachmentBehavior{
            behavior.anchorPoint = point
        }
        
        //前回登録したUISnapBehaviorがある場合には削除(snapBehaviorは削除する必要)
        if let behavior = self.snapBehavior{
            self.animator?.removeBehavior(behavior)
        }
        
        //新たにUISnapBehaviorを「点」ラベルにし、タップいちにスナップするように作成し登録
        let snap = UISnapBehavior(item: kuttsukiLabel, snapTo: point)
        self.animator?.addBehavior(snap)
        self.snapBehavior = snap
        
        //邪魔ラベルの中心を取得
        let o = jyamalabel.center
        
        //3兵法の定理で、タップ位置と邪魔ラベルまでの距離を算出
        var distance = sqrt(pow(point.x-o.x, 2.0) + pow(point.y - o.y, 2.0))
        //逆三角関数を使って、タップ位置と「邪魔ラベル」を結んだ直線とx軸との角度を算出
        let angle = atan2(point.y-o.y, point.x-o.x)
        
        //計算した距離が200をこd流ならば、上限を200
        distance = min(distance, 200.0)
        self.pushBehavior?.magnitude = distance / 100.0
        self.pushBehavior?.angle = angle
        self.pushBehavior?.active = true
    }

}

