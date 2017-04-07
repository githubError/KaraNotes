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
// 颜色
public func CPFRGBA(r:Int, g:Int, b:Int, a:Float) -> UIColor { return UIColor.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a)) }

public func CPFRGB(r:Int, g:Int, b:Int) -> UIColor { return CPFRGBA(r: r, g: g, b: b, a: 1.0) }

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

