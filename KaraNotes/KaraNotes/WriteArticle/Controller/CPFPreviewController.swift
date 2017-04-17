//
//  CPFPreviewController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/16.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFPreviewController: BaseViewController {
    
    var markdownString: String!
    var articleTitle: String!
    
    fileprivate var htmlFormatString: String!
    fileprivate var webView: UIWebView!
    
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
        webView = UIWebView(frame: CGRect(x: 0, y: 64, width: CPFScreenW, height: CPFScreenH - 64))
        view.addSubview(webView)
        htmlFormatString = HTMLFormatStringFromMarkdownString(markdownString: markdownString)
        webView.loadHTMLString(htmlFormatString, baseURL: nil)
    }
}

extension CPFPreviewController: CPFPreviewHeaderViewDelegate {
    
    func headerView(headerView: UIView, didClickDismissBtn dismissBtn: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func headerView(headerView: UIView, didClickExportBtn dismissBtn: UIButton) {
        print("导出")
        
        CPFShareTools.sharedInstance().saveAsPDFFromUIView(view: webView, useName: articleTitle!) { (toPath) in
            CPFShareTools.sharedInstance().exportFile(filePath: toPath, completionHandler: { controller in
                self.present(controller, animated: true, completion: nil)
                print("toPath:\(toPath)")
            })
        }
        
//        CPFShareTools.sharedInstance().saveAsHTMLFromHtmlString(htmlString: htmlFormatString, useName: articleTitle) { (toPath) in
//            CPFShareTools.sharedInstance().exportFile(filePath: toPath, completionHandler: { controller in
//                self.present(controller, animated: true, completion: nil)
//                print("toPath:\(toPath)")
//            })
//        }
        
    }
}
