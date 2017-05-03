//
//  CPFSearchController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/24.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit
import Alamofire

class CPFSearchController: BaseViewController {
    
    fileprivate var searchBar:UISearchBar!
    fileprivate var articleModels: [CPFSearchArticleModel] = []
    fileprivate var userModels: [CPFSearchUserModel] = []
    fileprivate var tableView:UITableView!
    
    fileprivate let SearchUserCellID: String = "searchUserCell"
    fileprivate let SearchArticleCellID: String = "searchArticleCell"
    
    fileprivate let modalTransitioningDelegate = CPFModalTransitioningDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
}


// MARK: - UISearchBarDelegate
extension CPFSearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.hasSuffix("\n") { return }
        searchBarSearchButtonClicked(searchBar)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let params = ["token_id":getUserInfoForKey(key: CPFUserToken),
                      "keywords":searchBar.text!,
                      "pagenum":"0",
                      "pagesize":"3"]
        
        Alamofire.request(CPFNetworkRoute.getAPIFromRouteType(route: .searchUser), method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            switch response.result {
            case .success(let json as JSONDictionary):
                guard let result = json["result"] as? JSONDictionary else { fatalError("解析 search 用户列表失败")}
                guard let userlist = result["userlist"] as? [JSONDictionary] else { fatalError("解析 search 用户列表失败")}
                
                self.userModels = userlist.map({ (json) -> CPFSearchUserModel in
                    return CPFSearchUserModel.parse(json: json)
                })
                
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            default:
                print("Unkonw error when search user list")
            }
        }
        
        
        let articleParams = ["pagenum": "0",
                             "pagesize": "3",
                             "keywords": searchBar.text!]
        Alamofire.request(CPFNetworkRoute.getAPIFromRouteType(route: .searchArticle), method: .post, parameters: articleParams, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            switch response.result {
            case .success(let json as JSONDictionary):
                guard let code = json["code"] as? String else { fatalError("解析 search 文章列表失败")}
                if code != "1" { return }
                guard let result = json["result"] as? [JSONDictionary] else { fatalError("解析 search 文章列表失败")}
                self.articleModels = result.map({ (json) -> CPFSearchArticleModel in
                    return CPFSearchArticleModel.parse(json: json)
                })
                
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            default:
                print("Unkonw error when search article list")
            }
        }
    }
}

// MARK: - setup subviews
extension CPFSearchController {
    func setupSubviews() -> Void {
        
        setupNavSearchBar()
        setupTableView()
    }
    
    func setupNavSearchBar() -> Void {
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: CPFScreenW, height: 30)
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.setBackgroundImage(UIImage.init(), for: .any, barMetrics: .default)
        searchBar.setImage(UIImage.init(named: "search")?.scaleToSize(newSize: CGSize(width: 15, height: 15)), for: .search, state: .normal)
        searchBar.backgroundColor = UIColor.clear
        searchBar.placeholder = CPFLocalizableTitle("attention_search_placeholder")
        searchBar.tintColor = UIColor.white
        let textFiled:UITextField = searchBar.value(forKeyPath: "_searchField") as! UITextField
        textFiled.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        textFiled.backgroundColor = CPFRGBA(r: 0, g: 0, b: 0, a: 0.4)
        textFiled.textColor = UIColor.white
        titleView.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        navigationItem.titleView = titleView
    }
    
    func setupTableView() -> Void {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.register(CPFSearchUserCell.self, forCellReuseIdentifier: SearchUserCellID)
        tableView.register(CPFSearchArticleCell.self, forCellReuseIdentifier: SearchArticleCellID)
        tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
}


extension CPFSearchController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? userModels.count : articleModels.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 && userModels.count > 0 { return CPFLocalizableTitle("user") }
        
        if section == 1 && articleModels.count > 0 { return CPFLocalizableTitle("article") }
        
        tableView.contentInset = (userModels.count == 0 && articleModels.count > 0) ? UIEdgeInsets(top: -60, left: 0, bottom: 0, right: 0) : UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        
        return ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = indexPath.section == 0 ? tableView.dequeueReusableCell(withIdentifier: SearchUserCellID) as! CPFSearchUserCell : tableView.dequeueReusableCell(withIdentifier: SearchArticleCellID) as! CPFSearchArticleCell
        switch indexPath.section {
        case 0:
            (cell as! CPFSearchUserCell).userModel = userModels[indexPath.row]
        default:
            (cell as! CPFSearchArticleCell).searchArticleModel = articleModels[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = tableView.cellForRow(at: indexPath)
        // 相对 keyWindow 的位置
        let keyWindow = UIApplication.shared.keyWindow
        let currentCellItemRectInSuperView = currentCell?.superview?.convert((currentCell?.frame)!, to: keyWindow)
        modalTransitioningDelegate.startRect = CGRect(x: 0.0, y: (currentCellItemRectInSuperView?.origin.y)!, width: CPFScreenW, height: 85.0)
        
        switch indexPath.section {
        case 0:
            print("用户列表")
        default:
            // 文章列表
            let articleModel = articleModels[indexPath.row]
            let browseArticleCtr = CPFBrowseArticleController()
            browseArticleCtr.isMyArticle = false
            browseArticleCtr.thumbImage = (currentCell as! CPFSearchArticleCell).thumbImage
            browseArticleCtr.articleID = articleModel.article_id
            browseArticleCtr.articleTitle = articleModel.article_title
            browseArticleCtr.articleCreateTime = articleModel.article_create_formatTime
            browseArticleCtr.articleAuthorName = articleModel.user_name
            browseArticleCtr.transitioningDelegate = modalTransitioningDelegate
            browseArticleCtr.modalPresentationStyle = .custom
            present(browseArticleCtr, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }
}
