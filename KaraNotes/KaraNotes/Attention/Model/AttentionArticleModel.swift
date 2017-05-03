//
//  AttentionArticle.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/20.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import Foundation

struct AttentionArticleModel {
    
    var abstract_content:String
    var article_attachment:String
    var article_create_time:TimeInterval
    var article_id:String
    var article_show_img:String
    var article_title:String
    var article_update_time:UInt16
    var user_id:String
    
    var user_email:String
    var user_headimg:String
    var user_name:String
    var user_sex:String
    
    var article_create_formatTime:String {
        return timestampToString(timestamp: article_create_time)
    }
    
    var article_show_img_URL:URL {
        return URL(string: article_show_img)!
    }
}

extension AttentionArticleModel {
    
    static func parse(json: JSONDictionary) -> AttentionArticleModel {
        
        guard let abstract_content = json["abstract_content"] as? String else {fatalError("解析AttentionArticleModel出错")}
        guard let article_attachment = json["article_attachment"] as? String else {fatalError("解析AttentionArticleModel出错")}
        guard let article_create_time = json["article_create_time"] as? TimeInterval else {fatalError("解析AttentionArticleModel出错")}
        guard let article_id = json["article_id"] as? String else {fatalError("解析AttentionArticleModel出错")}
        guard let article_show_img = json["article_show_img"] as? String else {fatalError("解析AttentionArticleModel出错")}
        guard let article_title = json["article_title"] as? String else {fatalError("解析AttentionArticleModel出错")}
        guard let article_update_time = json["article_update_time"] as? UInt16 else {fatalError("解析AttentionArticleModel出错")}
        
        guard let user_id = json["user_id"] as? String else {fatalError("解析AttentionArticleModel出错")}
        
        guard let userinfo = json["userinfo"] as? JSONDictionary else {fatalError("解析AttentionArticleModel出错")}
        
        guard let user_email = userinfo["user_email"] as? String else {fatalError("解析AttentionArticleModel出错")}
        guard let user_headimg = userinfo["user_headimg"] as? String else {fatalError("解析AttentionArticleModel出错")}
        guard let user_name = userinfo["user_name"] as? String else {fatalError("解析AttentionArticleModel出错")}
        guard let user_sex = userinfo["user_sex"] as? String else {fatalError("解析AttentionArticleModel出错")}
        
        return AttentionArticleModel(abstract_content: abstract_content, article_attachment: article_attachment, article_create_time: article_create_time, article_id: article_id, article_show_img: article_show_img, article_title: article_title, article_update_time: article_update_time, user_id: user_id, user_email: user_email, user_headimg: user_headimg, user_name: user_name, user_sex: user_sex)
    }
}
