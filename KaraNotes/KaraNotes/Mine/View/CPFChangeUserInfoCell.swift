//
//  CPFChangeUserInfoCell.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/20.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

enum CPFChangeUserInfoCellType:Int {
    case userHeaderImgCell = 0, userNameCell, userSexCell, userNormalCell
}

class CPFChangeUserInfoCell: UITableViewCell {
    
    open var cellType:CPFChangeUserInfoCellType! {
        didSet{
            switch cellType.rawValue {
            case 0:
                textField.isHidden = true
                sexLabel.isHidden = true
            case 1:
                headerImageView.isHidden = true
                sexLabel.isHidden = true
            case 2:
                headerImageView.isHidden = true
                textField.isHidden = true
            case 3:
                headerImageView.isHidden = true
                textField.isHidden = true
                sexLabel.isHidden = true
            default:
                headerImageView.isHidden = true
                sexLabel.isHidden = true
                textField.isHidden = true
            }
        }
    }
    
    var typeLabel:UILabel!
    var textField:UITextField!
    var headerImageView:UIImageView!
    var sexLabel:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubViews()
    }
}


// MARK: - Setup Subviews
extension CPFChangeUserInfoCell {
    
    func setupSubViews() -> Void {
        typeLabel = UILabel()
        typeLabel.textAlignment = .left
        typeLabel.font = CPFPingFangSC(weight: .regular, size: 14)
        typeLabel.textColor = UIColor.black
        addSubview(typeLabel)
        typeLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(snp.height)
        }
        
        let indicatorImageView = UIImageView()
        indicatorImageView.image = UIImage.init(named: "indicator")
        addSubview(indicatorImageView)
        indicatorImageView.snp.makeConstraints { (make) in
            make.height.equalTo(14)
            make.width.equalTo(9)
            make.right.equalTo(snp.right).offset(-15)
            make.centerY.equalTo(snp.centerY)
        }
        
        headerImageView = UIImageView()
        addSubview(headerImageView)
        headerImageView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(indicatorImageView.snp.left).offset(-5)
            make.width.equalTo(snp.height)
        }
        headerImageView.layer.cornerRadius = 10
        headerImageView.layer.masksToBounds = true
        
        sexLabel = UILabel()
        sexLabel.textAlignment = .center
        sexLabel.font = CPFPingFangSC(weight: .regular, size: 16)
        sexLabel.textColor = UIColor.black
        addSubview(sexLabel)
        sexLabel.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(headerImageView)
        }
        
        textField = UITextField()
        textField.borderStyle = .none
        textField.clearButtonMode = .whileEditing
        addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(typeLabel.snp.right).offset(10)
            make.right.equalTo(headerImageView.snp.left).offset(10)
            make.centerY.equalTo(snp.centerY)
            make.height.equalTo(30)
        }
        
        let separateLineImageView = UIImageView()
        separateLineImageView.image = UIImage.init(named: "verticalLine")
        addSubview(separateLineImageView)
        separateLineImageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(snp.bottom).offset(0.5)
            make.height.equalTo(0.5)
        }
    }
}
