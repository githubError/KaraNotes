//
//  CPFBrowseArticleController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/28.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFBrowseArticleController: BaseViewController {

    var isMyArticle:Bool = false
    var thumbImage:UIImage!
    var articleTitle:String!
    var articleCreateTime:String!
    var articleAuthorName:String!
    
    fileprivate var scrollView:UIScrollView!
    
    fileprivate var topImageView:UIImageView!
    
    fileprivate var articleInfoView:UIView!
    fileprivate var articleTitleLabel:UILabel!
    fileprivate var articleAuthorLabel:UILabel!
    fileprivate var articleCreateTimeLabel:UILabel!
    
    fileprivate var articleContentWebView:UIWebView!
    
    fileprivate var bottomAssistView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    func dismissCtr() -> Void {
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - setup subviews
extension CPFBrowseArticleController {
    
    func setupSubviews() -> Void {
        setupArticleContentWebView()
        setupScrollView()
        setupTopImageView()
        setupArticleInfoView()
        setupBottomAssistView()
    }
    
    func setupArticleContentWebView() -> Void {
        articleContentWebView = UIWebView()
        articleContentWebView.backgroundColor = UIColor.blue
        view.addSubview(articleContentWebView)
        articleContentWebView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissCtr))
        articleContentWebView.addGestureRecognizer(gestureRecognizer)
    }
    
    func setupScrollView() -> Void {
        scrollView = articleContentWebView.subviews[0] as! UIScrollView
        scrollView.delegate = self
    }
    
    func setupTopImageView() -> Void {
        topImageView = UIImageView()
        topImageView.isUserInteractionEnabled = true
        topImageView.image = thumbImage
        topImageView.contentMode = .scaleToFill
        scrollView.addSubview(topImageView)
        topImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(500*CPFFitHeight)
            make.width.equalTo(CPFScreenW * 2)
        }
    }
    
    func setupArticleInfoView() -> Void {
        articleInfoView = UIView()
        scrollView.addSubview(articleInfoView)
        articleInfoView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(CPFScreenH - 500*CPFFitHeight - 100)
            make.width.equalTo(CPFScreenW)
            make.top.equalTo(topImageView.snp.bottom)
        }
        
        articleTitleLabel = UILabel()
        articleTitleLabel.numberOfLines = 0
        articleTitleLabel.textAlignment = .center
        articleTitleLabel.font = CPFPingFangSC(weight: .medium, size: 20)
        articleTitleLabel.textColor = UIColor.black
        articleTitleLabel.text = articleTitle
        articleInfoView.addSubview(articleTitleLabel)
        articleTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(35)
            make.top.equalTo(articleInfoView.snp.top).offset(5)
        }
        
        articleAuthorLabel = UILabel()
        articleAuthorLabel.font = CPFPingFangSC(weight: .regular, size: 13)
        articleAuthorLabel.textAlignment = .right
        articleAuthorLabel.text = articleAuthorName
        articleInfoView.addSubview(articleAuthorLabel)
        articleAuthorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(articleTitleLabel.snp.bottom).offset(0)
            make.height.equalTo(20)
            make.right.equalTo(articleTitleLabel.snp.centerX)
            make.width.equalTo(150*CPFFitWidth)
        }
        
        let separateLabel = UILabel()
        separateLabel.text = "/"
        separateLabel.font = CPFPingFangSC(weight: .regular, size: 10)
        separateLabel.textColor = CPFRGB(r: 115, g: 115, b: 115)
        separateLabel.textAlignment = .center
        articleInfoView.addSubview(separateLabel)
        separateLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(articleAuthorLabel)
            make.left.equalTo(articleAuthorLabel.snp.right)
            make.width.equalTo(15)
        }
        
        articleCreateTimeLabel = UILabel()
        articleCreateTimeLabel.text = articleCreateTime
        articleCreateTimeLabel.font = CPFPingFangSC(weight: .regular, size: 13)
        articleCreateTimeLabel.textAlignment = .left
        articleInfoView.addSubview(articleCreateTimeLabel)
        articleCreateTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(separateLabel.snp.right)
            make.top.equalTo(articleTitleLabel.snp.bottom).offset(0)
            make.height.equalTo(20)
            make.width.equalTo(150*CPFFitWidth)
        }
    }
    
    func setupBottomAssistView() -> Void {
        bottomAssistView = UIView()
        bottomAssistView.backgroundColor = CPFRGB(r: 240, g: 240, b: 240)
        view.addSubview(bottomAssistView)
        bottomAssistView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(45)
        }
    }
}


// MARK: - UIScrollViewDelegate
extension CPFBrowseArticleController: UIScrollViewDelegate {
    
}
