//
//  CPFWriteArticleController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/15.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

import Social

class CPFWriteArticleController: BaseViewController {
    
    var headerView:CPFWriteArticleHeaderView!
    var editView:CPFEditView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.purple
        
        setupSubviews()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}

// MARK: - setup subviews
extension CPFWriteArticleController {
    
    func setupSubviews() -> Void {
        setupHeaderView()
        setupEditView()
    }
    
    func setupHeaderView() -> Void {
        headerView = CPFWriteArticleHeaderView(frame: CGRect(x: 0, y: 0, width: CPFScreenW, height: 64))
        headerView.delegate = self
        view.addSubview(headerView)
    }
    
    func setupEditView() -> Void {
        editView = CPFEditView()
        view.addSubview(editView)
        editView.editViewDelegate = self
        editView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - CPFWriteArticleHeaderViewDelegate
extension CPFWriteArticleController: CPFWriteArticleHeaderViewDelegate {
    
    func headerView(headerView: UIView, didClickDismissBtn dismissBtn: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func headerView(headerView: UIView, didClickPreviewBtn previewBtn: UIButton) {
        print("预览")
        let htmlString = HTMLFromMarkdown(editView.text, hoedown_extensions(rawValue: 15), true, "", CreateHTMLRenderer(), CreateHTMLTOCRenderer())!
        
        let htmlFormatStringPath = Bundle.main.path(forResource: "format", ofType: "html")
        var htmlFormatString = try! String(contentsOfFile: htmlFormatStringPath!, encoding: String.Encoding.utf8)
        
        let htmlStyleStringPath = Bundle.main.path(forResource: "Clearness", ofType: "css")
        let htmlStyleString = try! String(contentsOfFile: htmlStyleStringPath!, encoding: String.Encoding.utf8)
        
        htmlFormatString = htmlFormatString.replacingOccurrences(of: "#_html_place_holder_#", with: htmlString)
        htmlFormatString = htmlFormatString.replacingOccurrences(of: "#_style_place_holder_#", with: htmlStyleString)
        
        print("=========\(String(describing: htmlFormatString))")
        
        let previewCtr = CPFPreviewController()
        present(previewCtr, animated: true, completion: nil)
    }
    
    
    func headerView(headerView: UIView, didClickPostArticleBtn postArticleBtn: UIButton) {
        print("发表")
        let ctr = SLComposeViewController(forServiceType: "com.tencent.xin.sharetimeline")
//        ctr?.setInitialText("初始化字符串")
        present(ctr!, animated: true, completion: nil)
        
    }
}

// MARK: - CPFEditViewDelegate
extension CPFWriteArticleController: CPFEditViewDelegate {
    func editView(editView: CPFEditView, didChangeText text: String) {
        headerView.characterCountLabel.text = "\(text.characters.count) \(CPFLocalizableTitle("writeArticle_character"))"
    }
}
