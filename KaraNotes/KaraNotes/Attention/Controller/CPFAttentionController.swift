//
//  CPFAttentionController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/15.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit
import Alamofire

class CPFAttentionController: BaseViewController {
    
    fileprivate var collectionView: UICollectionView?
    fileprivate let flowLayout = UICollectionViewFlowLayout()
    
    fileprivate let modalTransitioningDelegate = CPFModalTransitioningDelegate()
    
    fileprivate let cellID = "AttentionCell"
    
    fileprivate var pageNum:Int = 0
    
    fileprivate var attentionArticleModels: [AttentionArticleModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        
    }
}


// MARK: - setup
extension CPFAttentionController {
    
    func setupSubviews() -> Void {
        
        setupNavigation()
        
        // init collectionView
        setupCollectionView()
    }
    
    func setupNavigation() -> Void {
        
        let searchBtn = UIButton(type: .custom)
        searchBtn.setImage(UIImage.init(named: "search"), for: .normal)
        searchBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        searchBtn.addTarget(self, action: #selector(searchBtnClick), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBtn)
    }
    
    func setupCollectionView() -> Void {
        
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: self.view.width, height: 250*CPFFitHeight)
        flowLayout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        
        
        if let collectionView = collectionView {
            view.addSubview(collectionView)
            collectionView.snp.makeConstraints { make in
                make.top.left.right.bottom.equalTo(view)
            }
            collectionView.backgroundColor = CPFGlobalColor
            collectionView.register(CPFAttentionCell.self, forCellWithReuseIdentifier: cellID)
            
            collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
            
            collectionView.delegate = self
            collectionView.dataSource = self
            
            let refreshHeader = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNewDatas))
            collectionView.mj_header = refreshHeader
            collectionView.mj_header.beginRefreshing()
            collectionView.mj_header.isAutomaticallyChangeAlpha = true
            
            let refreshFooter = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreDatas))
            refreshFooter?.setTitle("没有更多啦", for: .noMoreData)
            collectionView.mj_footer = refreshFooter
            collectionView.mj_footer.isAutomaticallyChangeAlpha = true
        }
    }
}


// MARK: - custom methods
extension CPFAttentionController {
    
    @objc fileprivate func searchBtnClick() -> Void {
        let searchCtr = CPFSearchController()
        navigationController?.pushViewController(searchCtr, animated: true)
    }
}

// MARK: - Refresh
extension CPFAttentionController {
    
    func loadNewDatas() -> Void {
        print("下拉加载更多")
        pageNum = 0
        let params = ["token_id": getUserInfoForKey(key: CPFUserToken),
                      "pagenum": String(pageNum),
                      "pagesize": "10"] as [String : Any]
        
        Alamofire.request(CPFNetworkRoute.getAPIFromRouteType(route: .followArticleList), method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            switch response.result {
            case .success(let json as JSONDictionary):
                guard let code = json["code"] as? String else {fatalError()}
                if code == "1" {
                    guard let results = json["result"] as? [JSONDictionary] else {fatalError("Json 解析失败")}
                    
                    self.attentionArticleModels = results.map({ (json) -> AttentionArticleModel in
                        return AttentionArticleModel.parse(json: json)
                    })
                    
                    self.collectionView?.reloadData()
                } else {
                    print("--解析错误--")
                }
            case .failure(let error):
                print("--------\(error.localizedDescription)")
            default:
                print("unknow type error")
            }
            
        }
        self.collectionView?.mj_header.endRefreshing()
    }
    
    func loadMoreDatas() -> Void {
        
        pageNum += 1
        let params = ["token_id": getUserInfoForKey(key: CPFUserToken),
                      "pagenum": String(pageNum),
                      "pagesize": "10"] as [String : Any]
        
        Alamofire.request(CPFNetworkRoute.getAPIFromRouteType(route: .followArticleList), method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            switch response.result {
            case .success(let json as JSONDictionary):
                guard let code = json["code"] as? String else {fatalError()}
                if code == "1" {
                    guard let results = json["result"] as? [JSONDictionary] else {fatalError("Json 解析失败")}
                    let moreModels = results.map({ (json) -> AttentionArticleModel in
                        return AttentionArticleModel.parse(json: json)
                    })
                    self.attentionArticleModels.append(contentsOf: moreModels)
                    self.collectionView?.reloadData()
                } else {
                    print("--解析错误--")
                }
            case .failure(let error):
                self.pageNum -= 1
                print("--------\(error.localizedDescription)")
            default:
                self.pageNum -= 1
                print("unknow type error")
            }
            
        }
        
        collectionView?.mj_footer.endRefreshingWithNoMoreData()
    }
}

extension CPFAttentionController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attentionArticleModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let attentionCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CPFAttentionCell
        
        attentionCell.attentionArticleModel = attentionArticleModels[indexPath.row]
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: attentionCell)
        }
        
        return attentionCell
    }
    
    // delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let attentModel = attentionArticleModels[indexPath.row]
        
        // 相对 keyWindow 的位置
        let currentCellItem = collectionView.cellForItem(at: indexPath) as! CPFAttentionCell
        let keyWindow = UIApplication.shared.keyWindow
        let currentCellItemRectInSuperView = currentCellItem.superview?.convert(currentCellItem.frame, to: keyWindow)
        
        modalTransitioningDelegate.startRect = CGRect(x: 0.0, y: (currentCellItemRectInSuperView?.origin.y)!, width: CPFScreenW, height: currentCellItem.height)
        
        let browseArticleVC = CPFBrowseArticleController()
        browseArticleVC.thumbImage = currentCellItem.thumbImage
        browseArticleVC.articleTitle = attentModel.article_title
        browseArticleVC.articleCreateTime = attentModel.article_create_formatTime
        browseArticleVC.articleAuthorName = getUserInfoForKey(key: CPFUserName)
        browseArticleVC.articleID = attentModel.article_id
        browseArticleVC.isMyArticle = false
        browseArticleVC.transitioningDelegate = modalTransitioningDelegate
        browseArticleVC.modalPresentationStyle = .custom
        present(browseArticleVC, animated: true, completion: nil)
    }
}


// MARK: - 3D Touch
extension CPFAttentionController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let currentCell = previewingContext.sourceView as! CPFAttentionCell
        let currentIndexPath = collectionView?.indexPath(for: currentCell)
        let attentModel = attentionArticleModels[(currentIndexPath?.row)!]
        
        let keyWindow = UIApplication.shared.keyWindow
        let currentCellItemRectInSuperView = currentCell.superview?.convert(currentCell.frame, to: keyWindow)
        
        modalTransitioningDelegate.startRect = CGRect(x: 0.0, y: (currentCellItemRectInSuperView?.origin.y)!, width: CPFScreenW, height: currentCell.height)
        
        let browseArticleVC = CPFBrowseArticleController()
        browseArticleVC.thumbImage = currentCell.thumbImage
        browseArticleVC.articleTitle = attentModel.article_title
        browseArticleVC.articleCreateTime = attentModel.article_create_formatTime
        browseArticleVC.articleAuthorName = getUserInfoForKey(key: CPFUserName)
        browseArticleVC.articleID = attentModel.article_id
        browseArticleVC.isMyArticle = false
        browseArticleVC.transitioningDelegate = modalTransitioningDelegate
        browseArticleVC.modalPresentationStyle = .custom
        browseArticleVC.is3DTouchPreviewing = true
        
        return browseArticleVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        present(viewControllerToCommit, animated: true, completion: nil)
    }
}
