//
//  CPFChangeUserInfoController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/20.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFChangeUserInfoController: BaseViewController {
    
    var tableView:UITableView!
    
    var navAlphaView:UIView!
    
    let navigationLabel = UILabel()
    var saveBtn:UIButton!
    
    override func viewDidLoad() {
        configInfo()
        setupSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navAlphaView.alpha = 1.0
        navigationLabel.isHidden = false
        saveBtn.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationLabel.isHidden = true
        saveBtn.isHidden = true
    }
}


// MARK: - Custom Methods
extension CPFChangeUserInfoController {
    
    func configInfo() -> Void {
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        
        navigationLabel.size = CGSize(width: 150, height: 35)
        navigationLabel.centerX = view.middleX
        navigationLabel.centerY = 22
        navigationLabel.textAlignment = .center
        navigationLabel.font = CPFPingFangSC(weight: .semibold, size: 18)
        navigationLabel.textColor = UIColor.white
        navigationController?.navigationBar.addSubview(navigationLabel)
        navigationLabel.text = CPFLocalizableTitle("mine_changeInfo_navTitle")
        
        saveBtn = UIButton(type: .custom)
        saveBtn.size = CGSize(width: 40, height: 30)
        saveBtn.centerX = CPFScreenW - saveBtn.size.width
        saveBtn.centerY = 25
        saveBtn.setTitle(CPFLocalizableTitle("mine_changeInfo_saveBtn"), for: .normal)
        saveBtn.addTarget(self, action: #selector(saveBtnClick), for: .touchUpInside)
        navigationController?.navigationBar.addSubview(saveBtn)
    }
    
    func saveBtnClick() -> Void {
        print("-------------saveBtnClick")
    }
}


// MARK: - Setup Subviews
extension CPFChangeUserInfoController {
    
    func setupSubviews() -> Void {
        view.backgroundColor = CPFRandomColor
        
    }
}
