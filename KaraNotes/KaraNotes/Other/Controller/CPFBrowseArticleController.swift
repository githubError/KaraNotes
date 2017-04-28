//
//  CPFBrowseArticleController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/28.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFBrowseArticleController: BaseViewController {

    var isMyArticle:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.purple
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}
