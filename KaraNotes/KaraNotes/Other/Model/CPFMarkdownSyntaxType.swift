//
//  CPFMarkdownSyntaxType.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/13.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import Foundation

enum CPFMarkdownSyntaxType:Int {
    case headers = 0,title,links,images,bold,emphasis,
    deletions,quotes,blockquotes,separate,ulLists,
    olLists,inlineCode,codeBlock,implicitCodeBlock,
    NumberOfMarkdownSyntax
    
    func regularExpressionFromMarkdownSyntaxType(type: CPFMarkdownSyntaxType) -> NSRegularExpression {
        switch type {
        case .headers://标题
            return regexp(pattern: "^(#+)(.*)", options: NSRegularExpression.Options.anchorsMatchLines)
            
        case .title://标题
            return regexp(pattern: ".*\\n=+[(\\s)|=]+", options: NSRegularExpression.Options(rawValue: 0))
            
        case .links://链接
            return regexp(pattern: "(\\[.+\\]\\([^\\)]+\\))|(<.+>)", options: NSRegularExpression.Options(rawValue: 0))
            
        case .images://图片
            return regexp(pattern: "!\\[[^\\]]+\\]\\([^\\)]+\\)", options: NSRegularExpression.Options(rawValue: 0))
            
        case .bold://粗体
            return regexp(pattern: "(\\*\\*|__)(.*?)\\1", options: NSRegularExpression.Options(rawValue: 0))
            
        case .emphasis://强调(斜体)
            return regexp(pattern: "(\\*|_)(.*?)\\1", options: NSRegularExpression.Options(rawValue: 0))
            
        case .deletions://删除
            return regexp(pattern: "\\~\\~(.*?)\\~\\~", options: NSRegularExpression.Options(rawValue: 0))
            
        case .quotes://引用
            return regexp(pattern: "\\:\\\"(.*?)\\\"\\:", options: NSRegularExpression.Options(rawValue: 0))
            
        case .inlineCode://內联代码块
            return regexp(pattern: "`{1,2}[^`](.*?)`{1,2}", options: NSRegularExpression.Options(rawValue: 0))
            
        case .blockquotes://引用块
            return regexp(pattern: "\n(&gt;|\\>)(.*)",options: NSRegularExpression.Options(rawValue: 0))
            
        case .separate://分割线
            return regexp(pattern: "^-+$", options: NSRegularExpression.Options.anchorsMatchLines)
            
        case .ulLists://无序列表
            return regexp(pattern: "^[\\s]*[-\\*\\+] +(.*)", options: NSRegularExpression.Options.anchorsMatchLines)
            
        case .olLists://有序列表
            return regexp(pattern: "^[\\s]*[0-9]+\\.(.*)", options: NSRegularExpression.Options.anchorsMatchLines)
            
        case .codeBlock://```包围的代码块
            return regexp(pattern: "```([\\s\\S]*?)```[\\s]?", options: NSRegularExpression.Options(rawValue: 0))
            
        case .implicitCodeBlock://4个缩进也算代码块
            return regexp(pattern: "^\n[ \\f\\r\\t\\v]*(( {4}|\\t).*(\\n|\\z))+", options: NSRegularExpression.Options.anchorsMatchLines)
            
        default:
            break
        }
        return NSRegularExpression()
    }
    
    fileprivate func regexp(pattern: String, options: NSRegularExpression.Options) -> NSRegularExpression {
        return try! NSRegularExpression(pattern: pattern, options: options)
    }
}
