//
//  CPFAttientionCell.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/20.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFAttentionCell: UICollectionViewCell {
    
    fileprivate var bgImageView: UIImageView!
    fileprivate var authorHeaderImageView: UIImageView!
    fileprivate var authorNameLabel: UILabel!
    fileprivate var articleCreateTimeLabel: UILabel!
    fileprivate var articleTitleLabel: UILabel!
    
    var attentionArticleModel: AttentionArticleModel! {
        didSet {
            
            let shadow = NSShadow()
            shadow.shadowBlurRadius = 4.0
            shadow.shadowColor = CPFRGBA(r: 0, g: 0, b: 0, a: 0.5)
            shadow.shadowOffset = CGSize(width: 0, height: 2)
            let attrDic = [NSShadowAttributeName: shadow]
            
            // 设置文章信息
            bgImageView.image = UIImage.init(named: "attention_article_cell_bgImage")!
            authorHeaderImageView.image = UIImage.init(named: "authorHead_placeholderImage")
            
            authorNameLabel.attributedText = NSAttributedString(string: "我七岁就很帅", attributes: attrDic)
            articleCreateTimeLabel.attributedText = NSAttributedString(string: "2016.12.23", attributes: attrDic)
            
            articleTitleLabel.attributedText = NSAttributedString(string: "iOS开发从入门到改行", attributes: attrDic)
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupSubviews()
    }
}

// MARK: - setup
extension CPFAttentionCell {
    
    func setupSubviews() -> Void {
        bgImageView = UIImageView.init()
        contentView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.left.top.bottom.right.equalTo(contentView)
        }
        
        let authorInfoView = UIView()
        bgImageView.addSubview(authorInfoView)
        authorInfoView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.width.equalTo(141)
            make.height.equalTo(50)
        }
        
        authorHeaderImageView = UIImageView()
        authorInfoView.addSubview(authorHeaderImageView)
        authorHeaderImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(authorInfoView)
            make.width.equalTo(authorInfoView.snp.height)
        }
        authorHeaderImageView.layer.cornerRadius = 25
        authorHeaderImageView.layer.masksToBounds = true
        
        let articleInfoView = UIView()
        authorInfoView.addSubview(articleInfoView)
        articleInfoView.snp.makeConstraints { make in
            make.left.equalTo(authorHeaderImageView.snp.right).offset(5)
            make.right.equalTo(authorInfoView)
            make.centerY.equalTo(authorInfoView.snp.centerY)
            make.height.equalTo(34)
        }
        
        
        
        authorNameLabel = UILabel()
        articleInfoView.addSubview(authorNameLabel)
        authorNameLabel.textColor = UIColor.white
        authorNameLabel.font = UIFont.init(name: "PingFangSC-Semibold", size: 12)!
        authorNameLabel.shadowColor = CPFRGBA(r: 0, g: 0, b: 0, a: 0.3)
        authorNameLabel.shadowOffset = CGSize(width: 0, height: 1.5)
        authorNameLabel.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(17)
        }
        
        articleCreateTimeLabel = UILabel()
        articleInfoView.addSubview(articleCreateTimeLabel)
        articleCreateTimeLabel.textColor = UIColor.white
        articleCreateTimeLabel.font = UIFont.init(name: "PingFangSC-Semibold", size: 10)!
        articleCreateTimeLabel.shadowColor = CPFRGBA(r: 0, g: 0, b: 0, a: 0.3)
        articleCreateTimeLabel.shadowOffset = CGSize(width: 0, height: 1.5)
        articleCreateTimeLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(14)
        }
        
        articleTitleLabel = UILabel()
        bgImageView.addSubview(articleTitleLabel)
        articleTitleLabel.textAlignment = .center
        articleTitleLabel.textColor = UIColor.white
        articleTitleLabel.font = UIFont.init(name: "PingFangSC-Semibold", size: 24)!
        articleTitleLabel.numberOfLines = 0
        articleTitleLabel.shadowColor = CPFRGBA(r: 0, g: 0, b: 0, a: 0.5)
        articleTitleLabel.shadowOffset = CGSize(width: 0, height: 2.5)
        articleTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(bgImageView.snp.left).offset(55*CPFFitWidth)
            make.right.equalTo(bgImageView.snp.right).offset(-55*CPFFitWidth)
            make.centerY.equalTo(bgImageView.snp.centerY)
        }
    }
}
