//
//  AppDelegate.swift
//  NotifyDemo
//
//  Created by 桐山圭祐 on 2017/07/12.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //アプリが起動し、「よし使える」というタイミングで呼ばれる。
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //(プッシュ通知を含む)通知の設定を行う
        //利用する通知の形式を利用するすべての文設定
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

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        let seconds = 10
        let content = UNMutableNotificationContent()
        content.title = "It's time"
        content.subtitle = "\(seconds) seconds elapsed"
        content.body = "I told you now because you had set \(seconds) seconds before"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(seconds), repeats: false)
        let request = UNNotificationRequest(identifier: "TIMER\(seconds)", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) {
            (error) in if let error = error {
                print(error.localizedDescription)
            }
        }
        
    
        
        
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

