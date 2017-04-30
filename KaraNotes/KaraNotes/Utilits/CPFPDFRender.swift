//
//  CPFPDFRender.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/16.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFPDFRender: UIPrintPageRenderer {
    
    var paperWidth:CGFloat = 500.0
    var paperHeight:CGFloat = 800.0
    var paperMargin:CGFloat = 20.0
    
    var headerText:String = "By KaraNotes"
    
    override var paperRect: CGRect {
        return CGRect(x: 0, y: 0, width: paperWidth, height: paperHeight)
    }
    
    override var printableRect: CGRect {
        return CGRect(x: paperMargin, y: paperMargin, width: paperWidth - 2 * paperMargin, height: paperHeight - 2 * paperMargin)
    }
    
    func renderPDFFromHtmlString(htmlString: String) -> NSMutableData {
        let formatter = UIMarkupTextPrintFormatter(markupText: htmlString)
        addPrintFormatter(formatter, startingAtPageAt: 0)
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect.zero, nil)
        for i in 0..<numberOfPages {
            UIGraphicsBeginPDFPage()
            drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
        UIGraphicsEndPDFContext()
        return pdfData
    }
    
    func renderPDFFromUIView(view: UIView) -> NSMutableData {
        let viewFormatter = view.viewPrintFormatter()
        addPrintFormatter(viewFormatter, startingAtPageAt: 0)
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect.zero, nil)
        for i in 0..<numberOfPages {
            UIGraphicsBeginPDFPage()
            drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
        UIGraphicsEndPDFContext()
        return pdfData
    }
    
    override func drawHeaderForPage(at pageIndex: Int, in headerRect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.setLineWidth(2.0)
        context?.setStrokeColor(UIColor.lightGray.cgColor)
        context?.setAllowsAntialiasing(true)
        
        context?.move(to: CGPoint(x: paperMargin, y: paperMargin + 15))
        context?.addLine(to: CGPoint(x: paperWidth - 2 * paperMargin, y: paperMargin + 15))
        context?.setLineDash(phase: 0.0, lengths: [3.0, 1.0])
        context?.drawPath(using: .eoFillStroke)
        
        let font = UIFont(name: "Didot-Italic", size: 18.0)
        let attributes: [String : Any] = [NSFontAttributeName:font!,
                          NSForegroundColorAttributeName:CPFRGB(r: 16, g: 48, b: 48)]
        let size = (headerText as NSString).size(attributes: attributes)
        (headerText as NSString).draw(in: CGRect(x: paperRect.size.width - size.width, y: headerRect.origin.y - size.height / 2.0, width: size.width, height: size.height), withAttributes: attributes)
    }
    
    override func drawFooterForPage(at pageIndex: Int, in footerRect: CGRect) {
        let font = UIFont(name: "HelveticaNeue", size: 18.0)
        let attributes: [String : Any] = [NSFontAttributeName:font!,
                                          NSForegroundColorAttributeName:CPFRGB(r: 16, g: 48, b: 48)]
        let footerText = "\(pageIndex + 1)"
        let size = (footerText as NSString).size(attributes: attributes)
        (footerText as NSString).draw(in: CGRect(x: paperWidth/2 - size.width / 2, y: footerRect.origin.y + 15 - size.height / 2, width: size.width, height: size.height), withAttributes: attributes)
    }
}
