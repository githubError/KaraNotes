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
}
