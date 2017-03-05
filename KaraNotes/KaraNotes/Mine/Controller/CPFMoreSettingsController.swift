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
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topCategaryView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
}

extension CPFMoreSettingsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //#warning
    //FIXME:bug
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)!
        
        cell.textLabel!.text = "第\(indexPath.row)行"
        
        return cell
    }
}
