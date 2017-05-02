//
//  CPFSearchArticleModel.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/5/2.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import Foundation

struct CPFSearchArticleModel {
    
    var article_create_time:TimeInterval
    var article_id:String
    var article_show_img:String
    var article_title:String
    
    var article_create_formatTime:String {
        
        return timestampToString(timestamp: article_create_time)
    }
    
    var article_show_img_URL:URL {
        return URL(string: article_show_img)!
    }
}

extension CPFSearchArticleModel {
    
    static func parse(json: JSONDictionary) -> CPFSearchArticleModel {
        
        guard let article_create_time = json["article_create_time"] as? TimeInterval else {fatalError("解析CPFSearchArticleModel出错")}
        guard let article_id = json["article_id"] as? String else {fatalError("解析CPFSearchArticleModel出错")}
        guard let article_show_img = json["article_show_img"] as? String else {fatalError("解析CPFSearchArticleModel出错")}
        guard let article_title = json["article_title"] as? String else {fatalError("解析CPFSearchArticleModel出错")}
        
        return CPFSearchArticleModel(article_create_time: article_create_time, article_id: article_id, article_show_img: article_show_img, article_title: article_title)
    }
}
