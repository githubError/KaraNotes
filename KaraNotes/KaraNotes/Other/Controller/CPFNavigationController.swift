//
//  CPFNavigationController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/15.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    let backButton = UIButton(type: .custom)
    
    override class func initialize() {
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.barTintColor = CPFRGBA(r: 189, g: 34, b: 35, a: 1.0)
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName : UIFont.init(name: "PingFangSC-Semibold", size: 18)!]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension CPFNavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            backButton.setImage(UIImage.init(named: "back"), for: .normal)
            backButton.size = CGSize(width: 20, height: 25)
            backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
            
            backButton.contentHorizontalAlignment = .left
            backButton.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: -10, bottom: 0, right: 0)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    func back() -> Void {
        popViewController(animated: true)
    }
}
