//
//  CPFChangeUserInfoCell.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/20.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

enum CPFChangeUserInfoCellType {
    case userHeaderImgCell, userNameCell, userSexCell
}

class CPFChangeUserInfoCell: UITableViewCell {
    
    var cellType:CPFChangeUserInfoCellType!
    
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
        
    }
}
