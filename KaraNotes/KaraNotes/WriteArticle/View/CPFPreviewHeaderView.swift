//
//  CPFHeaderView.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/16.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

protocol CPFPreviewHeaderViewDelegate {
    func headerView(headerView: UIView, didClickDismissBtn dismissBtn: UIButton)
    func headerView(headerView: UIView, didClickExportBtn dismissBtn: UIButton)
}

class CPFPreviewHeaderView: UIView {
    
    fileprivate var titleLabel:UILabel!
    fileprivate var dismissBtn:UIButton!
    fileprivate var exportBtn:UIButton!
    
    var delegate:CPFPreviewHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}


extension CPFPreviewHeaderView {
    
    fileprivate func setupSubviews(frame: CGRect) -> Void {
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
        titleLabel.text = CPFLocalizableTitle("previewArticle_title")
        titleLabel.font = CPFPingFangSC(weight: .semibold, size: 18)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(dismissBtn.snp.centerY)
            make.width.equalTo(60)
            make.height.equalTo(35)
            make.centerX.equalToSuperview()
        }
        
        exportBtn = UIButton(type: .custom)
        addSubview(exportBtn)
        exportBtn.titleLabel?.font = CPFPingFangSC(weight: .regular, size: 14)
        exportBtn.setTitle(CPFLocalizableTitle("previewArticle_export"), for: .normal)
        exportBtn.setTitleColor(UIColor.white, for: .normal)
        exportBtn.addTarget(self, action: #selector(exportBtnClick), for: .touchUpInside)
        exportBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(dismissBtn.snp.centerY)
            make.width.equalTo(40)
            make.height.equalTo(25)
            make.right.equalToSuperview().offset(-10)
        }
    }
}

extension CPFPreviewHeaderView {
    @objc fileprivate func dismissBtnClick() -> Void {
        delegate?.headerView(headerView: self, didClickDismissBtn: dismissBtn)
    }
    
    @objc fileprivate func exportBtnClick() -> Void {
        delegate?.headerView(headerView: self, didClickExportBtn: exportBtn)
    }
}
