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
    
    var collectionView: UICollectionView?
    let flowLayout = UICollectionViewFlowLayout()
    
    let cellID = "AttentionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init collectionView
        setupCollectionView()
        
    }
}

class CPFCollectionHeaderView: UICollectionReusableView {
    
}

// MARK: - setup
extension CPFAttentionController {
    
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


// MARK: - Refresh
extension CPFAttentionController {
    func loadNewDatas() -> Void {
        print("下拉加载更多")
        collectionView?.mj_header.endRefreshing()
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
        print("点击了：\(indexPath.row)行")
        
    }
}
