//
//  UIButton+Extension.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/7.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

extension UIButton {
    
    public func verticalImageAndTitleWithSpacing(spacing:CGFloat) -> Void {
        let imageSize:CGSize = imageView!.frame.size
        let titleSize:CGSize = titleLabel!.frame.size
        titleEdgeInsets = UIEdgeInsets(top: 0, left:-imageSize.width, bottom: -imageSize.height - spacing, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: -titleSize.height - spacing, left: 0, bottom: 0, right: -titleSize.width)
    }
}
