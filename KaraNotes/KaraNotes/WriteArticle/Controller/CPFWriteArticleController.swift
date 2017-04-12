//
//  CPFWriteArticleController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/15.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

import Social

class CPFWriteArticleController: BaseViewController {
    
    var headerView:CPFWriteArticleHeaderView!
    var editView:CPFEditView!
    
    //FIXME: 测试 progressView
    var progress:CGFloat = 0.0
    
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
        editView.editViewDelegate = self
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
        
        //FIXME: 测试 progressView
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeProgressValue), userInfo: nil, repeats: true)
    }
    
    
    //FIXME: 测试 progressView
    func changeProgressValue() -> Void {
        progress += 0.1
        
        CPFProgressView.sharedInstance().showProgressView(progress: progress, promptMessage: "正在上传 \n \(Int(progress * 100))%")
    }
    
    func headerView(headerView: UIView, didClickPostArticleBtn postArticleBtn: UIButton) {
        print("发表")
        let ctr = SLComposeViewController(forServiceType: "com.tencent.xin.sharetimeline")
//        ctr?.setInitialText("初始化字符串")
        present(ctr!, animated: true, completion: nil)
        
    }
}

// MARK: - CPFEditViewDelegate
extension CPFWriteArticleController: CPFEditViewDelegate {
    func editView(editView: CPFEditView, didChangeText text: String) {
        headerView.characterCountLabel.text = "\(text.characters.count) \(CPFLocalizableTitle("writeArticle_character"))"
    }
}
