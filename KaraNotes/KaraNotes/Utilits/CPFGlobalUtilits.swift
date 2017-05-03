//
//  CPFGlobalUtilits.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/14.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit
import SnapKit
import AlamofireImage
import Alamofire

public enum FontWeight: String {
    case semibold = "Semibold"
    case medium = "Medium"
    case regular = "Regular"
    case light = "Light"
    case thin = "Thin"
    case ultralight = "Ultralight"
}

public enum CPFNetworkRoute: String {
    
    case base = "http://karanotes.viakiba.cn/karanotes"                              // 基地址
    case login = "/select/user/login"                  // 登录
    case register = "/select/user/register"            // 注册
    case checkEmail = "/extra/user/checkemail"        // 检查邮箱可用性
    case insertArticle = "/article/insert"      // 新增文章
    case deleteArticle = "/article/delete"      // 删除文章
    case updateArticle = "/article/update"      // 更新文章
    case uploadImage = "/file/imgs/article"           // 上传图片
    case articleImage = "/imgs/article"               // 文章图片下载
    case headerImage = "/file/imgs/logo"                   // 用户头像
    case backgroundImage = "/file/imgs/backlogo"           // 用户背景图片
    case updateUserInfo = "/user/updateuserinfo"           // 更改用户信息
    case myArticleWithoutCategory = "/extra/articlelist/alllist"   // 获取我的文章，不限制分类
    case loadArticleContent = "/select/articledetail"              // 加载文章详情
    
    case searchUser = "/select/user/list"                     // 搜索用户
    case searchArticle = "/select/article/title"              // 搜索文章标题
    
    case addAttent = "/follow/insert"                         // 添加关注
    case cancelAttent = "/follow/delete"                      // 取消关注
    
    static func getAPIFromRouteType(route: CPFNetworkRoute) -> String {
        return "\(CPFNetworkRoute.base.rawValue)\(route.rawValue)"
    }
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

public func CPFCreateImageWithBackground(color: UIColor, withHeight height:CGFloat) -> UIImage {
    let rect = CGRect(x: 0.0, y: 0.0, width: 0.0, height: height)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor)
    context?.addRect(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}

public let CPFGlobalColor = CPFRGB(r: 245, g: 245, b: 245)
public var CPFRandomColor = CPFRGB(r: Int(arc4random_uniform(255)), g: Int(arc4random_uniform(255)), b: Int(arc4random_uniform(255)))

// 颜色偏好
public let CPFNavColor = CPFRGBA(r: 236, g: 68, b: 75, a: 1.0)           //浅蓝 CPFRGBA(r: 26, g: 167, b: 242, a: 1.0)
public let CPFTabTintColor = CPFRGBA(r: 236, g: 68, b: 75, a: 1.0)

public let CPFScreenW = UIScreen.main.bounds.size.width
public let CPFScreenH = UIScreen.main.bounds.size.height


public let CPFFitWidth = UIScreen.main.bounds.size.width / 375
public let CPFFitHeight = UIScreen.main.bounds.size.height / 667

public typealias JSONDictionary = [String:AnyObject]

// 用户偏好 -> key
public let CPFUserToken = "CPFUserToken"
public let CPFUserEmail = "CPFUserEmail"
public let CPFUserPath = "CPFUserPath"
public let CPFUserSignature = "CPFUserSignature"
public let CPFUserSex = "CPFUserSex"
public let CPFUserHeaderImg = "CPFUserHeaderImg"
public let CPFUserBgImg = "CPFUserBgImg"
public let CPFUserName = "CPFUserName"
public let CPFUserID = "CPFUserID"

public let kCPFUserInfoHasChanged = "kCPFUserInfoHasChanged"

public func setUserInfo(value: AnyObject, forKey key: String) {
    UserDefaults.standard.set(value, forKey: key)
    UserDefaults.standard.synchronize()
}

public func getUserInfoForKey(key: String) -> String {
    let value = String(describing: UserDefaults.standard.value(forKey: key)!)
    return value
}


// MARK: - 生成10位时间戳

public func createTimestamp() -> String {
    let date = Date(timeIntervalSinceNow: 0)
    let timeInterval = date.timeIntervalSince1970 * 1000
    let timeString = "\(timeInterval)"
    let index = timeString.index(timeString.startIndex, offsetBy: 10)
    let timestamp = timeString.substring(to: index)
    return timestamp
}

public func timestampToString(timestamp:TimeInterval) -> String {
    
    let timeInterval:TimeInterval = TimeInterval(timestamp) / 1000
    let date = Date(timeIntervalSince1970: timeInterval)
    let dformatter = DateFormatter()
    dformatter.dateFormat = "yyyy.MM.dd"
    return dformatter.string(from: date)
}
