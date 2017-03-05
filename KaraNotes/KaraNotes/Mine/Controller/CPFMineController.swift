//
//  CPFMineController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/15.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFMineController: BaseViewController, UINavigationControllerDelegate {
    var navAlphaView:UIView!
    var user_InfoView:UIView!               // 用户信息
    var user_HeaderImageView:UIImageView!
    var user_NameLabel:UILabel!
    
    var categoryView:UIView!                // 子视图分类
    var contentScrollView:UIScrollView!     // 包裹子控制器的ScrollView
    
    var selectedCategoryBtn:UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
        navigationItem.title = ""
        setupSubViews()
    }
}

// MARK: - setup subviews
extension CPFMineController {
    
    func setupSubViews() -> Void {
        setupUserInfoView()
        setupCategoryView()
        setupContentScrollView()
        setupNavigationBar()
        
        changeNavigationBarAlpha(alpha: 0)
    }
    
    func setupUserInfoView() -> Void {
        user_InfoView = UIView()
        navigationController?.navigationBar.isTranslucent = true
        view.addSubview(user_InfoView)
        user_InfoView.snp.makeConstraints { make in
            make.height.equalTo(250*CPFFitHeight)
            make.top.right.left.equalTo(view)
        }
        
        let user_BgImageView:UIImageView = UIImageView()
        user_BgImageView.image = UIImage.init(named: "user_BgImage")
        user_InfoView.addSubview(user_BgImageView)
        user_BgImageView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(user_InfoView)
        }
        
        user_HeaderImageView = UIImageView()
        user_InfoView.addSubview(user_HeaderImageView)
        user_HeaderImageView.image = UIImage.init(named: "testHeaderImage")
        user_HeaderImageView.snp.makeConstraints { make in
            make.center.equalTo(user_InfoView.snp.center)
            make.width.height.equalTo(80)
        }
        user_HeaderImageView.layer.cornerRadius = 40
        user_HeaderImageView.layer.masksToBounds = true
        
        
        user_NameLabel = UILabel()
        user_InfoView.addSubview(user_NameLabel)
        user_NameLabel.text = "我七岁就很帅"
        user_NameLabel.textAlignment = .center
        user_NameLabel.textColor = UIColor.white
        user_NameLabel.font = CPFPingFangSC(weight: .semibold, size: 24)
        user_NameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(user_InfoView.snp.centerX)
            make.left.equalTo(user_InfoView.snp.left).offset(15)
            make.right.equalTo(user_InfoView.snp.right).offset(-15)
            make.top.equalTo(user_HeaderImageView.snp.bottom).offset(15)
        }
    }
    
    func setupCategoryView() -> Void {
        categoryView = UIView()
        view.addSubview(categoryView)
        categoryView.snp.makeConstraints { make in
            make.left.right.equalTo(user_InfoView)
            make.top.equalTo(user_InfoView.snp.bottom)
            make.height.equalTo(40*CPFFitHeight)
        }
        
        let collectBtn = UIButton(type: .custom)
        collectBtn.setTitle(CPFLocalizableTitle(CPFLocalizableTitle("mine_collectBtn")), for: .normal)
        collectBtn.titleLabel?.textAlignment = .center
        collectBtn.titleLabel?.font = CPFPingFangSC(weight: .regular, size: 18)
        collectBtn.setTitleColor(CPFRGB(r: 155, g: 155, b: 155), for: .normal)
        collectBtn.setTitleColor(CPFRGB(r: 208, g: 2, b: 27), for: .selected)
        collectBtn.tag = 0
        collectBtn.addTarget(self, action: #selector(categoryBtnClick(button:)), for: .touchUpInside)
        categoryView.addSubview(collectBtn)
        collectBtn.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(categoryView)
            make.width.equalTo(view.width/2)
        }
        
        collectBtn.isSelected = true
        selectedCategoryBtn = collectBtn
        
        let moreBtn = UIButton(type: .custom)
        moreBtn.setTitle(CPFLocalizableTitle(CPFLocalizableTitle("mine_moreBtn")), for: .normal)
        moreBtn.titleLabel?.textAlignment = .center
        moreBtn.titleLabel?.font = CPFPingFangSC(weight: .regular, size: 18)
        moreBtn.setTitleColor(CPFRGB(r: 155, g: 155, b: 155), for: .normal)
        moreBtn.setTitleColor(CPFRGB(r: 208, g: 2, b: 27), for: .selected)
        moreBtn.tag = 1
        moreBtn.addTarget(self, action: #selector(categoryBtnClick(button:)), for: .touchUpInside)
        categoryView.addSubview(moreBtn)
        moreBtn.snp.makeConstraints { make in
            make.top.bottom.equalTo(categoryView)
            make.width.equalTo(collectBtn)
            make.right.equalTo(categoryView.snp.right)
        }
        
        let verticalLineImageView  = UIImageView()
        verticalLineImageView.image = UIImage.init(named: "verticalLine")
        categoryView.addSubview(verticalLineImageView)
        verticalLineImageView.snp.makeConstraints { make in
            make.center.equalTo(categoryView)
            make.width.equalTo(0.5)
            make.height.equalTo(30)
        }
        
        let horizontalImageView = UIImageView()
        horizontalImageView.image = UIImage.init(named: "verticalLine")
        categoryView.addSubview(horizontalImageView)
        horizontalImageView.snp.makeConstraints { make in
            make.left.right.equalTo(categoryView)
            make.height.equalTo(0.5)
            make.bottom.equalTo(categoryView.snp.bottom)
        }
        
        
    }
    
    func setupContentScrollView() -> Void {
        contentScrollView = UIScrollView()
        view.insertSubview(contentScrollView, at: 0)
        contentScrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(categoryView.snp.bottom)
        }
        automaticallyAdjustsScrollViewInsets = false
        contentScrollView.contentSize = CGSize(width: 2 * view.width, height: 0)
        contentScrollView.isPagingEnabled = true
        contentScrollView.delegate = self
        
        scrollViewDidEndScrollingAnimation(contentScrollView)
    }
    
    func setupNavigationBar() -> Void {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let frame = navigationController?.navigationBar.frame
        navAlphaView = UIView(frame: CGRect(x: 0, y: -20, width: (frame?.size.width)!, height: (frame?.size.height)!+20))
        navAlphaView.backgroundColor = CPFRGB(r: 189, g: 34, b: 35)
        navAlphaView.isUserInteractionEnabled = false
        navigationController?.navigationBar.insertSubview(navAlphaView, at: 0)
    }
    
    func changeNavigationBarAlpha(alpha: CGFloat) -> Void {
        navAlphaView.alpha = alpha
    }
    
    func categoryBtnClick(button:UIButton) -> Void {
        
        selectedCategoryBtn.isSelected = false
        
        if button.tag == 0 {
            print("点击收藏")
        } else {
            print("点击更多")
        }
        
        selectedCategoryBtn = button
        selectedCategoryBtn.isSelected = true
    }
}


extension CPFMineController: UIScrollViewDelegate, UICollectionViewDelegate {
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("============")
        // bug
        let collectController = CPFAttentionController()
        addChildViewController(collectController)
        collectController.view.backgroundColor = CPFRandomColor
        collectController.view.x = -CPFScreenW/2
        collectController.collectionView?.delegate = self
        collectController.collectionView?.contentInset = UIEdgeInsets(top: -40, left: 0, bottom: 680, right: 0)
        contentScrollView.addSubview(collectController.view)
        
        let moreSettingsCtr = CPFMoreSettingsController()
        moreSettingsCtr.view.x = CPFScreenW
        contentScrollView.addSubview(moreSettingsCtr.view)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        
        if scrollView.contentOffset.y > 50 {
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.user_InfoView.snp.updateConstraints({ (make) in
                    make.top.equalTo(-250+64)
                })
                self.changeNavigationBarAlpha(alpha: 1.0)
                self.navigationItem.title = "我七岁就很帅"
                self.view.layoutIfNeeded()
            })
        }
        
        if scrollView.contentOffset.y < 30 {
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.user_InfoView.snp.updateConstraints({ (make) in
                    make.top.equalTo(self.view)
                })
                self.changeNavigationBarAlpha(alpha: 0)
                self.navigationItem.title = ""
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击了：\(indexPath.row)行")
    }
}
