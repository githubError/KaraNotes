//
//  CPFWriteArticleHeaderView.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/8.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

protocol CPFWriteArticleHeaderViewDelegate {
    
    func headerView(headerView: UIView, didClickDismissBtn dismissBtn: UIButton)
    func headerView(headerView: UIView, didClickPreviewBtn previewBtn: UIButton)
    func headerView(headerView: UIView, didClickPostArticleBtn postArticleBtn: UIButton)
}

class CPFWriteArticleHeaderView: UIView {
    
    fileprivate var dismissBtn:UIButton!
    fileprivate var characterCountLabel:UILabel!
    fileprivate var titleLabel:UILabel!
    fileprivate var previewBtn:UIButton!
    fileprivate var postArticleBtn:UIButton!
    
    var delegate:CPFWriteArticleHeaderViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


// MARK: - setup subviews
extension CPFWriteArticleHeaderView {
    
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
        
        characterCountLabel = UILabel()
        characterCountLabel.textColor = CPFRGB(r: 222, g: 222, b: 222)
        characterCountLabel.font = CPFPingFangSC(weight: .regular, size: 10)
        characterCountLabel.text = "0 字"
        addSubview(characterCountLabel)
        characterCountLabel.snp.makeConstraints { (make) in
            make.width.equalTo(30)
            make.height.equalTo(20)
            make.left.equalTo(dismissBtn.snp.right).offset(10)
            make.bottom.equalTo(dismissBtn.snp.bottom)
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
        
        postArticleBtn = UIButton(type: .custom)
        addSubview(postArticleBtn)
        postArticleBtn.titleLabel?.font = CPFPingFangSC(weight: .regular, size: 14)
        postArticleBtn.setTitle(CPFLocalizableTitle("writeArticle_post"), for: .normal)
        postArticleBtn.setTitleColor(UIColor.white, for: .normal)
        postArticleBtn.addTarget(self, action: #selector(postArticleBtnClick), for: .touchUpInside)
        postArticleBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(dismissBtn.snp.centerY)
            make.width.equalTo(40)
            make.height.equalTo(25)
            make.right.equalToSuperview().offset(-10)
        }
        
        previewBtn = UIButton(type: .custom)
        addSubview(previewBtn)
        previewBtn.titleLabel?.font = CPFPingFangSC(weight: .regular, size: 14)
        previewBtn.setTitle(CPFLocalizableTitle("writeArticle_preview"), for: .normal)
        previewBtn.setTitleColor(UIColor.white, for: .normal)
        previewBtn.addTarget(self, action: #selector(previewBtnClick), for: .touchUpInside)
        previewBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(dismissBtn.snp.centerY)
            make.width.equalTo(40)
            make.height.equalTo(25)
            make.right.equalTo(postArticleBtn.snp.left)
        }
    }
}

// MARK:- Custom Methods
extension CPFWriteArticleController {
    
    
}

// MARK:- CPFWriteArticleHeaderViewDelegate
extension CPFWriteArticleHeaderView {
    
    func dismissBtnClick() -> Void {
        delegate?.headerView(headerView: self, didClickDismissBtn: dismissBtn)
    }
    
    func previewBtnClick() -> Void {
        delegate?.headerView(headerView: self, didClickPreviewBtn: previewBtn)
    }
    
    func postArticleBtnClick() -> Void {
        delegate?.headerView(headerView: self, didClickPostArticleBtn: postArticleBtn)
    }
}
