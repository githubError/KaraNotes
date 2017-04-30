//
//  UIImage+Extension.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/7.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

// MARK: - 标准库类扩展
extension UIImage {
    public func scaleToSize(newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return newImage
    }
    
    public func scaleImageToSize(newSize: CGSize) -> Data {
        UIGraphicsBeginImageContext(newSize)
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return Data() }
        UIGraphicsEndImageContext()
        return UIImageJPEGRepresentation(newImage, 0.8)!
    }
}
