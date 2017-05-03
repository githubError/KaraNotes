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
            
            collectionView.contentInset = UIEdgeInsets(top: -flowLayout.headerReferenceSize.height, left: 0, bottom: -flowLayout.headerReferenceSize.height, right: 0)
            
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
//        let requestURL = "\(CPFNetworkRoute.getAPIFromRouteType(route: .myArticleWithoutCategory))/\(getUserInfoForKey(key: CPFUserPath))/\(0)/\(10)"
//        
//        print("request:\(requestURL)")
//        
//        Alamofire.request(requestURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
//            switch response.result {
//            case .success(let json as JSONDictionary):
//                guard let code = json["code"] as? String else {fatalError()}
//                if code == "1" {
//                    print("========\(json)")
//                    guard let results = json["result"] as? [JSONDictionary] else {fatalError("Json 解析失败")}
//                    
//                } else {
//                    print("--解析错误--")
//                }
//            case .failure(let error):
//                print("--------\(error.localizedDescription)")
//            default:
//                print("unknow type error")
//            }
//            
//        }
        self.collectionView?.mj_header.endRefreshing()
    }
    
    func loadMoreDatas() -> Void {
        print("上拉加载更多")
        collectionView?.mj_footer.endRefreshingWithNoMoreData()
    }
}

extension CPFAttentionController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let attentionCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CPFAttentionCell
        
        attentionCell.attentionArticleModel = AttentionArticleModel()
        
        return attentionCell
    }
    
    // delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 相对 keyWindow 的位置
        let currentCellItem = collectionView.cellForItem(at: indexPath)
        let keyWindow = UIApplication.shared.keyWindow
        let currentCellItemRectInSuperView = currentCellItem?.superview?.convert((currentCellItem?.frame)!, to: keyWindow)
        
        modalTransitioningDelegate.startRect = CGRect(x: 0.0, y: (currentCellItemRectInSuperView?.origin.y)!, width: CPFScreenW, height: (currentCellItem?.height)!)
        
        let browseArticleVC = CPFBrowseArticleController()
        browseArticleVC.isMyArticle = false
        browseArticleVC.transitioningDelegate = modalTransitioningDelegate
        browseArticleVC.modalPresentationStyle = .custom
        present(browseArticleVC, animated: true, completion: nil)
    }
}
