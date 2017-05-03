//
//  CPFSearchUserModel.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/5/2.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import Foundation

struct CPFSearchUserModel {
    
    var follow_id:String
    var is_eachother:String
    var user_headimg:String
    var user_name:String
    var user_id:String
    var user_sex:Int
    var user_email:String
}

extension CPFSearchUserModel {
    
    static func parse(json: JSONDictionary) -> CPFSearchUserModel {
        print("------\(json)")
        guard let follow_id = json["follow_id"] as? String else {fatalError("解析CPFSearchUserModel出错")}
        guard let is_eachother = json["is_eachother"] as? String else {fatalError("解析CPFSearchUserModel出错")}
        guard let user_headimg = json["user_headimg"] as? String else {fatalError("解析CPFSearchUserModel出错")}
        guard let user_name = json["user_name"] as? String else {fatalError("解析CPFSearchUserModel出错")}
        guard let user_id = json["user_id"] as? String else {fatalError("解析CPFSearchUserModel出错")}
        guard let user_sex = json["user_sex"] as? Int else {fatalError("解析CPFSearchUserModel出错")}
        guard let user_email = json["user_email"] as? String else {fatalError("解析CPFSearchUserModel出错")}
        
        return CPFSearchUserModel(follow_id: follow_id, is_eachother: is_eachother, user_headimg: user_headimg, user_name: user_name, user_id: user_id, user_sex: user_sex, user_email: user_email)
    }
}
