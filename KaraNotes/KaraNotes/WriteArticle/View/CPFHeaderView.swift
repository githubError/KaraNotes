//
//  CPFHeaderView.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/16.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

protocol CPFHeaderViewDelegate {
    func headerView(headerView: UIView, didClickDismissBtn dismissBtn: UIButton)
}

class CPFHeaderView: UIView {
    
    fileprivate var titleLabel:UILabel!
    fileprivate var dismissBtn:UIButton!
    
    var delegate:CPFHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}


extension CPFHeaderView {
    
    func setupSubviews(frame: CGRect) -> Void {
        backgroundColor = CPFRGBA(r: 189, g: 34, b: 35, a: 1.0)
        
        dismissBtn = UIButton(type: .custom)
        dismissBtn.setImage(UIImage.init(named: "dismissBtn"), for: .normal)
        dismissBtn.addTarget(self, action: #selector(dismissBtnClick), for: .touchUpInside)
        addSubview(dismissBtn)
        dismissBtn.snp.makeConstraints { (mark) in
            mark.width.height.equalTo(30)
            mark.centerY.equalTo(self.snp.centerY).offset(10)
            mark.left.equalTo(15)
        }
        
        titleLabel = UILabel()
        addSubview(titleLabel)
        titleLabel.text = CPFLocalizableTitle("writeArticle_title")
        titleLabel.font = CPFPingFangSC(weight: .semibold, size: 18)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(dismissBtn.snp.centerY)
            make.width.equalTo(60)
            make.height.equalTo(35)
            make.centerX.equalToSuperview()
        }
    }
}

extension CPFHeaderView {
    func dismissBtnClick() -> Void {
        delegate?.headerView(headerView: self, didClickDismissBtn: dismissBtn)
    }
}
