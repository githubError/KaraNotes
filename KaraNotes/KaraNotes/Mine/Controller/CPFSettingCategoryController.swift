//
//  CPFSettingCategoryController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/8.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

enum CPFSettingCategoryType: Int {
    case attention = 0, fans, tags
}

class CPFSettingCategoryController: BaseViewController {

    var settingCategoryType:CPFSettingCategoryType!
    
    let navigationLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationLabel.text = ""
    }
}


// MARK: - setup
extension CPFSettingCategoryController {
    
    func setupNavigationBar() {
        
        navigationLabel.size = CGSize(width: 50, height: 35)
        navigationLabel.centerX = view.middleX
        navigationLabel.centerY = 22
        navigationLabel.font = CPFPingFangSC(weight: .semibold, size: 18)
        navigationLabel.textColor = UIColor.white
        navigationController?.navigationBar.addSubview(navigationLabel)
        
        switch settingCategoryType.rawValue {
        case 0:
            print("关注")
            navigationLabel.text = CPFLocalizableTitle("mine_more_attentionBtn")
        case 1:
            print("粉丝")
            navigationLabel.text = CPFLocalizableTitle("mine_more_fansBtn")
        default:
            print("标签")
            navigationLabel.text = CPFLocalizableTitle("mine_more_tagsBtn")
        }
    }
}
