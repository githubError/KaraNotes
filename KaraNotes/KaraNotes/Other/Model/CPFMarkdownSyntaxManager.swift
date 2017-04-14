//
//  CPFMarkdownSyntaxManager.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/13.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFMarkdownSyntaxManager: NSObject {
    static let instance: CPFMarkdownSyntaxManager = CPFMarkdownSyntaxManager()
    var markdownSyntaxModel:CPFMarkdownSyntaxModel?
    static func sharedManeger() -> CPFMarkdownSyntaxManager {
        return instance
    }
}

extension CPFMarkdownSyntaxManager {
    func syntaxModelsFromText(text: String) -> [CPFMarkdownSyntaxModel] {
        var markdownSyntaxModels:[CPFMarkdownSyntaxModel] = []
        for i in 0...CPFMarkdownSyntaxType.NumberOfMarkdownSyntax.rawValue {
            let expression = CPFMarkdownSyntaxType(rawValue: i)?.regularExpressionFromMarkdownSyntaxType(type: CPFMarkdownSyntaxType(rawValue: i)!)
            let matches = expression?.matches(in: text, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: text.characters.count))
            
            for result in matches! {
                markdownSyntaxModel = CPFMarkdownSyntaxModel(markdownSyntaxType: CPFMarkdownSyntaxType(rawValue: i)!, range: result.range)
                
                if let model = markdownSyntaxModel {
                    markdownSyntaxModels.append(model)
                }
            }
        }
        return markdownSyntaxModels
    }
}
