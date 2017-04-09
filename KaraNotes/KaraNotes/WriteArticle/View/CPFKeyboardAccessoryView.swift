//
//  CPFKeyboardAccessoryView.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/9.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

protocol CPFKeyboardAccessoryViewDelegate {
    func accessoryView(accessoryView:CPFKeyboardAccessoryView, didClickAccessoryItem item:UIButton) -> Void
    func accessoryView(accessoryView:CPFKeyboardAccessoryView, shouldSendString string:String) -> Void
}

class CPFKeyboardAccessoryView: UIScrollView {
    
    var maxCount:Int = 8
    
    fileprivate let titles = ["Tab","add_image","add_link","¶","#","*","-",">","`","!","[","]","(",")","\\","keyboard_down"]
    
    var accessoryViewDelegate:CPFKeyboardAccessoryViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: CPFScreenW, height: CPFScreenW/8.0))
        
        configure()
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
        setupSubviews()
    }
    
}


// MARK: - setup sbuviews
extension CPFKeyboardAccessoryView {
    
    func configure() -> Void {
        backgroundColor = CPFRGB(r: 200, g: 200, b: 210)
        delegate = self
        isPagingEnabled = true
        bounces = false
        contentSize = CGSize(width: self.width, height: self.width / 4)
    }
    
    func setupSubviews() -> Void {
        let itemW = CPFScreenW / CGFloat(maxCount)
        let margin:CGFloat = 4.0
        
        for (index, value) in titles.enumerated() {
            let button = UIButton(type: .custom)
            button.tag = index
            button.tintColor = UIColor.blue
            button.backgroundColor = UIColor.white
            button.frame = CGRect(x: CGFloat(index % maxCount) * itemW + margin, y: CGFloat(index / maxCount) * itemW + margin, width: itemW - 2 * margin, height: itemW - 2 * margin)
            if index == 0 {
                button.setTitle(value, for: .normal)
                button.setTitleColor(UIColor.black, for: .normal)
                button.titleLabel?.font = CPFPingFangSC(weight: .medium, size: 13)
            } else if index > 0 && index < 3 {
                button.setImage(UIImage.init(named: value), for: .normal)
                button.imageEdgeInsets = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
            } else if index >= 3 && index < titles.count - 1 {
                button.setTitle(value, for: .normal)
                button.setTitleColor(UIColor.black, for: .normal)
            } else {
                button.setImage(UIImage.init(named: value), for: .normal)
                button.imageEdgeInsets = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
            }
            button.addTarget(self, action: #selector(accessoryItemClick(button:)), for: .touchUpInside)
            button.makeRound(round: 6.0)
            addSubview(button)
        }
    }
}

// MARK:- custom methods
extension CPFKeyboardAccessoryView {
    func accessoryItemClick(button:UIButton) -> Void {
        
        switch button.tag {
        case 0:
            accessoryViewDelegate?.accessoryView(accessoryView: self, shouldSendString: "\t")
        case 3:
            accessoryViewDelegate?.accessoryView(accessoryView: self, shouldSendString: "&nbsp;")
        case 1,2,15:
            accessoryViewDelegate?.accessoryView(accessoryView: self, didClickAccessoryItem: button)
        default:
            accessoryViewDelegate?.accessoryView(accessoryView: self, shouldSendString: button.currentTitle!)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension CPFKeyboardAccessoryView: UIScrollViewDelegate {
    
}
