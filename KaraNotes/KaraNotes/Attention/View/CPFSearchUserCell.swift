//
//  CPFUserAttentionCell.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/5/2.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit
import Alamofire

enum CPFUserAttentionCellType:Int {
    case withoutAttent = 0, cancelAttent
}

class CPFSearchUserCell: UITableViewCell {
    
    var thumbImageView:UIImageView!
    var userNameLabel:UILabel!
    var attentionBtn:UIButton!
    var cellType:CPFUserAttentionCellType! {
        
        didSet {
            switch cellType.rawValue {
            case 0:
                attentionBtn.backgroundColor = CPFRGB(r: 10, g: 200, b: 80)
                attentionBtn.setTitle(CPFLocalizableTitle("user_attent_follow"), for: .normal)
            case 1:
                attentionBtn.backgroundColor = CPFRGB(r: 200, g: 200, b: 200)
                attentionBtn.setTitle(CPFLocalizableTitle("user_attent_unfollow"), for: .normal)
            default:
                attentionBtn.backgroundColor = CPFRGB(r: 200, g: 200, b: 200)
                attentionBtn.setTitle(CPFLocalizableTitle("user_attent_mut-follow"), for: .normal)
            }
        }
    }
    
    var userModel: CPFSearchUserModel! {
        
        didSet {
            let headerImageURLString = "\(CPFNetworkRoute.getAPIFromRouteType(route: .headerImage))/\(userModel.user_headimg))"
            Alamofire.request(headerImageURLString).responseImage { (response) in
                if let image = response.result.value {
                    self.thumbImageView.image = image
                }
            }
            userNameLabel.text = userModel.user_name
            switch userModel.is_eachother {
            case "0":
                // 未关注
                self.cellType = .withoutAttent
            case "1":
                // 被关注
                self.cellType = .withoutAttent
            case "2":
                // 已关注
                self.cellType = .cancelAttent
            case "3":
                // 相互关注
                self.cellType = .cancelAttent
            default:
                print("Unkonw error when change attrntionBtn status")
            }
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
}


// MARK: - Custom Methods
extension CPFSearchUserCell {
    
    func attentionBtnClick() -> Void {
        switch cellType.rawValue {
        case 0:
            let params = ["token_id":getUserInfoForKey(key: CPFUserToken),
                          "follow_user_id":userModel.user_id,
                          "is_eachother":userModel.is_eachother]
            Alamofire.request(CPFNetworkRoute.getAPIFromRouteType(route: .addAttent), method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let json as JSONDictionary):
                    guard let code = json["code"] as? String else { fatalError("关注出现问题")}
                    if code == "1" {
                        self.cellType = .cancelAttent
                        
                        switch self.userModel.is_eachother {
                        case "0", "1":
                            print("未关注")
                            self.userModel.is_eachother = "2"
                        case "2","3":
                            print("已关注")
                            self.userModel.is_eachother = "0"
                        default:
                            print("Unknown ‘is_eachother’ type")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                default:
                    print("Unknow error when add attent")
                }
            })
            
        case 1:
            
            let params = ["token_id":getUserInfoForKey(key: CPFUserToken),
                          "follow_id":userModel.follow_id,
                          "follow_user_id":userModel.user_id,
                          "is_eachother":userModel.is_eachother]
            Alamofire.request(CPFNetworkRoute.getAPIFromRouteType(route: .cancelAttent), method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let json as JSONDictionary):
                    guard let code = json["code"] as? String else { fatalError("关注出现问题")}
                    if code == "1" {
                        self.cellType = .withoutAttent
                        
                        switch self.userModel.is_eachother {
                        case "0", "1":
                            print("未关注")
                            self.userModel.is_eachother = "2"
                        case "2","3":
                            print("已关注")
                            self.userModel.is_eachother = "0"
                        default:
                            print("Unknown ‘is_eachother’ type")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                default:
                    print("Unknow error when add attent")
                }
            })
        default:
            print("Unknow search user cell type")
        }
    }
}


// MARK: - setup subviews
extension CPFSearchUserCell {
    
    func setupSubviews() -> Void {
        setupThumbImageView()
        setupAttentionBtn()
        setupNameLabel()
    }
    
    func setupThumbImageView() -> Void {
        thumbImageView = UIImageView()
        thumbImageView.makeRound(round: 10)
        addSubview(thumbImageView)
        thumbImageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(75)
        }
    }
    
    func setupAttentionBtn() -> Void {
        attentionBtn = UIButton(type: .custom)
        attentionBtn.titleLabel?.font = CPFPingFangSC(weight: .regular, size: 12)
        attentionBtn.setTitleColor(UIColor.white, for: .normal)
        attentionBtn.makeRound(round: 5)
        attentionBtn.addTarget(self, action: #selector(attentionBtnClick), for: .touchUpInside)
        addSubview(attentionBtn)
        attentionBtn.snp.makeConstraints { (make) in
            make.width.equalTo(55)
            make.height.equalTo(30)
            make.right.equalTo(self.snp.right).offset(-15)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    func setupNameLabel() -> Void {
        userNameLabel = UILabel()
        userNameLabel.font = CPFPingFangSC(weight: .regular, size: 20)
        userNameLabel.textColor = CPFRGB(r: 0, g: 0, b: 0)
        addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.left.equalTo(thumbImageView.snp.right).offset(10)
            make.right.equalTo(attentionBtn.snp.left).offset(-10)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
}
