//
//  CPFAttientionCell.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/20.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFAttentionCell: UICollectionViewCell {
    
    var bgImageView: UIImageView!
    var authorInfoView: UIView!
    var authorHeaderImageView: UIImageView!
    var authorNameLabel: UILabel!
    var articleCreateTimeLabel: UILabel!
    var articleTitleLabel: UILabel!
    
    var attentionArticle: AttentionArticle! {
        didSet {
            // 设置文章信息
            
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
        
    }
}
