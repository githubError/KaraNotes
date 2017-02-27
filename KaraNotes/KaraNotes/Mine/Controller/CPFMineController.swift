//
//  CPFMineController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/15.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFMineController: BaseViewController {
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.navigationBar.isHidden = !(self.navigationController?.navigationBar.isHidden)!
    }
}
