//
//  CPFMyArticleModel.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/19.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import Foundation

struct CPFMyArticleModel {
    
    var abstract_content:String
    var article_attachment:String
    var article_create_time:TimeInterval
    var article_id:String
    var article_show_img:String
    var article_title:String
    var article_update_time:UInt16
    var classify_id:String
    var collect_num:Int
    var comment_num:Int
    var praise_num:Int
    var user_id:String
    
    var article_create_formatTime:String {
        
        return timestampToString(timestamp: article_create_time)
    }
    
    var article_show_img_URL:URL {
        return URL(string: article_show_img)!
    }
}

extension CPFMyArticleModel {
    
    static func parse(json: JSONDictionary) -> CPFMyArticleModel {
        
        guard let abstract_content = json["abstract_content"] as? String else {fatalError("解析CPFMyArticleModel出错")}
        guard let article_attachment = json["article_attachment"] as? String else {fatalError("解析CPFMyArticleModel出错")}
        guard let article_create_time = json["article_create_time"] as? TimeInterval else {fatalError("解析CPFMyArticleModel出错")}
        guard let article_id = json["article_id"] as? String else {fatalError("解析CPFMyArticleModel出错")}
        guard let article_show_img = json["article_show_img"] as? String else {fatalError("解析CPFMyArticleModel出错")}
        guard let article_title = json["article_title"] as? String else {fatalError("解析CPFMyArticleModel出错")}
        guard let article_update_time = json["article_update_time"] as? UInt16 else {fatalError("解析CPFMyArticleModel出错")}
        guard let classify_id = json["classify_id"] as? String else {fatalError("解析CPFMyArticleModel出错")}
        guard let collect_num = json["collect_num"] as? Int else {fatalError("解析CPFMyArticleModel出错")}
        guard let comment_num = json["comment_num"] as? Int else {fatalError("解析CPFMyArticleModel出错")}
        guard let praise_num = json["praise_num"] as? Int else {fatalError("解析CPFMyArticleModel出错")}
        guard let user_id = json["user_id"] as? String else {fatalError("解析CPFMyArticleModel出错")}
        
        return CPFMyArticleModel(abstract_content: abstract_content, article_attachment: article_attachment, article_create_time: article_create_time, article_id: article_id, article_show_img: article_show_img, article_title: article_title, article_update_time: article_update_time, classify_id: classify_id, collect_num: collect_num, comment_num: comment_num, praise_num: praise_num, user_id: user_id)
    }
}
