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
        
        // setup headerView's,footerView's size & contentInset
        flowLayout.headerReferenceSize = CGSize(width: view.width, height: 40*CPFFitHeight)
        flowLayout.footerReferenceSize = flowLayout.headerReferenceSize
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        
        
        if let collectionView = collectionView {
            view.addSubview(collectionView)
            collectionView.snp.makeConstraints { make in
                make.top.left.right.bottom.equalTo(view)
            }
            collectionView.backgroundColor = CPFGlobalColor
            collectionView.register(CPFAttentionCell.self, forCellWithReuseIdentifier: cellID)
            
            // custom collectionHeaderView
            collectionView.register(CPFCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerViewID")
            
            collectionView.register(CPFCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerViewID")
            
            collectionView.contentInset = UIEdgeInsets(top: -flowLayout.headerReferenceSize.height, left: 0, bottom: -flowLayout.headerReferenceSize.height, right: 0)
            
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
}

extension CPFAttentionController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let attentionCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CPFAttentionCell
        
        attentionCell.attentionArticle = AttentionArticle()
        
        return attentionCell
    }
    
    // delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击了：\(indexPath.row)行")
        
    }
    
    // collectionHeaderView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerViewID", for: indexPath) as UICollectionReusableView
            return headerView
        default:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footerViewID", for: indexPath) as UICollectionReusableView
            return footerView
        }
    }
    
    // 上拉加载更多
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let collectionViewHeight = (collectionView?.contentSize.height)! + (collectionView?.contentInset.bottom)! - (collectionView?.height)!
        let offsetY = (collectionView?.contentOffset.y)!
        
//        print("collectionViewHeight===\(collectionViewHeight)")
//        print("offsetY===\(offsetY)")
        
        if offsetY < 0.0 {
            print("scrollView----上拉加载更多")
        }
        
        if collectionViewHeight <  (offsetY - flowLayout.footerReferenceSize.height){
            print("scrollView----上拉加载更多")
        }
    }
}
