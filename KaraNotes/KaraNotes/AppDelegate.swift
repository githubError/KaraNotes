//
//  AppDelegate.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/14.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit
import Social

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if CPFUserManager.sharedInstance().isLogin() {
            let tabBarViewController = CPFTabBarController()
            window!.rootViewController = tabBarViewController
        } else {
            let loginController = CPFLoginController()
            window!.rootViewController = loginController
        }
        window!.makeKeyAndVisible()
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        if CPFUserManager.sharedInstance().isLogin() {
            let tabBarViewController = window!.rootViewController as! CPFTabBarController
            switch shortcutItem.type {
            case "add":
                let writeArticleController = CPFWriteArticleController()
                tabBarViewController.present(writeArticleController, animated: true, completion: nil)
            case "search":
                let searchController = CPFSearchController()
                let navController = tabBarViewController.childViewControllers[0] as! CPFNavigationController
                navController.pushViewController(searchController, animated: true)
            case "share":
                let activityCtr = UIActivityViewController(activityItems: [CPFLocalizableTitle("shortcut_share_content")], applicationActivities: nil)
                let excludedActivities: [UIActivityType] = [UIActivityType.postToTwitter,
                                                            UIActivityType.postToFacebook,
                                                            UIActivityType.postToWeibo,
                                                            UIActivityType.assignToContact,
                                                            UIActivityType.saveToCameraRoll,
                                                            UIActivityType.addToReadingList,
                                                            UIActivityType.postToFlickr]
                activityCtr.excludedActivityTypes = excludedActivities
                
                tabBarViewController.present(activityCtr, animated: true, completion: nil)
                
            default:
                print("3D Touch -------未知")
            }
        }
    }
}

