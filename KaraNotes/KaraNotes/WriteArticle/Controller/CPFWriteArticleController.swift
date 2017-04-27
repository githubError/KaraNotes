//
//  CPFWriteArticleController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/15.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit
import Alamofire

class CPFWriteArticleController: BaseViewController {
    
    var headerView:CPFWriteArticleHeaderView!
    var editView:CPFEditView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let previewCtr = CPFPreviewController()
        previewCtr.markdownString = editView.text
        previewCtr.articleTitle = editView.titleTextField.text!
        present(previewCtr, animated: true, completion: nil)
    }
    
    
    func headerView(headerView: UIView, didClickPostArticleBtn postArticleBtn: UIButton) {
        print("发表")
        postArticle { (result, articleID) in
            if result == "1" {
                print("发表成功")
                CPFProgressView.sharedInstance().showProgressView(progress: 1.0, promptMessage: "发表成功")
                self.dismiss(animated: true, completion: { 
                    CPFProgressView.sharedInstance().dismissProgressView {}
                })
            } else {
                CPFProgressView.sharedInstance().showProgressView(progress: 1.0, promptMessage: "发表失败")
                CPFProgressView.sharedInstance().dismissProgressView {}
                print("发表失败")
            }
        }
    }
}

extension CPFWriteArticleController {
    
    func postArticle(completionHandler: @escaping (_ result: String, _ article_id: String) -> Void ) -> Void {
        
        let params: [String : Any] = ["token_id":CPFUserManager.sharedInstance().userToken(),
                      "article_title":editView.titleTextField.text!,
                      "classify_id": "分类测试",
                      "article_show_img": editView.firstImageLinkString,
                      "article_content" : editView.text,
                      "tag_content" : "[\"测试标签1\", \"测试标签2\"]"]
        
        Alamofire.request(CPFNetworkRoute.getAPIFromRouteType(route: .insertArticle), method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON { response in
            
            switch response.result {
            case .success(let json as JSONDictionary):
                guard let code = json["code"] as? String else {fatalError()}
                
                if code == "1" {
                    guard let result = json["result"] as? JSONDictionary else {fatalError()}
                    completionHandler(code, "\(result)")
                } else {
                    guard let message = json["message"] as? String else {fatalError()}
                    if message == "3" {
                        completionHandler(code, message)
                    } else {
                        completionHandler(code, message)
                    }
                }
            case .failure(let error as JSONDictionary):
                guard let error = error["error"] as? Int else {fatalError()}
                print("----\(error)")
            default:break
            }
        }
    }
}

// MARK: - CPFEditViewDelegate
extension CPFWriteArticleController: CPFEditViewDelegate {
    func editView(editView: CPFEditView, didChangeText text: String) {
        headerView.characterCountLabel.text = "\(text.characters.count) \(CPFLocalizableTitle("writeArticle_character"))"
    }
}
