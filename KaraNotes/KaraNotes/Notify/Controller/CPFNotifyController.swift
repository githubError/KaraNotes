//
//  CPFNotifyController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/15.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFNotifyController: BaseViewController {
    
    var tableView:UITableView!
    
    fileprivate let CellID: String = "NotifyCell"
    fileprivate let cellImages:[String] = ["notify_comment", "notify_like", "notify_collection", "notify_attention"]
    fileprivate let cellTitles:[String] = ["notify_comment", "notify_like", "notify_collection", "notify_attention"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
}


extension CPFNotifyController {
    
    func setupSubviews() -> Void {
        setupTableView()
    }
    
    func setupTableView() -> Void {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellID)
        tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
}

extension CPFNotifyController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID)
        
        cell?.selectionStyle = .none
        cell?.textLabel?.textColor = CPFRGB(r: 155, g: 155, b: 155)
        cell?.textLabel?.font = CPFPingFangSC(weight: .medium, size: 16)
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = CPFLocalizableTitle(cellTitles[indexPath.row])
        
        let imageIcon = UIImage.init(named: cellImages[indexPath.row])
        let imageSize = CGSize(width: 20, height: 20)
        UIGraphicsBeginImageContext(imageSize)
        let imageRect = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        imageIcon?.draw(in: imageRect)
        cell?.imageView?.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            print("点击\(indexPath.row)")
        case 0:
            print("点击\(indexPath.row)")
        case 0:
            print("点击\(indexPath.row)")
        case 0:
            print("点击\(indexPath.row)")
        default:
            print("点击\(indexPath.row)")
        }
    }
}
