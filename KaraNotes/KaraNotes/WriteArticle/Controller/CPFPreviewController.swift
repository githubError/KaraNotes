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
        htmlFormatString = CPFShareTools.sharedInstance().HTMLFormatStringFromMarkdownString(markdownString: markdownString)
        webView.loadHTMLString(htmlFormatString, baseURL: nil)
    }
}

extension CPFPreviewController: CPFPreviewHeaderViewDelegate {
    
    func headerView(headerView: UIView, didClickDismissBtn dismissBtn: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func headerView(headerView: UIView, didClickExportBtn dismissBtn: UIButton) {
        print("导出")
        
        let alertCtr = UIAlertController(title: CPFLocalizableTitle("previewArticle_export_as"), message: nil, preferredStyle: .actionSheet)
        
        let PDFAction = UIAlertAction(title: "PDF", style: .default) { (alertAction) in
            CPFShareTools.sharedInstance().saveAsPDFFromUIView(view: self.webView, useName: self.articleTitle!) { (toPath) in
                CPFShareTools.sharedInstance().exportFile(filePath: toPath, completionHandler: { controller in
                    self.present(controller, animated: true, completion: nil)
                    print("toPath:\(toPath)")
                })
            }
        }
        
        let HTMLAction = UIAlertAction(title: "HTML", style: .default) { (alertAction) in
            CPFShareTools.sharedInstance().saveAsHTMLFromHtmlString(htmlString: self.htmlFormatString, useName: self.articleTitle) { (toPath) in
                CPFShareTools.sharedInstance().exportFile(filePath: toPath, completionHandler: { controller in
                    self.present(controller, animated: true, completion: nil)
                    print("toPath:\(toPath)")
                })
            }
        }
        
        let MarkdownAction = UIAlertAction(title: "Markdown", style: .default) { (alertAction) in
            CPFShareTools.sharedInstance().saveAsMarkdownFromMarkdownString(markdownString: self.markdownString, useName: self.articleTitle, completionHandler: { (toPath) in
                CPFShareTools.sharedInstance().exportFile(filePath: toPath, completionHandler: { controller in
                    self.present(controller, animated: true, completion: nil)
                    print("toPath:\(toPath)")
                })
            })
        }
        
        let cancelAction = UIAlertAction(title: CPFLocalizableTitle("previewArticle_export_alert_cancel"), style: .cancel) { (alertAction) in
            alertCtr.dismiss(animated: true, completion: nil)
        }
        
        alertCtr.addAction(PDFAction)
        alertCtr.addAction(HTMLAction)
        alertCtr.addAction(MarkdownAction)
        alertCtr.addAction(cancelAction)
        
        present(alertCtr, animated: true, completion: nil)
    }
}
