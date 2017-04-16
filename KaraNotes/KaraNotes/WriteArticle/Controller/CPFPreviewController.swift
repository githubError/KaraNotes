//
//  CPFPreviewController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/16.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFPreviewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = CPFRandomColor
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}
