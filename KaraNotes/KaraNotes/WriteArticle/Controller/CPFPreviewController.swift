//
//  CPFPreviewController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/16.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFPreviewController: BaseViewController {
    
    var markdownString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
}

extension CPFPreviewController {
    
    fileprivate func setupSubviews() -> Void {
        view.backgroundColor = CPFRandomColor
        setupHeaderView()
        setupWebView()
    }
    
    fileprivate func setupHeaderView() -> Void {
        let headerView = CPFPreviewHeaderView(frame: CGRect(x: 0, y: 0, width: CPFScreenW, height: 64))
        headerView.delegate = self
        view.addSubview(headerView)
    }
    
    fileprivate func setupWebView() -> Void {
        let webView = UIWebView(frame: CGRect(x: 0, y: 64, width: CPFScreenW, height: CPFScreenH - 64))
        view.addSubview(webView)
        let htmlFormatString = HTMLFormatStringFromMarkdownString(markdownString: markdownString)
        webView.loadHTMLString(htmlFormatString, baseURL: nil)
    }
    
    fileprivate func HTMLFormatStringFromMarkdownString(markdownString:String) -> String {
        
        let htmlString = HTMLFromMarkdown(markdownString, hoedown_extensions(rawValue: 15), true, "", CreateHTMLRenderer(), CreateHTMLTOCRenderer())!
        
        let htmlFormatStringPath = Bundle.main.path(forResource: "format", ofType: "html")
        var htmlFormatString = try! String(contentsOfFile: htmlFormatStringPath!, encoding: String.Encoding.utf8)
        
        let htmlStyleStringPath = Bundle.main.path(forResource: "Clearness", ofType: "css")
        let htmlStyleString = try! String(contentsOfFile: htmlStyleStringPath!, encoding: String.Encoding.utf8)
        
        htmlFormatString = htmlFormatString.replacingOccurrences(of: "#_html_place_holder_#", with: htmlString)
        htmlFormatString = htmlFormatString.replacingOccurrences(of: "#_style_place_holder_#", with: htmlStyleString)
        
        return htmlFormatString
    }
}

extension CPFPreviewController: CPFPreviewHeaderViewDelegate {
    
    func headerView(headerView: UIView, didClickDismissBtn dismissBtn: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func headerView(headerView: UIView, didClickExportBtn dismissBtn: UIButton) {
        print("导出")
    }
}
