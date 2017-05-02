//
//  CPFMyArticleController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/15.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit
import Alamofire

class CPFMyArticleController: BaseViewController {
    
    fileprivate var models:[CPFMyArticleModel] = []
    
    fileprivate var tableView: UITableView!
    
    fileprivate var currentPage: Int = 0
    
    fileprivate let CellID: String = "MyArticleCell"
    
    fileprivate let modalTransitioningDelegate = CPFModalTransitioningDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }

}

extension CPFMyArticleController {
    
    func setupSubviews() -> Void {
        setupTableView()
    }
    
    func setupTableView() -> Void {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(CPFMyArticleCell.self, forCellReuseIdentifier: CellID)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 65, right: 0)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        let refreshHeader = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNewDatas))
        tableView.mj_header = refreshHeader
        tableView.mj_header.beginRefreshing()
        tableView.mj_header.isAutomaticallyChangeAlpha = true
        
        let refreshFooter = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreDatas))
        refreshFooter?.setTitle("没有更多啦", for: .noMoreData)
        tableView.mj_footer = refreshFooter
        tableView.mj_footer.isAutomaticallyChangeAlpha = true
        
        view.addSubview(tableView)
    }
}


// MARK: - refresh
extension CPFMyArticleController {
    
    func loadNewDatas() -> Void {
        print("下拉加载更多")
        
        currentPage = 0
        let requestURL = "\(CPFNetworkRoute.getAPIFromRouteType(route: .myArticleWithoutCategory))/\(getUserInfoForKey(key: CPFUserPath))/\(currentPage)/\(10)"
        
        Alamofire.request(requestURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            switch response.result {
            case .success(let json as JSONDictionary):
                
                guard let code = json["code"] as? String else {fatalError()}
                if code == "1" {
                    
                    guard let results = json["result"] as? [JSONDictionary] else {fatalError("Json 解析失败")}
                    
                    self.models.removeAll()
                    
                    self.models = results.map({ (json) -> CPFMyArticleModel in
                        return CPFMyArticleModel.parse(json: json)
                    })
                    
                    self.tableView?.mj_header.endRefreshing()
                    self.tableView.reloadData()
                    
                } else {
                    print("--解析错误--")
                }
            case .failure(let error):
                print("--------\(error.localizedDescription)")
                self.tableView?.mj_header.endRefreshing()
            default:
                print("unknow type error")
                self.tableView?.mj_header.endRefreshing()
            }
        }
    }
    
    func loadMoreDatas() -> Void {
        
        currentPage += 1
        let requestURL = "\(CPFNetworkRoute.getAPIFromRouteType(route: .myArticleWithoutCategory))/\(getUserInfoForKey(key: CPFUserPath))/\(currentPage)/\(10)"
        
        Alamofire.request(requestURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            switch response.result {
            case .success(let json as JSONDictionary):
                
                guard let code = json["code"] as? String else {fatalError()}
                if code == "1" {
                    
                    guard let results = json["result"] as? [JSONDictionary] else {fatalError("Json 解析失败")}
                    
                    if results.count == 0 {
                        self.currentPage -= 1
                        self.tableView?.mj_footer.endRefreshing()
                        return
                    }
                    
                    let models = results.map({ (json) -> CPFMyArticleModel in
                        return CPFMyArticleModel.parse(json: json)
                    })
                    self.models.append(contentsOf: models)
                    self.tableView?.mj_footer.endRefreshing()
                    self.tableView.reloadData()
                    
                } else {
                    print("--解析错误--")
                    self.currentPage -= 1
                    self.tableView?.mj_footer.endRefreshing()
                }
            case .failure(let error):
                print("--------\(error.localizedDescription)")
                self.currentPage -= 1
                self.tableView?.mj_footer.endRefreshingWithNoMoreData()
            default:
                print("unknow type error")
                self.currentPage -= 1
                self.tableView?.mj_footer.endRefreshingWithNoMoreData()
            }
        }
    }
}


extension CPFMyArticleController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID) as! CPFMyArticleCell
        cell.selectionStyle = .none
        
        cell.myArticleModel = models[indexPath.row] as CPFMyArticleModel
        
        cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.white : CPFRGB(r: 240, g: 240, b: 240)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击:\(indexPath.row)")
        
        // 相对 keyWindow 的位置
        let currentCellItem = tableView.cellForRow(at: indexPath) as! CPFMyArticleCell
        let keyWindow = UIApplication.shared.keyWindow
        let currentCellItemRectInSuperView = currentCellItem.superview?.convert((currentCellItem.frame), to: keyWindow)
        
        modalTransitioningDelegate.startRect = CGRect(x: 0.0, y: (currentCellItemRectInSuperView?.origin.y)!, width: CPFScreenW, height: 80.0)
        
        let browseArticleVC = CPFBrowseArticleController()
        browseArticleVC.thumbImage = currentCellItem.thumbImage
        browseArticleVC.articleTitle = currentCellItem.titleLabel.text
        browseArticleVC.articleCreateTime = currentCellItem.createTimeLabel.text
        browseArticleVC.articleAuthorName = getUserInfoForKey(key: CPFUserName)
        browseArticleVC.articleID = currentCellItem.myArticleModel.article_id
        browseArticleVC.isMyArticle = true
        browseArticleVC.transitioningDelegate = modalTransitioningDelegate
        browseArticleVC.modalPresentationStyle = .custom
        
        present(browseArticleVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return CPFLocalizableTitle("myArticle_delete")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let article: CPFMyArticleModel = models[indexPath.row]
            let params = ["token_id":getUserInfoForKey(key: CPFUserToken),
                          "article_id":article.article_id]
            Alamofire.request(CPFNetworkRoute.getAPIFromRouteType(route: .deleteArticle), method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON(completionHandler: { (response) in
                
                switch response.result {
                case .success(let json as JSONDictionary):
                    guard let code = json["code"] as? String else {fatalError()}
                    if code == "1" {
                        self.models.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .left)
                        tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                default:
                    print("Unkonw error type")
                }
            })
        }
    }
}
