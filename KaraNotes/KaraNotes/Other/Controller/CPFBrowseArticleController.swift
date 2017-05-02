//
//  CPFBrowseArticleController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/28.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit
import Alamofire

class CPFBrowseArticleController: BaseViewController {

    var isMyArticle:Bool = false
    var thumbImage:UIImage!
    var articleTitle:String!
    var articleCreateTime:String!
    var articleAuthorName:String!
    var articleID:String!
    
    fileprivate var scrollView:UIScrollView!
    
    fileprivate var topImageView:UIImageView!
    
    fileprivate var articleInfoView:UIView!
    fileprivate var articleTitleLabel:UILabel!
    fileprivate var articleAuthorLabel:UILabel!
    fileprivate var articleCreateTimeLabel:UILabel!
    
    fileprivate var articleContentWebView:UIWebView!
    fileprivate var webBrowserView:UIView!
    
    fileprivate var bottomAssistView:UIView!
    fileprivate var bottomAssistBtns:[UIButton]! = []
    
    fileprivate var browseArticleModel:CPFBrowseArticleModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadArticleContent(articleID: articleID)
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}


// MARK: - Custom Methods
extension CPFBrowseArticleController {
    
    func loadArticleContent(articleID: String) -> Void {
        
        let params = ["token_id": getUserInfoForKey(key: CPFUserToken),
                      "article_id": articleID]
        Alamofire.request(CPFNetworkRoute.getAPIFromRouteType(route: .loadArticleContent), method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            switch response.result {
            case .success(let json as JSONDictionary):
                guard let result = json["result"] as? JSONDictionary else {fatalError("Json 解析失败")}
                
                self.browseArticleModel = CPFBrowseArticleModel.parse(json: result)
                self.refreshArticleDetail(browseArticleModel: self.browseArticleModel)
                
            case .failure(let error):
                print(error.localizedDescription)
            default:
                print("Unkonw Error when load article")
            }
        }
    }
    
    fileprivate func refreshArticleDetail(browseArticleModel: CPFBrowseArticleModel) -> Void {
        
        DispatchQueue.main.async { [weak self] in
            let htmlString = CPFShareTools.sharedInstance().HTMLFormatStringFromMarkdownString(markdownString:  browseArticleModel.article_content)
            self!.articleContentWebView.loadHTMLString(htmlString, baseURL: nil)
        }
        
        bottomAssistBtns.forEach { (button) in
            switch button.tag {
            case 0:
                button.setTitle("\(CPFLocalizableTitle("browse_like"))"+" \(browseArticleModel.praise_num!)", for: .normal)
            case 1:
                button.setTitle("\(CPFLocalizableTitle("browse_comment"))"+" \(browseArticleModel.comment_num!)", for: .normal)
            case 2:
                button.setTitle("\(CPFLocalizableTitle("browse_collection"))"+" \(browseArticleModel.collect_num!)", for: .normal)
            case 3,4:
                break
            default:
                print("Unknow error when refresh browse bottom asstst btns status")
            }
        }
    }
    
    func bottomAssistBtnClick(button:UIButton) -> Void {
        print(button.tag)
        switch button.tag {
        case 0:
            print("点赞")
        case 1:
            print("评论")
        case 2:
            print("收藏")
        case 3:
            print("编辑")
        case 4:
            print("分享")
        default:
            print(button.tag)
        }
    }
    
    func dismissCtr() -> Void {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - setup subviews
extension CPFBrowseArticleController {
    
    func setupSubviews() -> Void {
        setupArticleContentWebView()
        setupScrollView()
        setupTopImageView()
        setupArticleInfoView()
        setupBottomAssistView()
    }
    
    func setupArticleContentWebView() -> Void {
        articleContentWebView = UIWebView()
        articleContentWebView.backgroundColor = UIColor.white
        articleContentWebView.scrollView.backgroundColor = UIColor.white
        articleContentWebView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 45, right: 0)
        view.addSubview(articleContentWebView)
        articleContentWebView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        webBrowserView = articleContentWebView.getSubviewFrom("UIWebBrowserView")
        webBrowserView.frame = CGRect(x: 0, y: (CPFScreenH - 100), width: 0, height: 0)
        
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissCtr))
        articleContentWebView.addGestureRecognizer(gestureRecognizer)
    }
    
    func setupScrollView() -> Void {
        scrollView = articleContentWebView.subviews[0] as! UIScrollView
        scrollView.delegate = self
    }
    
    func setupTopImageView() -> Void {
        topImageView = UIImageView()
        topImageView.isUserInteractionEnabled = true
        topImageView.image = thumbImage
        topImageView.contentMode = .scaleToFill
        scrollView.addSubview(topImageView)
        topImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(500*CPFFitHeight)
            make.width.equalTo(CPFScreenW * 2)
        }
    }
    
    func setupArticleInfoView() -> Void {
        articleInfoView = UIView()
        scrollView.addSubview(articleInfoView)
        articleInfoView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(CPFScreenH - 500*CPFFitHeight - 100)
            make.width.equalTo(CPFScreenW)
            make.top.equalTo(topImageView.snp.bottom).offset(10)
        }
        
        articleTitleLabel = UILabel()
        articleTitleLabel.numberOfLines = 0
        articleTitleLabel.textAlignment = .center
        articleTitleLabel.font = CPFPingFangSC(weight: .medium, size: 20)
        articleTitleLabel.textColor = UIColor.black
        articleTitleLabel.text = articleTitle
        articleInfoView.addSubview(articleTitleLabel)
        articleTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(35)
            make.top.equalTo(articleInfoView.snp.top).offset(5)
        }
        
        articleAuthorLabel = UILabel()
        articleAuthorLabel.font = CPFPingFangSC(weight: .regular, size: 13)
        articleAuthorLabel.textAlignment = .right
        articleAuthorLabel.text = articleAuthorName
        articleInfoView.addSubview(articleAuthorLabel)
        articleAuthorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(articleTitleLabel.snp.bottom).offset(0)
            make.height.equalTo(20)
            make.right.equalTo(articleTitleLabel.snp.centerX)
            make.width.equalTo(150*CPFFitWidth)
        }
        
        let separateLabel = UILabel()
        separateLabel.text = "/"
        separateLabel.font = CPFPingFangSC(weight: .regular, size: 10)
        separateLabel.textColor = CPFRGB(r: 115, g: 115, b: 115)
        separateLabel.textAlignment = .center
        articleInfoView.addSubview(separateLabel)
        separateLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(articleAuthorLabel)
            make.left.equalTo(articleAuthorLabel.snp.right)
            make.width.equalTo(15)
        }
        
        articleCreateTimeLabel = UILabel()
        articleCreateTimeLabel.text = articleCreateTime
        articleCreateTimeLabel.font = CPFPingFangSC(weight: .regular, size: 13)
        articleCreateTimeLabel.textAlignment = .left
        articleInfoView.addSubview(articleCreateTimeLabel)
        articleCreateTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(separateLabel.snp.right)
            make.top.equalTo(articleTitleLabel.snp.bottom).offset(0)
            make.height.equalTo(20)
            make.width.equalTo(150*CPFFitWidth)
        }
    }
    
    func setupBottomAssistView() -> Void {
        bottomAssistView = UIView()
        bottomAssistView.backgroundColor = CPFRGB(r: 240, g: 240, b: 240)
        view.addSubview(bottomAssistView)
        bottomAssistView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(45)
        }
        
        let bottomAssistBtnImages = ["browse_like","browse_comment","browse_collection","browse_edit","browse_share"]
        for i in 0..<bottomAssistBtnImages.count {
            if !isMyArticle && i == 3 {
                continue
            }
            let btnsCount:Int = isMyArticle ? 5 : 4
            let btnsWidth:CGFloat = 45.0
            let btnsHeight:CGFloat = 45.0
            let margin:CGFloat = 15.0
            let space:CGFloat = (CPFScreenW - 2 * margin - CGFloat(btnsCount)*btnsWidth) / CGFloat(btnsCount-1)
            
            let button = UIButton(type: .custom)
            button.setImage(UIImage.init(named: bottomAssistBtnImages[i]), for: .normal)
            button.setTitle(CPFLocalizableTitle(bottomAssistBtnImages[i]), for: .normal)
            button.titleLabel?.font = CPFPingFangSC(weight: .regular, size: 11)
            button.setTitleColor(CPFRGB(r: 74, g: 74, b: 74), for: .normal)
            button.width = btnsWidth
            button.height = btnsHeight
            button.x = margin + CGFloat((!isMyArticle && i>3) ? (i-1) : i) * (space + btnsWidth)
            button.y = bottomAssistView.middleY + 2
            button.tag = i
            button.verticalImageAndTitleWithSpacing(spacing: 2)
            button.addTarget(self, action: #selector(bottomAssistBtnClick(button:)), for: .touchUpInside)
            bottomAssistView.addSubview(button)
            bottomAssistBtns.append(button)
        }
    }
}


// MARK: - UIScrollViewDelegate
extension CPFBrowseArticleController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 10 {
            let scale = (1.0 - scrollView.contentOffset.y/500.0)
            updateConstraints(scale: scale)
        }
    }
    
    // update browseView Constraints
    fileprivate func updateConstraints(scale: CGFloat) -> Void {
        topImageView.snp.updateConstraints({ (make) in
            make.height.equalTo(500*CPFFitHeight * scale)
            make.width.equalTo(CPFScreenW * 2 * scale)
        })
        
        webBrowserView.snp.makeConstraints({ (make) in
            make.top.equalTo(articleInfoView.snp.bottom)
        })
        
        articleContentWebView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 500*CPFFitHeight * scale + 45.0, right: 0)
    }
}
