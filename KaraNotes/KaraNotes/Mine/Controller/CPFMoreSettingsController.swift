//
//  CPFMoreSettingsController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/3/4.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFMoreSettingsController: BaseViewController {
    
    var topCategaryView:UIView!
    var tableView:UITableView!
    
    fileprivate let cellID = "tableViewCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
}


// MARK: - setup subviews
extension CPFMoreSettingsController {
    
    func setupSubviews() -> Void {
        setupTopCategaryView()
        setupTableView()
    }
    
    func setupTopCategaryView() -> Void {
        topCategaryView = UIView()
        topCategaryView.backgroundColor = CPFRandomColor
        view.addSubview(topCategaryView)
        topCategaryView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(0)
            make.height.equalTo(45)
        }
    }
    
    func setupTableView() -> Void {
        tableView = UITableView(frame: CGRect(x: 0, y: 45, width: CPFScreenW, height: CPFScreenH), style: .grouped)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .singleLine
    }
}

extension CPFMoreSettingsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID) as UITableViewCell
        
        cell.selectionStyle = .none
        cell.textLabel?.textColor = CPFRGB(r: 155, g: 155, b: 155)
        cell.textLabel?.font = CPFPingFangSC(weight: .medium, size: 18)
        cell.detailTextLabel?.textColor = CPFRGB(r: 175, g: 175, b: 175)
        cell.detailTextLabel?.font = CPFPingFangSC(weight: .regular, size: 10)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "清除缓存"
            cell.detailTextLabel?.text = "当前缓存2.6M"
            cell.accessoryType = .disclosureIndicator
        case 1:
            cell.textLabel?.text = "意见反馈"
            cell.accessoryType = .disclosureIndicator
        case 2:
            cell.textLabel?.text = "请喝饮料"
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 45, height: 44))
            label.textColor = CPFRGB(r: 175, g: 175, b: 175)
            label.font = CPFPingFangSC(weight: .regular, size: 10)
            label.text = "¥6.0"
            label.textAlignment = .right
            cell.accessoryView = label
        default:
            cell.textLabel?.text = "退出登录"
            cell.textLabel?.textColor = CPFRGB(r: 255, g: 1, b: 1)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            print("清除缓存")
        case 1:
            print("意见反馈")
        case 2:
            print("请喝饮料")
        default:
            CPFUserManager.sharedInstance().logout {
                UIApplication.shared.keyWindow?.rootViewController = CPFLoginController()
            }
        }
    }
}
