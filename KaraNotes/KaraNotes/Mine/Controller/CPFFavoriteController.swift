//
//  CPFFavoriteController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/3/7.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFFavoriteController: BaseViewController {
    
    var collectionView: UICollectionView?
    let flowLayout = UICollectionViewFlowLayout()
    var deledate:CPFFavoriteControllerDelegate!
    let cellID = "AttentionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init collectionView
        setupCollectionView()
    }
}

// MARK: - setup
extension CPFFavoriteController {
    
    func setupCollectionView() -> Void {
        
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: self.view.width, height: 250*CPFFitHeight)
        flowLayout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        
        
        if let collectionView = collectionView {
            view.addSubview(collectionView)
            collectionView.frame = CGRect(x: 0, y: 0, width: CPFScreenW, height: CPFScreenH - 150)
            collectionView.backgroundColor = CPFGlobalColor
            collectionView.register(CPFAttentionCell.self, forCellWithReuseIdentifier: cellID)
            
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
}


extension CPFFavoriteController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    
    // 上拉加载更多
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let collectionViewHeight = (collectionView?.contentSize.height)! + (collectionView?.contentInset.bottom)! - (collectionView?.height)!
        let offsetY = (collectionView?.contentOffset.y)!
        
        if offsetY < 20.0 {
            deledate.favoriteControllerScrollToShowTop(favoriteController: self)
        } else if offsetY > 60.0 {
            deledate.favoriteControllerScrollToShowBottom(favoriteController: self)
        }
        
        if collectionViewHeight <  (offsetY - flowLayout.footerReferenceSize.height){
            print("scrollView----上拉加载更多")
        }
    }
}



protocol CPFFavoriteControllerDelegate {
    
    func favoriteControllerScrollToShowBottom(favoriteController:CPFFavoriteController) -> Void
    
    func favoriteControllerScrollToShowTop(favoriteController:CPFFavoriteController) -> Void
}
