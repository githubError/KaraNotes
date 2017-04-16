//
//  CPFTabBar.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/15.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFTabBar: UITabBar {
    
    var writeArticleButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupWriteArticleButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupWriteArticleButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.frame.width
        let height = self.frame.height
        
        writeArticleButton.center = CGPoint(x: width * 0.5, y: height * 0.5)
        
        let buttonW = width / 5
        let buttonH = height
        
        var index: Int = 0
        
        for view in subviews {
            if !view.isKind(of: UIControl.self) || view == writeArticleButton {
                continue
            }
            
            let buttonX = buttonW * CGFloat(((index > 1) ? (index + 1) : index))
            
            view.frame = CGRect(x: buttonX, y: 0, width: buttonW, height: buttonH)
            
            index += 1
        }
        
        
    }
}


extension CPFTabBar {
    
    func setupWriteArticleButton() -> Void {
        writeArticleButton = UIButton(type: .custom)
        
        writeArticleButton.setBackgroundImage(UIImage.init(named: "tabbar_writearticle")?.scaleToSize(newSize: CGSize(width: 40, height: 40)), for: .normal)
        writeArticleButton.addTarget(self, action: #selector(writeArticle), for: .touchUpInside)
        
        writeArticleButton.size = (writeArticleButton.currentBackgroundImage?.size)!
        
        addSubview(writeArticleButton)
    }
    
    func writeArticle() -> Void {
        let writeArticleController = CPFWriteArticleController()
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        rootViewController?.present(writeArticleController, animated: true, completion: nil)
    }
}
