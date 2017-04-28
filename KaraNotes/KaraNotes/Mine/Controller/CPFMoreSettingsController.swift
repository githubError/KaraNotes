//
//  CPFMoreSettingsController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/3/4.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

protocol CPFTopCategoryBtnClickDelegate {
    func currentController(controller:UIViewController, didClickCategoryBtn button:UIButton)
}

class CPFMoreSettingsController: BaseViewController {
    
    var topCategaryView:UIView!
    var tableView:UITableView!
    
    var attentionBtn:UIButton!
    var fansBtn:UIButton!
    var tagsBtn:UIButton!
    
    var delegate:CPFTopCategoryBtnClickDelegate?
    
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
        topCategaryView.backgroundColor = UIColor.white
        view.addSubview(topCategaryView)
        topCategaryView.x = 0.0
        topCategaryView.top = view.top
        topCategaryView.width = CPFScreenW
        topCategaryView.height = 65.0
        setupTopCategoryBtns()
    }
    
    func setupTopCategoryBtns() -> Void {
        
        let btnW:CGFloat = 100
        let btnH:CGFloat = 35
        let margin:CGFloat = 15
        
        fansBtn = UIButton()
        topCategaryView.addSubview(fansBtn)
        attentionBtn = UIButton()
        topCategaryView.addSubview(attentionBtn)
        tagsBtn = UIButton()
        topCategaryView.addSubview(tagsBtn)
        
        topCategaryView.subviews.forEach { view in
            let btn = view as! UIButton
            btn.width = btnW
            btn.height = btnH
            btn.centerY = topCategaryView.centerY - 8.0
            btn.setTitleColor(CPFRGB(r: 155, g: 155, b: 155), for: .normal)
            btn.titleLabel?.font = CPFPingFangSC(weight: .regular, size: 12)
            btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
            btn.addTarget(self, action: #selector(topCategoryBtnsClick(button:)), for: .touchUpInside)
            
        }
        
        attentionBtn.setImage(UIImage.init(named: "setting_attentionBtn"), for: .normal)
        attentionBtn.setTitle(CPFLocalizableTitle("mine_more_attentionBtn"), for: .normal)
        attentionBtn.tag = 0
        attentionBtn.left = topCategaryView.left + margin
        
        fansBtn.setImage(UIImage.init(named: "setting_fansBtn"), for: .normal)
        fansBtn.setTitle(CPFLocalizableTitle("mine_more_fansBtn"), for: .normal)
        fansBtn.tag = 1
        fansBtn.centerX = topCategaryView.centerX
        
        tagsBtn.setImage(UIImage.init(named: "setting_tagsBtn"), for: .normal)
        tagsBtn.setTitle(CPFLocalizableTitle("mine_more_tagsBtn"), for: .normal)
        tagsBtn.tag = 2
        tagsBtn.right = topCategaryView.right - margin
        
        attentionBtn.verticalImageAndTitleWithSpacing(spacing: -3.0)
        fansBtn.verticalImageAndTitleWithSpacing(spacing: -3.0)
        tagsBtn.verticalImageAndTitleWithSpacing(spacing: -3.0)
    }
    
    func topCategoryBtnsClick(button:UIButton) -> Void {
        delegate?.currentController(controller: self, didClickCategoryBtn: button)
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
        cell.textLabel?.font = CPFPingFangSC(weight: .medium, size: 16)
        cell.detailTextLabel?.textColor = CPFRGB(r: 175, g: 175, b: 175)
        cell.detailTextLabel?.font = CPFPingFangSC(weight: .regular, size: 10)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = CPFLocalizableTitle("mine_more_clearCaches")
            cell.detailTextLabel?.text = CPFLocalizableTitle("mine_more_currentCaches") + "2.6M"
            cell.accessoryType = .disclosureIndicator
        case 1:
            cell.textLabel?.text = CPFLocalizableTitle("mine_more_feedback")
            cell.accessoryType = .disclosureIndicator
        case 2:
            cell.textLabel?.text = CPFLocalizableTitle("mine_more_support_us")
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 45, height: 44))
            label.textColor = CPFRGB(r: 175, g: 175, b: 175)
            label.font = CPFPingFangSC(weight: .regular, size: 10)
            label.text = "¥6.0"
            label.textAlignment = .right
            cell.accessoryView = label
        default:
            cell.textLabel?.text = CPFLocalizableTitle("mine_more_logout")
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
