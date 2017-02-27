//
//  AppDelegate.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/14.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if CPFUserManager.sharedInstance().isLogin() {
            print("已登录")
            let tabBarViewController = CPFTabBarController()
            
            window!.rootViewController = tabBarViewController
        } else {
            
            let loginController = CPFLoginController()
            
            window!.rootViewController = loginController
        }
        
        window!.makeKeyAndVisible()
        
        
        if CPFUserManager.sharedInstance().logout() {
            print("退出登录")
        }
 
        /*
        CPFUserManager.sharedInstance().login(withAccount: "cpf9401@163.com", password: "12345678") { result in
            
            if result == 1 {
                print("登录成功")
            } else {
                print("登录失败")
            }
        }*/
        
        CPFUserManager.sharedInstance().checkEmail(withAccount: "cpf9401@164.com") { (result) in
            print(result)
        }
        
        CPFUserManager.sharedInstance().register(withAccount: "黄鹏傻逼", password: "嗯嗯，是的") { (result, userName) in
            if result == 1 {
                print("\(userName)，注册成功")
            } else {
                if userName == "3" {
                    print("账户已存在")
                } else {
                    print("其他位置错误")
                }
            }
        }
        
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

