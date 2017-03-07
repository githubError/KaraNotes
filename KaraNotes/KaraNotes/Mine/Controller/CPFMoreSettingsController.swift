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
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topCategaryView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: -20, left: -30, bottom: 720, right: 0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .singleLine
    }
}

extension CPFMoreSettingsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID) as UITableViewCell
        
        cell.selectionStyle = .none
        cell.textLabel?.textColor = CPFRGB(r: 120, g: 120, b: 30)
        cell.textLabel?.font = CPFPingFangSC(weight: .semibold, size: 18)
        cell.detailTextLabel?.textColor = CPFRGB(r: 30, g: 20, b: 130)
        cell.detailTextLabel?.font = CPFPingFangSC(weight: .thin, size: 10)
        cell.textLabel?.text = "第\(indexPath.row)行"
        
        if indexPath.row%2 == 0 {
            cell.detailTextLabel?.text = "hhhhh"
        }
        
        return cell
    }
}
