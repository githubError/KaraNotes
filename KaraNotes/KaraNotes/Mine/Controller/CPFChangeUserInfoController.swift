//
//  CPFChangeUserInfoController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/20.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit
import Alamofire

class CPFChangeUserInfoController: BaseViewController {
    
    var navAlphaView:UIView!
    
    fileprivate var tableView:UITableView!
    fileprivate let navigationLabel = UILabel()
    fileprivate var saveBtn:UIButton!
    fileprivate let CellID: String = "changeInfoCell"
    fileprivate var currentIndexPathRow: Int = 0
    
    override func viewDidLoad() {
        configInfo()
        setupSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navAlphaView.alpha = 1.0
        navigationLabel.isHidden = false
        saveBtn.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationLabel.isHidden = true
        saveBtn.isHidden = true
    }
}


// MARK: - Custom Methods
extension CPFChangeUserInfoController {
    
    func configInfo() -> Void {
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        
        navigationLabel.size = CGSize(width: 150, height: 35)
        navigationLabel.centerX = view.middleX
        navigationLabel.centerY = 22
        navigationLabel.textAlignment = .center
        navigationLabel.font = CPFPingFangSC(weight: .semibold, size: 18)
        navigationLabel.textColor = UIColor.white
        navigationController?.navigationBar.addSubview(navigationLabel)
        navigationLabel.text = CPFLocalizableTitle("mine_changeInfo_navTitle")
        
        saveBtn = UIButton(type: .custom)
        saveBtn.size = CGSize(width: 40, height: 30)
        saveBtn.centerX = CPFScreenW - saveBtn.size.width
        saveBtn.centerY = 25
        saveBtn.setTitle(CPFLocalizableTitle("mine_changeInfo_saveBtn"), for: .normal)
        saveBtn.addTarget(self, action: #selector(saveBtnClick), for: .touchUpInside)
        navigationController?.navigationBar.addSubview(saveBtn)
    }
    
    func saveBtnClick() -> Void {
        print("-------------saveBtnClick")
    }
}


// MARK: - Setup Subviews
extension CPFChangeUserInfoController {
    
    func setupSubviews() -> Void {
        view.backgroundColor = CPFRandomColor
        
        setupTableView()
    }
    
    func setupTableView() -> Void {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        tableView.register(CPFChangeUserInfoCell.self, forCellReuseIdentifier: CellID)
        tableView.separatorStyle = .singleLineEtched
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
}


// MARK: - 
extension CPFChangeUserInfoController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID) as! CPFChangeUserInfoCell
        cell.selectionStyle = .none
        
        switch indexPath.row {
        case 0:
            cell.cellType = .userHeaderImgCell
            cell.typeLabel.text = "头像"
            
            let headerImageURLString = "\(CPFNetworkRoute.getAPIFromRouteType(route: .headerImage))/\(getUserInfoForKey(key: CPFUserHeaderImg))"
            let headerImagURL = URL(string: headerImageURLString)!
            cell.headerImageView.af_setImage(withURL: headerImagURL)
        case 1:
            cell.cellType = .userNameCell
            cell.typeLabel.text = "用户名"
            cell.textField.text = getUserInfoForKey(key: CPFUserName)
        case 2:
            cell.cellType = .userSexCell
            cell.typeLabel.text = "性别"
            cell.sexLabel.text = (getUserInfoForKey(key: CPFUserSex) == "1" ? "男" : "女")
        case 3:
            cell.cellType = .userNormalCell
            cell.typeLabel.text = "背景图"
        default:
            print("unknow type cell")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        currentIndexPathRow = indexPath.row
        
        switch indexPath.row {
        case 0:
            print("更改头像")
            selectImageFromPhotoLibrary()
        case 1:
            print("更改姓名")
        case 2:
            print("更改性别")
        case 3:
            print("更改背景图片")
            selectImageFromPhotoLibrary()
        default:
            print("unknow type cell")
        }
        
        if indexPath.row != 1 {
            let indexPath = IndexPath(row: 1, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! CPFChangeUserInfoCell
            cell.textField.resignFirstResponder()
        }
        
    }
}


// MARK: - Custom Methods
extension CPFChangeUserInfoController {
    
    func selectImageFromPhotoLibrary() -> Void {
        let imagePickerCtr = UIImagePickerController()
        imagePickerCtr.sourceType = .photoLibrary
        imagePickerCtr.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        navigationController?.present(imagePickerCtr, animated: true, completion: nil)
    }
    
    
    func uploadData(data:Data, route: CPFNetworkRoute, completionHandler: @escaping (_ LinkString:String) -> Void) -> Void {
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(data, withName: "img", fileName: "testName", mimeType: "image/*")
        }, to: "\(CPFNetworkRoute.getAPIFromRouteType(route: route))?token_id=\(getUserInfoForKey(key: CPFUserToken))",
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    if progress.isCancelled { return }
                    
                    CPFProgressView.sharedInstance().showProgressView(progress: CGFloat(progress.fractionCompleted), promptMessage: "正在上传 \n \(Int(progress.fractionCompleted * 100))%")
                    if progress.fractionCompleted == 1.0 {
                        CPFProgressView.sharedInstance().dismissProgressView(completionHandeler: {
                            progress.cancel()
                        })
                    }
                })
                upload.response { response in
                    
                    let string = String(bytes: response.data!, encoding: .utf8)!
                    completionHandler(string)
                }
            case .failure(let encodingError):
                print("-------\(encodingError)")
            }
        })
    }
}


// MARK: - UIImagePickerController
extension CPFChangeUserInfoController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageData: Data
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageData = UIImageJPEGRepresentation(image, 0)!
            picker.dismiss(animated: true) {
                var route: CPFNetworkRoute!
                if self.currentIndexPathRow == 0 {
                    route = CPFNetworkRoute.headerImage
                } else if self.currentIndexPathRow == 3 {
                    route = CPFNetworkRoute.backgroundImage
                }
                
                self.uploadData(data: imageData, route: route, completionHandler: { (response) in
                    print("---------\(response)")
                    
                    //TODO: 更新当前 logo，发出更改用户信息页信息的通知
                    if self.currentIndexPathRow == 0 {
                        setUserInfo(value: response as AnyObject, forKey: CPFUserHeaderImg)
                    } else if self.currentIndexPathRow == 3 {
                        setUserInfo(value: response as AnyObject, forKey: CPFUserBgImg)
                    }
                })
            }
        }
    }
}
