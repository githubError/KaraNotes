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
    var navBackBtn:UIButton!
    var user_InfoView:UIView!               // 用户信息
    
    var user_HeaderImageView:UIImageView!
    var user_SexImageView:UIImageView!
    var user_NameLabel:UILabel!
    var user_BgImageView:UIImageView!
    
    var categoryView:UIView!                // 子视图分类
    var contentScrollView:UIScrollView!     // 包裹子控制器的ScrollView
    
    var collectBtn:UIButton!
    var moreBtn:UIButton!
    var selectedCategoryBtn:UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
        navigationItem.title = ""
        setupSubViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        adjustCtrWhenViewAppear()
        configUserInfo()
    }
}


// MARK: - Custom Methods
extension CPFMineController {
    
    func adjustCtrWhenViewAppear() -> Void {
        var alpha = selectedCategoryBtn.tag == 0 ? 0.0 : 1.0
        if user_InfoView.y >= 0.0 { alpha = 0.0 }
        changeNavigationBarAlpha(alpha: CGFloat(alpha))
        navBackBtn.alpha = 0.0
    }
    
    
    func configUserInfo() -> Void {
        user_NameLabel.text = getUserInfoForKey(key: CPFUserName)
        user_SexImageView.image = (getUserInfoForKey(key: CPFUserSex) == "1") ? UIImage.init(named: "male") : UIImage.init(named: "female")
        
        let headerImageURLString = "\(CPFNetworkRoute.getAPIFromRouteType(route: .headerImage))/\(getUserInfoForKey(key: CPFUserHeaderImg))"
        let headerImagURL = URL(string: headerImageURLString)!
        
        user_HeaderImageView.af_setImage(withURL: headerImagURL)
        
        let backgroundImageURLString = "\(CPFNetworkRoute.getAPIFromRouteType(route: .backgroundImage))/\(getUserInfoForKey(key: CPFUserBgImg))"
        user_BgImageView.af_setImage(withURL: URL(string: backgroundImageURLString)!)
    }
    
    func changeUserInfoClick() -> Void {
        let changeUserInfoCtr = CPFChangeUserInfoController()
        changeUserInfoCtr.navAlphaView = navAlphaView
        navigationController?.pushViewController(changeUserInfoCtr, animated: true)
        changeNavigationBarAlpha(alpha: 1.0)
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
        let tapGestureRec = UITapGestureRecognizer(target: self, action: #selector(changeUserInfoClick))
        user_InfoView.addGestureRecognizer(tapGestureRec)
        view.addSubview(user_InfoView)
        user_InfoView.snp.makeConstraints { make in
            make.height.equalTo(250*CPFFitHeight)
            make.top.right.left.equalTo(view)
        }
        
        user_BgImageView = UIImageView()
        user_BgImageView.image = UIImage.init(named: "user_BgImage")
        user_InfoView.addSubview(user_BgImageView)
        user_BgImageView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(user_InfoView)
        }
        
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.alpha = 0.4
        user_BgImageView.addSubview(visualEffectView)
        visualEffectView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
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
        
        user_SexImageView = UIImageView()
        user_SexImageView.image = UIImage.init(named: "female")
        user_InfoView.addSubview(user_SexImageView)
        user_SexImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
            make.left.equalTo(user_HeaderImageView.snp.right).offset(-10)
            make.bottom.equalTo(user_HeaderImageView.snp.bottom).offset(-0)
        }
        
        user_NameLabel = UILabel()
        user_InfoView.addSubview(user_NameLabel)
        user_NameLabel.text = "我七岁就很帅"
        user_NameLabel.textAlignment = .center
        user_NameLabel.textColor = UIColor.white
        user_NameLabel.font = CPFPingFangSC(weight: .semibold, size: 20)
        user_NameLabel.shadowColor = CPFRGBA(r: 0, g: 0, b: 0, a: 0.3)
        user_NameLabel.shadowOffset = CGSize(width: 0, height: 1.5)
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
            make.height.equalTo(35*CPFFitHeight)
        }
        
        collectBtn = UIButton(type: .custom)
        collectBtn.setTitle(CPFLocalizableTitle(CPFLocalizableTitle("mine_collectBtn")), for: .normal)
        collectBtn.titleLabel?.textAlignment = .center
        collectBtn.titleLabel?.font = CPFPingFangSC(weight: .regular, size: 16)
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
        
        moreBtn = UIButton(type: .custom)
        moreBtn.setTitle(CPFLocalizableTitle(CPFLocalizableTitle("mine_moreBtn")), for: .normal)
        moreBtn.titleLabel?.textAlignment = .center
        moreBtn.titleLabel?.font = CPFPingFangSC(weight: .regular, size: 16)
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
        
        navBackBtn = UIButton(type: .custom)
        navBackBtn.setImage(UIImage.init(named: "back"), for: .normal)
        navBackBtn.size = CGSize(width: 20, height: 25)
        navBackBtn.x = 15
        navBackBtn.y = navAlphaView.middleY - 3
        navBackBtn.contentHorizontalAlignment = .left
        navBackBtn.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: -10, bottom: 0, right: 0)
        
        navAlphaView.addSubview(navBackBtn)
        navigationController?.navigationBar.insertSubview(navAlphaView, at: 0)
    }
    
    func changeNavigationBarAlpha(alpha: CGFloat) -> Void {
        navAlphaView.alpha = alpha
        navBackBtn.alpha = alpha
    }
    
    func categoryBtnClick(button:UIButton) -> Void {
        
        selectedCategoryBtn.isSelected = false
        
        if button.tag == 0 {
            UIView.animate(withDuration: 0.25, animations: {
                self.contentScrollView.contentOffset.x = 0
            })
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.contentScrollView.contentOffset.x = CPFScreenW
            })
        }
        
        selectedCategoryBtn = button
        selectedCategoryBtn.isSelected = true
    }
}


extension CPFMineController: UIScrollViewDelegate, UICollectionViewDelegate {
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        let favoriteController = CPFFavoriteController()
        addChildViewController(favoriteController)
        favoriteController.deledate = self
        contentScrollView.addSubview(favoriteController.view)
        
        let moreSettingsCtr = CPFMoreSettingsController()
        moreSettingsCtr.delegate = self
        addChildViewController(moreSettingsCtr)
        moreSettingsCtr.view.x = CPFScreenW
        contentScrollView.addSubview(moreSettingsCtr.view)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x / CPFScreenW == 0 {
            categoryBtnClick(button: collectBtn)
        } else {
            categoryBtnClick(button: moreBtn)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击了：\(indexPath.row)行")
    }
}

extension CPFMineController:CPFFavoriteControllerDelegate {
    func favoriteControllerScrollToShowTop(favoriteController: CPFFavoriteController) {
        print("显示用户头像")
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.user_InfoView.snp.updateConstraints({ (make) in
                make.top.equalTo(self.view)
            })
            self.changeNavigationBarAlpha(alpha: 0)
            self.navigationItem.title = ""
            self.view.layoutIfNeeded()
        })
    }
    
    func favoriteControllerScrollToShowBottom(favoriteController: CPFFavoriteController) {
        print("隐藏用户信息")
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.user_InfoView.snp.updateConstraints({ (make) in
                make.top.equalTo(-250+64)
            })
            self.changeNavigationBarAlpha(alpha: 1.0)
            self.navigationItem.title = "我七岁就很帅"
            self.view.layoutIfNeeded()
        })
        
        self.navBackBtn.alpha = 0.0
    }
}

extension CPFMineController: CPFTopCategoryBtnClickDelegate {
    
    func currentController(controller: UIViewController, didClickCategoryBtn button: UIButton) {
        
        let settingCategoryController = CPFSettingCategoryController()
        settingCategoryController.settingCategoryType = CPFSettingCategoryType(rawValue: button.tag)
        navigationController?.pushViewController(settingCategoryController, animated: true)
        
        changeNavigationBarAlpha(alpha: 1.0)
    }
}
