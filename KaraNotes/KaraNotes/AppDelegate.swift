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
        
        if !CPFUserManager.sharedInstance().isLogin() {
            let tabBarViewController = CPFTabBarController()
            window!.rootViewController = tabBarViewController
        } else {
            let loginController = CPFLoginController()
            window!.rootViewController = loginController
        }
        window!.makeKeyAndVisible()
        return true
    }
}

