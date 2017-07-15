//
//  AppDelegate.swift
//  BackgroundFetchDemo
//
//  Created by 桐山圭祐 on 2017/07/15.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //fetchが最適化した最小感覚で行うように設定
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        return true
    }
    
    //UIApplicationDelegateプロトコルのメソッドを追加で実装
    //fetchのためにシステムに起こされた時に呼ばれる
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //ダウンロードを行い、データの更新があるか否かをcompletionHandlerで返す
        //ここではURLSessionのデフォルトセッションでデータタスクを実行
        let conf = URLSessionConfiguration.default
        
        //タスクのcompletionaHandlerがメインスレッドで実行されるようにmainQueueを指定
        let session = URLSession(configuration: conf, delegate: nil, delegateQueue: OperationQueue.main)
        
        //JSONを返すAPIを指定
        let url = URL(string: "http://0.0.0.0:5000/ping")!
        //let task = session.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
        let task = session.dataTask(with: url) { data, response, error -> Void in
            if error  == nil {
                //JSONを解析し、更新があればNewDataをなければNoDataを返す
                if let json = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, AnyObject> {
                    print(json)
                    if (json["status"]?.boolValue!)! {
                        //実際にはここで、更新データを使った更新処理を行う
                        completionHandler(.newData)
                    } else {
                        completionHandler(.noData)
                    }
                }
            } else {
                print("error : \(String(describing: error))")
                completionHandler(.failed)
            }
        }
        task.resume()
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

