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
        
        let previewCtr = CPFPreviewController()
        previewCtr.markdownString = editView.text
        previewCtr.articleTitle = editView.titleTextField.text!
        present(previewCtr, animated: true, completion: nil)
    }
    
    
    func headerView(headerView: UIView, didClickPostArticleBtn postArticleBtn: UIButton) {
        print("发表")
        postArticle { (result, articleID) in
            print("=======\(result)===\(articleID)")
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
                guard let result = json["success"] as? String else {fatalError()}
                
                if result == "1" {
                    guard let article_id = json["article_id"] as? String else {fatalError()}
                    completionHandler(result, article_id)
                } else {
                    guard let errorCode = json["messcode"] as? String else {fatalError()}
                    if errorCode == "3" {
                        completionHandler(result, String(errorCode))
                    } else {
                        completionHandler(result, String(errorCode))
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
