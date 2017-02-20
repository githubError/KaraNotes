//
//  CPFAttentionController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/15.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

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
                make.top.left.right.bottom.equalToSuperview()
            }
            collectionView.backgroundColor = CPFGlobalColor
            collectionView.register(CPFAttentionCell.self, forCellWithReuseIdentifier: cellID)
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
}

extension CPFAttentionController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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
    
    
}
