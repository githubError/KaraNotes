//
//  CPFTabBarController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/15.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildViewControllers()
        
        setupShortCutItem()
    }
}


extension CPFTabBarController {
    
    func setupChildViewControllers() -> Void {
        
        let childControllers: [String : UIViewController] = [
            "attention" : CPFAttentionController(),
            "myarticle" : CPFMyArticleController(),
            "notify" : CPFNotifyController(),
            "mine" : CPFMineController()]
        let keys: [String] = ["attention", "myarticle", "writearticle", "notify", "mine"]
        
        for key in keys {
            
            if key == "writearticle" {
                setValue(CPFTabBar(), forKeyPath: "tabBar")
                continue
            }
            
            setupChildViewController(viewController: childControllers[key]!, title: CPFLocalizableTitle("tabbar_\(key)"), image: "tabbar_\(key)", selectedImage: "tabbar_\(key)_selected")
        }
    }
    
    func setupChildViewController(viewController : UIViewController, title : String, image : String, selectedImage : String) -> Void {
        
        tabBar.tintColor = CPFTabTintColor
        
        viewController.navigationItem.title = title
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage.init(named: image)?.scaleToSize(newSize: CGSize(width: 30, height: 30))
        
        viewController.tabBarItem.selectedImage = UIImage.init(named: selectedImage)?.scaleToSize(newSize: CGSize(width: 30, height: 30))
        
        let navCtr = CPFNavigationController(rootViewController: viewController)
        
        addChildViewController(navCtr)
    }
    
    func setupShortCutItem() -> Void {
        
        let addItemIcon = UIApplicationShortcutIcon(type: .add)
        let addItem = UIApplicationShortcutItem(type: "add", localizedTitle: CPFLocalizableTitle("shortcut_writeArticle"), localizedSubtitle: "", icon: addItemIcon, userInfo: nil)
        
        let searchItemIcon = UIApplicationShortcutIcon(type: .search)
        let searchItem = UIApplicationShortcutItem(type: "search", localizedTitle: CPFLocalizableTitle("shortcut_search"), localizedSubtitle: CPFLocalizableTitle("shortcut_search_subtitle"), icon: searchItemIcon, userInfo: nil)
        
        let shareItemIcon = UIApplicationShortcutIcon(type: .share)
        let shareItem = UIApplicationShortcutItem(type: "share", localizedTitle: CPFLocalizableTitle("shortcut_share"), localizedSubtitle: "", icon: shareItemIcon, userInfo: nil)
        
        UIApplication.shared.shortcutItems = [addItem, searchItem, shareItem]
    }
}
