//
//  CPFMyArticleCell.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/19.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class CPFMyArticleCell: UITableViewCell {

    var thumbImage:UIImage = UIImage()
    
    fileprivate var thumbImageView:UIImageView!
    var titleLabel:UILabel!
    var createTimeLabel:UILabel!
    
    var myArticleModel:CPFMyArticleModel! {
        didSet {
//            thumbImageView.af_setImage(withURL: myArticleModel.article_show_img_URL)
            Alamofire.request(myArticleModel.article_show_img_URL).responseImage { (response) in
                if let image = response.result.value {
                    self.thumbImage = image
                    self.thumbImageView.image = image
                }
            }
            titleLabel.text = myArticleModel.article_title
            createTimeLabel.text = myArticleModel.article_create_formatTime
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupSubviews()
    }
}


extension CPFMyArticleCell {
    
    func setupSubviews() -> Void {
        thumbImageView = UIImageView()
        addSubview(thumbImageView)
        thumbImageView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(snp.height)
        }
        
        let rightView: UIView = UIView()
        rightView.backgroundColor = UIColor.clear
        addSubview(rightView)
        rightView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.left.equalTo(thumbImageView.snp.right).offset(10)
            make.height.equalTo(snp.height).offset(-30)
            make.centerY.equalToSuperview()
        }
        
        titleLabel = UILabel()
        titleLabel.font = CPFPingFangSC(weight: .regular, size: 20)
        titleLabel.textColor = UIColor.black
        rightView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        createTimeLabel = UILabel()
        createTimeLabel.font = CPFPingFangSC(weight: .regular, size: 14)
        createTimeLabel.textColor = CPFRGB(r: 155, g: 155, b: 155)
        rightView.addSubview(createTimeLabel)
        createTimeLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(15)
        }
    }
}
