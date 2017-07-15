//
//  ViewController.swift
//  BackgroundTaskDemo
//
//  Created by 桐山圭祐 on 2017/07/13.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    struct Digit {
        static let HUNDREDS = 0
        static let TENS = 1
        static let ONES = 2
    }
    
    @IBOutlet weak var _picker: UIPickerView!
    
    var d100: Int = 1
    var d10:Int = 8
    var d1 = 0
    
    //上記３つを一つの数字として扱う
    var count: Int {
        get{ return d100 * 100 + d10 * 10 + d1}
        set{
            //countの数字を百の位、十の位、１の位に分解する
            d100 = (newValue - (newValue % 100)) / 100
            d10 = (newValue - d100*100 - (newValue % 10)) / 10
            d1 = newValue - d100*100 - d10*10
        }
    }
    
    var isRunning = false
    var timer: Timer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _picker.delegate = self
        _picker.dataSource = self
        self.updatePickerViewByCount()
        
    }

    @IBAction func btnDidPush(_ sender: UIButton) {
        isRunning = !isRunning
        
        if isRunning{
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.tick), userInfo: nil, repeats: true)
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func updatePickerViewByCount() {
        _picker.selectRow(d100, inComponent: Digit.HUNDREDS, animated: true)
        _picker.selectRow(d10, inComponent: Digit.TENS, animated: true)
        _picker.selectRow(d1, inComponent: Digit.ONES, animated: true)
    }
    
    //Countをディクリメントし、０より大きいうちはPickerViewをアップデート
    func tick() {
        let app = UIApplication.shared
        count -= 1
        if 0 < count {
            self.updatePickerViewByCount()
            app.applicationIconBadgeNumber = count
        } else {
            timer?.invalidate()
            timer = nil
            isRunning = false
            
            if app.applicationState == .background {
                //通知を生成
                let content = UNMutableNotificationContent()
                content.title = "即座に戻る"
                content.body = "お時間になりました"
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                var notification = UNNotificationRequest(identifier: "TIMER", content: content, trigger: trigger)
                
                //バックグラウンド実行が終わったことをendBackgroundTaskメソッドで通知
                if let appDelegate = app.delegate as? AppDelegate {
                    if let id = appDelegate.taskId {
                        print("バックグラウンドタスクを終了")
                        appDelegate.taskId = nil
                        app.endBackgroundTask(id)
                    }
                }
            }
        }
    }
    
    //UIPickerViewDateSouceプロトコルのメソッド
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3    //列数を返す
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10   //Componentに応じた行数を返す
    }
    
    //UIPickerViewDelegateプロゴコルのメソッド
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
        //各ComponentのRowに対応して表示する文字列を返す
    }
    
    //pickerViewで業が選択された時の処理
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component{
        case Digit.HUNDREDS:
            d100 = row
        case Digit.TENS:
            d10 = row
        default:
            d1 = row
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

