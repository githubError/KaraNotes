//
//  CPFWriteArticleController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/15.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFWriteArticleController: BaseViewController {
    
    var headerView:CPFWriteArticleHeaderView!
    var editView:CPFEditView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.purple
        
        setupSubviews()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}

// MARK: - setup subviews
extension CPFWriteArticleController {
    
    func setupSubviews() -> Void {
        setupHeaderView()
        setupEditView()
    }
    
    func setupHeaderView() -> Void {
        headerView = CPFWriteArticleHeaderView(frame: CGRect(x: 0, y: 0, width: CPFScreenW, height: 64))
        headerView.delegate = self
        view.addSubview(headerView)
    }
    
    func setupEditView() -> Void {
        editView = CPFEditView()
        view.addSubview(editView)
        editView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - CPFWriteArticleHeaderViewDelegate
extension CPFWriteArticleController: CPFWriteArticleHeaderViewDelegate {
    
    func headerView(headerView: UIView, didClickDismissBtn dismissBtn: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func headerView(headerView: UIView, didClickPreviewBtn previewBtn: UIButton) {
        print("预览")
    }
    
    func headerView(headerView: UIView, didClickPostArticleBtn postArticleBtn: UIButton) {
        print("发表")
    }
}
