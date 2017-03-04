//
//  CPFGlobalUtilits.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/14.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit
import SnapKit

public enum FontWeight: String {
    case semibold = "Semibold"
    case medium = "Medium"
    case regular = "Regular"
    case light = "Light"
    case thin = "Thin"
    case ultralight = "Ultralight"
}

public enum CPFNetworkRoute: String {
    case base = "http://viakiba.cn:8080/KaraNotes"                              // 基地址
    case login = "http://viakiba.cn:8080/KaraNotes/user/login"                  // 登录
    case register = "http://viakiba.cn:8080/KaraNotes/user/register"            // 注册
    case checkEmail = "http://viakiba.cn:8080/KaraNotes/user/checkemail"        // 检查邮箱可用性
    case insertArticle = "http://viakiba.cn:8080/KaraNotes/article/insert"      // 新增文章
    case deleteArticle = "http://viakiba.cn:8080/KaraNotes/article/delete"      // 删除文章
    case updateArticle = "http://viakiba.cn:8080/KaraNotes/article/update"      // 更新文章
}

// MARK: - 全局函数（宏定义）

// 颜色
public func CPFRGBA(r:Int, g:Int, b:Int, a:Float) -> UIColor { return UIColor.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a)) }

public func CPFRGB(r:Int, g:Int, b:Int) -> UIColor { return CPFRGBA(r: r, g: g, b: b, a: 1.0) }

// 国际化
public func CPFLocalizableTitle(_ title: String) -> String { return NSLocalizedString(title, comment: title) }


// 字体
public func CPFPingFangSC(weight:FontWeight, size:CGFloat) -> UIFont {
    switch weight {
    case .light, .medium, .regular, .semibold, .thin, .ultralight:
        let costomFont = UIFont(name: "PingFangSC-\(weight.rawValue)", size: size)
        if let font = costomFont {
            return font
        }
        return UIFont()
    }
}


// MARK: - 全局常量
public let CPFGlobalColor = CPFRGB(r: 245, g: 245, b: 245)
public var CPFRandomColor = CPFRGB(r: Int(arc4random_uniform(255)), g: Int(arc4random_uniform(255)), b: Int(arc4random_uniform(255)))

public let CPFScreenW = UIScreen.main.bounds.size.width
public let CPFScreenH = UIScreen.main.bounds.size.height


public let CPFFitWidth = UIScreen.main.bounds.size.width / 375
public let CPFFitHeight = UIScreen.main.bounds.size.height / 667

public typealias JSONDictionary = [String:AnyObject]

// 用户偏好 -> key
public let CPFUserToken = "CPFUserToken"
public let CPFUserEmail = "CPFUserEmail"
public let CPFUserPath = "CPFUserPath"


// MARK: - 标准库类扩展
extension UIImage {
    public func scaleToSize(newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        return newImage
    }
}

extension UIView {
    
    var size: CGSize {
        get {
            return frame.size
        }
        
        set(newValue) {
            var tempFrame = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    var width: CGFloat {
        get {
            return size.width
        }
        
        set(newValue) {
            var tempSize = size
            tempSize.width = newValue
            size = tempSize
        }
    }
    
    var height: CGFloat {
        get {
            return size.height
        }
        
        set(newValue) {
            var tempSize = size
            tempSize.height = newValue
            size = tempSize
        }
    }
    
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        
        set(newValue) {
            var tempFrame = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        
        set(newValue) {
            var tempFrame = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    var left : CGFloat {
        get {
            return x
        }
        
        set(newValue) {
            x = newValue
        }
    }
    
    var right : CGFloat {
        get {
            return x + width
        }
        
        set(newValue) {
            x = newValue - width
        }
    }
    
    var top : CGFloat {
        get {
            return y
        }
        
        set(newValue) {
            y = newValue
        }
    }
    
    var bottom : CGFloat {
        get {
            return y + height
        }
        
        set(newValue) {
            y = newValue - height
        }
    }
    
    var centerX : CGFloat {
        get {
            return center.x
        }
        
        set(newValue) {
            center = CGPoint(x: newValue, y: center.y)
        }
    }
    
    var centerY : CGFloat {
        get {
            return center.y
        }
        
        set(newValue) {
            center = CGPoint(x: center.x, y: newValue)
        }
    }
    
    var middleX : CGFloat {
        get {
            return width / 2
        }
    }
    
    var middleY : CGFloat {
        get {
            return height / 2
        }
    }
    
    var middlePoint : CGPoint {
        get {
            return CGPoint(x: middleX, y: middleY)
        }
    }
    
}
