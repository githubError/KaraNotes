//
//  UIButton+Extension.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/7.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

extension UIButton {
    
    public func verticalImageAndTitleWithSpacing(spacing:Float) -> Void {
        let titleLabelSize = titleLabel?.frame.size
        titleLabel?.frame.size = CGSize(width: frame.size.width, height: frame.size.height)
        let totalHeight = (frame.size.height) + CGFloat(spacing)
        
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: (titleLabelSize?.width)!, bottom: -(totalHeight - (titleLabelSize?.height)!), right: 0.0)
        imageEdgeInsets = UIEdgeInsets(top: (totalHeight - (titleLabelSize?.height)!), left: 0.0, bottom: 0.0, right: -(titleLabelSize?.height)!)
        
    }
}
