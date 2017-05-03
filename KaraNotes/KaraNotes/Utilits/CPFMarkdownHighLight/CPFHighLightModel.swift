//
//  HighLightModel.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/13.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import Foundation

struct CPFHighLightModel {
    
    var italic:Bool = false
    var strong:Bool = false
    var deletionLine:Bool = false
    var fontSize:CGFloat = 16.0
    var foregroundColor:UIColor = UIColor.black
    var backgroundColor:UIColor = UIColor.clear
    
    mutating func attributesFromMarkdownSyntaxType(markdownSyntaxType: CPFMarkdownSyntaxType) -> [String : Any] {
        
        switch markdownSyntaxType {
        case .headers:
             foregroundColor = colorsDic["headers"]!
             fontSize = 17.0
             
        case .title:
             foregroundColor = colorsDic["title"]!
             fontSize = 17.0
             
        case .links:
             foregroundColor = colorsDic["link"]!
             
        case .images:
             foregroundColor = colorsDic["image"]!
             
        case .bold:
             foregroundColor = colorsDic["bold"]!
             strong = true
             
        case .emphasis:
             foregroundColor = colorsDic["emphasis"]!
             italic = true
             
        case .deletions:
             foregroundColor = colorsDic["deletion"]!
             deletionLine = true
             
        case .quotes:
             foregroundColor = colorsDic["quotes"]!
             
        case .blockquotes:
             foregroundColor = colorsDic["blockquotes"]!
             
        case .separate:
             foregroundColor = colorsDic["separate"]!
             
        case .ulLists:
             foregroundColor = colorsDic["ulLists"]!
            
        case .olLists:
             foregroundColor = colorsDic["olLists"]!
            
        case .inlineCode:
             foregroundColor = colorsDic["inlineCode"]!
            
        case .codeBlock:
             foregroundColor = colorsDic["codeBlock"]!
            
        case .implicitCodeBlock:
             foregroundColor = colorsDic["implicitCodeBlock"]!
        default:
            foregroundColor = colorsDic["bold"]!
        }
        return self.attributes()
    }
    
    fileprivate let colorsDic = ["headers" : CPFRGB(r:  10, g:  120, b:  20),
                     "title" : CPFRGB(r:  220, g:  220, b:  20),
                     "link" : CPFRGB(r:  70, g:  93, b:  198),
                     "image" : CPFRGB(r:  182, g:  69, b:  124),
                     "bold" : CPFRGB(r:  0, g:  0, b:  0),
                     "deletion" : CPFRGB(r:  116, g:  114, b:  112),
                     "quotes" : CPFRGB(r:  174, g:  138, b:  134),
                     "blockquotes" : CPFRGB(r:  174, g:  138, b:  134),
                     "separate" : CPFRGB(r:  189, g:  21, b:  134),
                     "emphasis" : CPFRGB(r:  112, g:  112, b:  112),
                     "ulLists" : CPFRGB(r:  73, g:  54, b:  46),
                     "olLists" : CPFRGB(r:  73, g:  54, b:  46),
                     "inlineCode" : CPFRGB(r:  51, g:  161, b:  145),
                     "codeBlock" : CPFRGB(r:  51, g:  161, b:  145),
                     "implicitCodeBlock" : CPFRGB(r:  51, g:  161, b:  145),]
    
    fileprivate func attributes() -> [String : Any] {
        var font = CPFPingFangSC(weight: .regular, size: 16.0)
        
        if strong {
            let fontDesc = UIFontDescriptor(name: font.fontName, size: fontSize)
            font = UIFont.init(descriptor: fontDesc.withSymbolicTraits(.traitBold)!, size: fontSize)
        }
        
        if italic {
            let matrix = __CGAffineTransformMake(1.0, 0.0, CGFloat(tanf(Float(15 * Double.pi / 180))), 1.0, 0.0, 0.0)
            let fontDesc = UIFontDescriptor(name: font.fontName, matrix: matrix)
            font = UIFont(descriptor: fontDesc, size: fontSize)
        }
        
        let underlineStyle = deletionLine ? NSUnderlineStyle.styleSingle.rawValue : NSUnderlineStyle.styleNone.rawValue
        
        return [NSFontAttributeName : font,
                NSForegroundColorAttributeName :  foregroundColor,
                NSBackgroundColorAttributeName : backgroundColor,
                NSStrikethroughStyleAttributeName : ("\(underlineStyle)")
        ]
    }
}
