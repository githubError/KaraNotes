//
//  CPFChangeUserInfoController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/20.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFChangeUserInfoController: BaseViewController {
    
    var navAlphaView:UIView!
    
    fileprivate var tableView:UITableView!
    fileprivate let navigationLabel = UILabel()
    fileprivate var saveBtn:UIButton!
    fileprivate let CellID: String = "changeInfoCell"
    
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
        
        setupTableView()
    }
    
    func setupTableView() -> Void {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        tableView.register(CPFChangeUserInfoCell.self, forCellReuseIdentifier: CellID)
        tableView.separatorStyle = .singleLineEtched
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
}


// MARK: - 
extension CPFChangeUserInfoController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID) as! CPFChangeUserInfoCell
        cell.selectionStyle = .none
        
        switch indexPath.row {
        case 0:
            cell.cellType = .userHeaderImgCell
            cell.typeLabel.text = "头像"
        case 1:
            cell.cellType = .userNameCell
            cell.typeLabel.text = "用户名"
        case 2:
            cell.cellType = .userSexCell
            cell.typeLabel.text = "性别"
        case 3:
            cell.cellType = .userNormalCell
            cell.typeLabel.text = "背景图"
        default:
            print("unknow type cell")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("更改头像")
        case 2:
            print("更改姓名")
        case 3:
            print("更改背景图片")
        default:
            print("unknow type cell")
        }
        
        if indexPath.row != 1 {
            let indexPath = IndexPath(row: 1, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! CPFChangeUserInfoCell
            cell.textField.resignFirstResponder()
        }
    }
}
