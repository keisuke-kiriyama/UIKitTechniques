//
//  AppDelegate.swift
//  UrlSchemeDemo
//
//  Created by 桐山圭祐 on 2017/07/13.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    struct USUrlSchemeCmd {
        static let COMMAND_1 = "cmd1"
        static let COMMAND_2 = "cmd2"
        static let COMMAND_3 = "cmd3"
    }
    
    //URLスキームで呼び出されると呼び出されるメソッド
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        //取り回ししやすくするため、URLComponentsに変換
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        //query部分を使って任意のパラメータを渡す
        var queryDictionary: Dictionary<String, String> = [:]
        for item in urlComponents.queryItems! as [NSURLQueryItem] {
            queryDictionary[item.name] = item.value
        }
        
        //host部分を使って処理を振り分ける
        switch urlComponents.host {
        case .some(USUrlSchemeCmd.COMMAND_1):
            print(queryDictionary)
        case .some(USUrlSchemeCmd.COMMAND_2):
            print(queryDictionary)
        case .some(USUrlSchemeCmd.COMMAND_1):
            print(queryDictionary)
        default:
            break
        }
        return true
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
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

