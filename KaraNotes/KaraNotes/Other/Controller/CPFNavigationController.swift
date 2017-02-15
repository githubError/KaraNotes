//
//  CPFNavigationController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/15.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFNavigationController: UINavigationController {
    
    
    override class func initialize() {
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.barTintColor = CPFRGBA(r: 189, g: 34, b: 35, a: 1.0)
        navigationBar.isTranslucent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
