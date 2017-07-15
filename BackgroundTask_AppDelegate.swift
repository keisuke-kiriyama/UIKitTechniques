//
//  AppDelegate.swift
//  BackgroundTaskDemo
//
//  Created by 桐山圭祐 on 2017/07/13.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var taskId: UIBackgroundTaskIdentifier?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //通知の許可を得る設定
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {(granted, error) in
            if granted {
                print("Allowed")
            } else {
                print("Didn't allowed")
            }
        })
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    
    //backgroundに入った時に呼ばれる
    //処理の延長を宣言
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        //backgroundTimeRemainderプロパティで、バックグラウンドで実行できる残り時間を取得できる
        print("背面に入りました。残り時間 : \(application.backgroundTimeRemaining)")
        
        if let vc = self.window?.rootViewController as? ViewController {
            //NSTimerが実行中なら、
            if vc.isRunning && taskId == .none{
                //expirationHandlerは時間切れのタイミングで呼び出される
                let taskId = application.beginBackgroundTask(withName: "timer", expirationHandler: {
                    print("残り時間 : \(application.backgroundTimeRemaining)")
                    if let id = self.taskId {
                        self.taskId = nil
                        //バックグラウンド実行の終了を宣言
                        application.endBackgroundTask(id)
                    }
                })
                print("タスク登録 : \(taskId)")
                self.taskId = taskId
            }
        }
        
    }


    //タスク完了前にユーザーが戻ってくることもあるので、その場合にはバックグラウンド実行の申請は終了させる
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        if let id = self.taskId {
            print("foregroundに復帰")
            self.taskId = nil
            application.endBackgroundTask(id)
        }
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

