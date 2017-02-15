//
//  CPFGlobalUtilits.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/14.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

// MARK: - 全局函数（宏定义）

// 颜色
public func CPFRGBA(r:Float, g:Float, b:Float, a:Float) -> UIColor { return UIColor(colorLiteralRed: r/255.0, green: g/255.0, blue: b/255.0, alpha: a) }

public func CPFRGB(r:Float, g:Float, b:Float) -> UIColor { return CPFRGBA(r: r, g: g, b: b, a: 1.0) }

// 国际化
public func CPFLocalizableTitle(_ title: String) -> String { return NSLocalizedString(title, comment: title) }



// MARK: - 全局常量
public let CPFGlobalColor = CPFRGB(r: 245, g: 245, b: 245)



// MARK: - 标准库类扩展
extension UIImage {
    public func scaleToSize(newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return UIImage()
        }
        
        return newImage
    }
}
