//
//  ViewController.swift
//  CustomViewDemo
//
//  Created by 桐山圭祐 on 2017/07/10.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct PdfInfo {
        static let NAME = "supdf"
        static let EXTENSION = "pdf"
        static var DOCUMENTS_PATH: String? = nil
    }
    
    var documentsPath: String {
        if let dir = PdfInfo.DOCUMENTS_PATH {
            return dir
        } else {
            let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/"
            PdfInfo.DOCUMENTS_PATH = dir
            return dir
        }
    }
    
    var usview: USView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let diameter = self.view.bounds.width / 2
        let usview = USView(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        self.view.addSubview(usview)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapHandler(sender:)))
        usview.addGestureRecognizer(tapRecognizer)
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapHandler(sender:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        usview.addGestureRecognizer(doubleTapRecognizer)

        //ダブルタップの検出がfailedになるまで、たっぷの検出待ち合わせ
        tapRecognizer.require(toFail: doubleTapRecognizer)
        
        self.usview = usview
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pdfPath() -> String {
        return documentsPath + PdfInfo.NAME + "." + PdfInfo.EXTENSION
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case .some("toWebView"):
            (segue.destination as! USViewController).pdfPath = pdfPath()
            print("toWebViewで遷移します...")
        default:
            break
        }
    }
    
    func tapHandler(sender: UITapGestureRecognizer) {
        print("タップされました")
        
        let filePath = pdfPath()
        print("filepath: \(filePath)")
        let bounds = self.view.bounds
        
        //PDFのグラフィクスコンテキストを開く
        if(UIGraphicsBeginPDFContextToFile(filePath, bounds, nil)) {
            print("PDFコンテキスト開始")
            UIGraphicsBeginPDFPage()    //新規ページ
            //描画を行う
            usview?.draw(CGRect(x: 20, y: 20, width: bounds.width-40, height: bounds.height-140))
            //PDFコンテキストを閉じる
            UIGraphicsEndPDFContext()
            
            //画面遷移
            self.performSegue(withIdentifier: "toWebView", sender: self)
        } else {
            print("PDFコンテキストの開始に失敗しました。")
        }
    }
    
    func doubleTapHandler(sender: UITapGestureRecognizer) {
        print("ダブルタップされました")
        
        if let v = self.usview {
            //UIImageのコンテキストを現在のコンテキストにする
            UIGraphicsBeginImageContextWithOptions(v.frame.size, true, 0)
            
            //描画を行う
            v.draw(v.frame)
            
            //UIImage化
            var image = UIGraphicsGetImageFromCurrentImageContext()
            
            //コンテキストの破棄
            UIGraphicsEndImageContext()
            
            //不変の位置を指定して、可変長のUIImageにする
            let sideInset = self.view.bounds.width/4 - 8
            let myInsets : UIEdgeInsets = UIEdgeInsetsMake(0, sideInset, 0, sideInset)
            image = image?.resizableImage(withCapInsets: myInsets)
            
            //UIButtonを生成
            let btn = UIButton()
            btn.titleEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20)
            btn.setTitle("画面幅一杯のボタン", for: .normal)
            btn.setTitleColor(UIColor.blue, for: .normal)
            btn.setBackgroundImage(image, for: .normal)
            
            self.view.addSubview(btn)
            
            btn.translatesAutoresizingMaskIntoConstraints = false
            
            //縦方向のconstraint
            self.view.addConstraint(NSLayoutConstraint(item: btn, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
            //横方向のconstraint
            self.view.addConstraint(NSLayoutConstraint(item: btn, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
            //横幅いっぱいにする
            self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[btn]|", options: .directionLeadingToTrailing, metrics: nil, views: ["btn":btn]))
        }
    }
}



class USView: UIView {
    let peaks = 30  //ギザギザの山の数
    let gap: CGFloat = 0.85 //山と谷の差
    let lineWidth: CGFloat = 2  //線の幅
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //デフォルトでは背景が黒く塗りつぶされるため透明にする
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //生成時に呼ばれてViewを描画する
    override func draw(_ rect: CGRect) {
        let x = rect.size.width / 2 //中心のx座標
        let y = rect.size.height / 2    //中心のy座標
        let r = (x < y ? x : y) - 2 //外側の円の半径
        let adjusment = 360/peaks/2 //山と谷のズレの角度
        
        //谷の部分の位置を計算して配列にする
        let innerPoints = polygonPoints(peaks: peaks, x: rect.origin.x + x, y: rect.origin.y + y, radius: r*gap)
        let outerPoints = polygonPoints(peaks: peaks, x: rect.origin.x + x, y: rect.origin.y + y, radius: r, adjustment: CGFloat(adjusment))
        
        let bez = UIBezierPath()
        
        //起点へ移動
        bez.move(to: CGPoint(x: innerPoints[0].x, y: innerPoints[0].y))
        //パスでぎざぎざんバッジを作成
        for i in (0..<innerPoints.count) {
            //外向きの線の追加
            bez.addLine(to: CGPoint(x: outerPoints[i].x, y: outerPoints[i].y))
            //内向きの線の追加
            bez.addLine(to: CGPoint(x: innerPoints[i].x, y: innerPoints[i].y))
        }
        
        //線の描画
        UIColor.yellow.setStroke()
        bez.lineWidth = lineWidth
        bez.stroke()
        
        //塗りつぶし
        UIColor.yellow.setFill()
        bez.fill()
        
    }
    
    func degree2radian(a: CGFloat) -> CGFloat {
        let b = CGFloat(Float.pi) * a/180
        return b
    }
    
    
    //多角形の頂点の位置を三角関数を使って計算し、配列で返す。
    func polygonPoints(peaks: Int, x: CGFloat, y: CGFloat, radius: CGFloat, adjustment: CGFloat=0) -> [CGPoint] {
        let angle = degree2radian(a: CGFloat(360/peaks))
        var points: [CGPoint] = []
        for i in (0...peaks).reversed(){
            let px = x - radius * cos(angle * CGFloat(i) + degree2radian(a: adjustment))
            let py = y - radius * sin(angle * CGFloat(i) + degree2radian(a: adjustment))
            points.append(CGPoint(x: px, y: py))
        }
        return points
    }
}


//縁がグレイで中が白抜き角丸のview
class KKView: UIView {
    let lineWidth: CGFloat = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //デフォルトでは背景が黒く塗りつぶされるため透明にする
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        let bez = UIBezierPath(roundedRect: rect, cornerRadius: 30.0)
        UIColor.gray.setStroke()
        UIColor.white.setFill()
        bez.fill()
        bez.lineWidth = self.lineWidth
        bez.stroke()
        
    }
    
}
















