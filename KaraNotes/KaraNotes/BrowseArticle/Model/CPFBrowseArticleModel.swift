//
//  CPFBrowseArticleModel.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/5/2.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import Foundation

struct CPFBrowseArticleModel {
    
    var abstract_content:String!
    var article_attachment:String!
    var article_content:String!
    var article_create_time:TimeInterval!
    var article_id:String!
    var article_show_img:String!
    var article_title:String!
    var article_update_time:TimeInterval!
//    var classify_content:String!
    var classify_id:String!
    
    var collect_num:Int!
    var comment_num:Int!
    var praise_num:Int!
    var is_collect:String!
    var is_praise:String!
    
    var tag_content:String!
    var user_id:String!
}

extension CPFBrowseArticleModel {
    
    static func parse(json: JSONDictionary) -> CPFBrowseArticleModel {
        
        guard let abstract_content = json["abstract_content"] as? String else {fatalError("解析CPFBrowseArticleModel出错")}
        guard let article_content = json["article_content"] as? String else {fatalError("解析CPFBrowseArticleModel出错")}
        guard let article_attachment = json["article_attachment"] as? String else {fatalError("解析CPFBrowseArticleModel出错")}
        guard let article_create_time = json["article_create_time"] as? TimeInterval else {fatalError("解析CPFBrowseArticleModel出错")}
        guard let article_id = json["article_id"] as? String else {fatalError("解析CPFBrowseArticleModel出错")}
        guard let article_show_img = json["article_show_img"] as? String else {fatalError("解析CPFBrowseArticleModel出错")}
        guard let article_title = json["article_title"] as? String else {fatalError("解析CPFBrowseArticleModel出错")}
        guard let article_update_time = json["article_update_time"] as? TimeInterval else {fatalError("解析CPFBrowseArticleModel出错")}
        guard let classify_id = json["classify_id"] as? String else {fatalError("解析CPFBrowseArticleModel出错")}
//        guard let classify_content = json["classify_content"] as? String else {fatalError("解析CPFBrowseArticleModel出错")}
        
        guard let collect_num = json["collect_num"] as? Int else {fatalError("解析CPFBrowseArticleModel出错")}
        guard let comment_num = json["comment_num"] as? Int else {fatalError("解析CPFBrowseArticleModel出错")}
        guard let praise_num = json["praise_num"] as? Int else {fatalError("解析CPFBrowseArticleModel出错")}
        guard let is_collect = json["is_collect"] as? String else {fatalError("解析CPFBrowseArticleModel出错")}
        guard let is_praise = json["is_praise"] as? String else {fatalError("解析CPFBrowseArticleModel出错")}
        
        guard let tag_content = json["tag_content"] as? String else {fatalError("解析CPFBrowseArticleModel出错")}
        guard let user_id = json["user_id"] as? String else {fatalError("解析CPFBrowseArticleModel出错")}
        
        return CPFBrowseArticleModel(abstract_content: abstract_content, article_attachment: article_attachment, article_content: article_content, article_create_time: article_create_time, article_id: article_id, article_show_img: article_show_img, article_title: article_title, article_update_time: article_update_time, classify_id: classify_id, collect_num: collect_num, comment_num: comment_num, praise_num: praise_num, is_collect: is_collect, is_praise: is_praise, tag_content: tag_content, user_id: user_id)
    }
}
