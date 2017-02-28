//
//  CPFLoginController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/26.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFLoginController: UIViewController {
    var bgImageView:UIImageView!
    var logoImageView:UIImageView!
    var accoundView:UIView!
    var emailTextField:UITextField!
    var passwordTextField:UITextField!
    var respondBtn:UIButton!
    
    var canLogin:Bool = false   // 检查账号是否已存在

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = CPFGlobalColor
        
        setupSubviews()
    }
}

// MARK: - setup
extension CPFLoginController: UITextFieldDelegate {

    func setupSubviews() {     // 设置子视图
        setupSubImageView()
        setupTextField()
        setupBtn()
    }
    
    func setupSubImageView() {
        bgImageView = UIImageView.init(image: UIImage.init(named: "login_bg"))
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        logoImageView = UIImageView.init(image: UIImage.init(named: "karanotes_logo"))
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(80*CPFFitHeight)
            make.centerX.equalTo(view.centerX)
            make.width.height.equalTo(120*CPFFitWidth)
        }
    }
    
    func setupTextField() {
        accoundView = UIView()
        view.addSubview(accoundView)
        accoundView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(80*CPFFitHeight)
            make.left.equalTo(view).offset(30*CPFFitWidth)
            make.right.equalTo(view).offset(-30*CPFFitWidth)
            make.height.equalTo(60*CPFFitHeight)
        }
        
        emailTextField = UITextField()
        emailTextField.tintColor = UIColor.white
        emailTextField.placeholder = CPFLocalizableTitle("emailTextFieldPlaceholder")
        emailTextField.setValue(CPFRGBA(r: 255, g: 255, b: 255, a: 0.7), forKeyPath: "placeholderLabel.textColor")
        emailTextField.textColor = UIColor.white
        emailTextField.textAlignment = .center
        emailTextField.becomeFirstResponder()
        emailTextField.keyboardType = .emailAddress
        emailTextField.returnKeyType = .next
        emailTextField.delegate = self
        emailTextField.tag = 1
        accoundView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        passwordTextField = UITextField()
        passwordTextField.tintColor = UIColor.white
        passwordTextField.placeholder = CPFLocalizableTitle("passwordTextFieldPlaceholder")
        passwordTextField.setValue(CPFRGBA(r: 255, g: 255, b: 255, a: 0.7), forKeyPath: "placeholderLabel.textColor")
        passwordTextField.textColor = UIColor.white
        passwordTextField.textAlignment = .center
        passwordTextField.isHidden = true
        passwordTextField.isSecureTextEntry = true
        passwordTextField.clearsOnBeginEditing = true
        passwordTextField.returnKeyType = .go
        passwordTextField.delegate = self
        passwordTextField.tag = 2
        accoundView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(emailTextField)
        }
    }
    
    func setupBtn() {
        respondBtn = UIButton(type: .custom)
        view.addSubview(respondBtn)
        respondBtn.setBackgroundImage(UIImage.init(named: "login_btn_bg"), for: .normal)
        respondBtn.setTitle(CPFLocalizableTitle("responBtn_next"), for: .normal)
        respondBtn.titleLabel?.font = CPFPingFangSC(weight: .regular, size: 14)
        respondBtn.addTarget(self, action: #selector(respondBtnClick), for: .touchUpInside)
        respondBtn.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(25*CPFFitHeight)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(140)
            make.height.equalTo(30)
        }
    }
    
    func updateAccountViewConstraints() {
        let offsetY:CGFloat = 20.0
        
        accoundView.snp.updateConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset((80 - offsetY)*CPFFitHeight)
        }
        
        respondBtn.snp.updateConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset((25 + offsetY)*CPFFitHeight)
        }
        
        passwordTextField.isHidden = false
    }
    
    func recoverAccountViewConstraints() {
        let offsetY:CGFloat = -20.0
        
        accoundView.snp.updateConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset((80 - offsetY)*CPFFitHeight)
        }
        
        respondBtn.snp.updateConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset((25 + offsetY)*CPFFitHeight)
        }
        
        passwordTextField.isHidden = true
        respondBtn.setTitle(CPFLocalizableTitle("responBtn_next"), for: .normal)
        passwordTextField.text = ""
    }
}

extension CPFLoginController {
    func respondBtnClick() {
        if passwordTextField.isHidden {
            
            if !isLegalEmail(email: emailTextField.text!) {
                emailTextField.text = ""
                emailTextField.placeholder = CPFLocalizableTitle("illegalEmailAddress")
                return
            }
            
            CPFUserManager.sharedInstance().checkEmail(withAccount: emailTextField.text!, completionHandler: { (result) in
                if result == 1 {
                    print("账号存在，显示登录按钮")
                    
                    self.respondBtn.setTitle(CPFLocalizableTitle("responBtn_login"), for: .normal)
                    self.canLogin = true
                } else {
                    print("账号不存在，显示注册按钮")
                    
                    self.respondBtn.setTitle(CPFLocalizableTitle("responBtn_register"), for: .normal)
                    self.canLogin = false
                }
                self.updateAccountViewConstraints()
            })
            return
        } else {
            
            if !isLegalPassword(password: passwordTextField.text!) {return}
            
            if canLogin {
                CPFUserManager.sharedInstance().login(withAccount: emailTextField.text!, password: passwordTextField.text!, completionHandler: { (result) in
                    if result == 1 {
                        let keyWindow = UIApplication.shared.keyWindow!
                        keyWindow.rootViewController = CPFTabBarController()
                    } else {
                        print("登录出错")
                    }
                })
            } else {
                CPFUserManager.sharedInstance().register(withAccount: emailTextField.text!, password: passwordTextField.text!, completionHandler: { (result, errorCode) in
                    if result == 1 {
                        self.respondBtn.setTitle(CPFLocalizableTitle("loginAfterRegister"), for: .normal)
                        self.canLogin = true
                    } else {
                        if errorCode == "3" {
                            print("账号已存在")
                        }
                    }
                })
            }
            
            return
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if !passwordTextField.isHidden && textField.tag == 1{
            
            recoverAccountViewConstraints()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            if passwordTextField.isHidden {
                respondBtnClick()
                return true
            }
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else {
            respondBtnClick()
        }
        return true
    }
    
    func isLegalEmail(email:String) -> Bool {
        let parten = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"
        let reg = try? NSRegularExpression(pattern: parten, options: .caseInsensitive)
        let result = reg?.numberOfMatches(in: email, options: .reportCompletion, range: NSRange(location: 0, length: email.lengthOfBytes(using: .utf8)))
        if let result = result {
            guard result > 0 else { return false }
            return true
        }
        return false
    }
    
    func isLegalPassword(password:String) -> Bool {
        print("password.lengthOfBytes:\(password.lengthOfBytes(using: .utf8))")
        guard password.lengthOfBytes(using: .utf8) > 6 else { return false }
        return true
    }
}
