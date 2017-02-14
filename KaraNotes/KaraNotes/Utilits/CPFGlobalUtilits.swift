//
//  CPFGlobalUtilits.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/14.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

// MARK: - 全局函数（宏定义）
public func CPFRGBA(r:Float, g:Float, b:Float, a:Float) -> UIColor { return UIColor(colorLiteralRed: r/255.0, green: g/255.0, blue: b/255.0, alpha: a) }

public func CPFRGB(r:Float, g:Float, b:Float) -> UIColor { return CPFRGBA(r: r, g: g, b: b, a: 1.0) }


// MARK: - 全局常量
public let CPFGlobalColor = CPFRGB(r: 245, g: 245, b: 245)
