//
//  CPFShareTools.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/17.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFShareTools: NSObject {

    static let instance:CPFShareTools = CPFShareTools()
    
    static func sharedInstance() -> CPFShareTools {
        return instance
    }
}


extension CPFShareTools {
    
    func saveAsHTMLFromHtmlString(htmlString: String, useName name: String, completionHandler: @escaping (_ toPath: String) -> Void) -> Void {
        let htmlData = htmlString.data(using: .utf8)
        let documentPath = CPFFileManager.shareInstance().createLocalWorkspace()
        let urlString = (documentPath as NSString).appendingPathComponent("\(name)_\(createTimestamp()).html")
        
        if CPFFileManager.shareInstance().saveFileToPath(filePath: urlString, withContent: htmlData! as NSData) {
            completionHandler(urlString)
        } else {
            completionHandler("")
        }
    }
    
    func saveAsMarkdownFromMarkdownString(markdownString: String, useName name: String, completionHandler: @escaping (_ toPath: String) -> Void) -> Void {
        let markdownData = markdownString.data(using: .utf8)
        let documentPath = CPFFileManager.shareInstance().createLocalWorkspace()
        let urlString = (documentPath as NSString).appendingPathComponent("\(name)_\(createTimestamp()).md")
        
        if CPFFileManager.shareInstance().saveFileToPath(filePath: urlString, withContent: markdownData! as NSData) {
            completionHandler(urlString)
        } else {
            completionHandler("")
        }
    }
    
    func saveAsPDFFromUIView(view: UIView, useName name: String, completionHandler: @escaping (_ toPath: String) -> Void) -> Void {
        let pdfRender = CPFPDFRender()
        let pdfData = pdfRender.renderPDFFromUIView(view: view)
        
        let documentPath = CPFFileManager.shareInstance().createLocalWorkspace()
        let urlString = (documentPath as NSString).appendingPathComponent("\(name)_\(createTimestamp()).pdf")
        if CPFFileManager.shareInstance().saveFileToPath(filePath: urlString, withContent: pdfData) {
            completionHandler(urlString)
        } else {
            completionHandler("")
        }
    }
    
    func exportFile(filePath: String, completionHandler: @escaping (_ viewController: UIViewController) -> Void) -> Void {
        let url = URL(fileURLWithPath: filePath)
        let objectsToShare = [url]
        let controller = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        let excludedActivities:[UIActivityType] = [UIActivityType.postToTwitter, UIActivityType.postToTwitter,UIActivityType.postToVimeo,UIActivityType.postToWeibo,UIActivityType.postToFlickr,UIActivityType.postToTencentWeibo,UIActivityType.saveToCameraRoll,UIActivityType.assignToContact]
        controller.excludedActivityTypes = excludedActivities
        
        completionHandler(controller)
    }
    
    
    // MARK: - Markdown 转 HTML
    func HTMLFormatStringFromMarkdownString(markdownString:String) -> String {
        
        let htmlString = HTMLFromMarkdown(markdownString, hoedown_extensions(rawValue: 15), true, "", CreateHTMLRenderer(), CreateHTMLTOCRenderer())!
        
        let htmlFormatStringPath = Bundle.main.path(forResource: "format", ofType: "html")
        var htmlFormatString = try! String(contentsOfFile: htmlFormatStringPath!, encoding: String.Encoding.utf8)
        
        let htmlStyleStringPath = Bundle.main.path(forResource: "GitHub", ofType: "css")
        let htmlStyleString = try! String(contentsOfFile: htmlStyleStringPath!, encoding: String.Encoding.utf8)
        
        htmlFormatString = htmlFormatString.replacingOccurrences(of: "#_html_place_holder_#", with: htmlString)
        htmlFormatString = htmlFormatString.replacingOccurrences(of: "#_style_place_holder_#", with: htmlStyleString)
        
        return htmlFormatString
    }
}
