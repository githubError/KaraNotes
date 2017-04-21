//
//  CPFUserManager.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/27.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit
import Alamofire

class CPFUserManager: NSObject {
    
    static let instance:CPFUserManager = CPFUserManager()
    
    static func sharedInstance() -> CPFUserManager {
        return instance
    }
}


extension CPFUserManager {
    
    func userToken() -> String {
        if let userToken = UserDefaults.standard.value(forKey: CPFUserToken) as? String {
            return userToken
        }
        return ""
    }
    
    func isLogin() -> Bool {
        if userToken().isEmpty {
            return false
        }
        return true
    }
    
    func checkEmail(withAccount account: String, completionHandler: @escaping (_ result:Int) -> Void) {
        // 账号检测
        let params = ["email":account]
        Alamofire.request(CPFNetworkRoute.getAPIFromRouteType(route: .checkEmail), parameters: params).responseJSON { (response) in
            switch response.result {
            case .success(let json as JSONDictionary):
                guard let result = json["code"] else{fatalError()}
                completionHandler(Int((result as! NSString).intValue))
            case .failure(let error):
                print("===\(error)")
            default:break
            }
        }
    }
    
    func login(withAccount account: String, password: String, completionHandler: @escaping (_ result:Int) -> Void) -> Void {
        
        let params = ["user_email":account, "user_password":password]
        Alamofire.request(CPFNetworkRoute.getAPIFromRouteType(route: .login), method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON { response in
            
            switch response.result {
                
            case .success(let json as JSONDictionary) :
                
                guard let code_result = json["code"] else {fatalError()}
                let code = Int(code_result as! String)!
                if code == 1 {
                    guard let result = json["result"] else {fatalError()}
                    
                    guard let user_email = result["user_email"] as? String else {fatalError()}
                    guard let token_id = result["token_id"] as? String else { fatalError()}
                    guard let user_path = result["user_path"] as? String else {fatalError()}
                    
                    guard let user_headimg = result["user_headimg"] as? String else {fatalError()}
                    guard let user_background_img = result["user_background_img"] as? String else {fatalError()}
                    guard let user_id = result["user_id"] as? String else {fatalError()}
                    guard let user_name = result["user_name"] as? String else {fatalError()}
                    guard let user_sex = result["user_sex"] as? String else {fatalError()}
                    guard let user_signature = result["user_signature"] as? String else {fatalError()}
                    
                    
                    UserDefaults.standard.set(token_id, forKey: CPFUserToken)
                    UserDefaults.standard.set(user_email, forKey: CPFUserEmail)
                    UserDefaults.standard.set(user_path, forKey: CPFUserPath)
                    UserDefaults.standard.set(user_headimg, forKey: CPFUserHeaderImg)
                    UserDefaults.standard.set(user_background_img, forKey: CPFUserBgImg)
                    UserDefaults.standard.set(user_id, forKey: CPFUserID)
                    UserDefaults.standard.set(user_name, forKey: CPFUserName)
                    UserDefaults.standard.set(user_sex, forKey: CPFUserSex)
                    UserDefaults.standard.set(user_signature, forKey: CPFUserSignature)
                    UserDefaults.standard.synchronize()
                    
                    completionHandler(code)
                }
                
            case .failure(let error):
                print("++++\(error)")
            default: break
            }
        }
    }
    
    func register(withAccount account: String, password: String, completionHandler:@escaping (_ result:Int, _ userName:String)->Void ) {
        let params = ["user_email":account, "user_password":password]
        Alamofire.request(CPFNetworkRoute.getAPIFromRouteType(route: .register), method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON { response in
            
            switch response.result {
            case .success(let json as JSONDictionary):
                guard let code_result = json["code"] else {fatalError()}
                let code = Int(code_result as! String)!
                
                if code == 1 {
                    
                    guard let result = json["result"] as? JSONDictionary else {fatalError()}
                    
                    guard let userName = result["user_name"] as? String else {fatalError()}
                    completionHandler(code, userName)
                } else {
                    guard let errorCode = json["error"] as? Int else {fatalError()}
                    if errorCode == 3 {
                        completionHandler(code, String(errorCode))
                    } else {
                        completionHandler(code, String(errorCode))
                    }
                }
                
            case .failure(let error as JSONDictionary):
                guard let error = error["error"] as? Int else {fatalError()}
                print("----\(error)")
            default:break
            }
        }
    }
    
    func logout(completionHandler:@escaping ()->()) -> Void {
        UserDefaults.standard.setValue("", forKey: CPFUserToken)
        if !isLogin() {
            let keyWindow = UIApplication.shared.keyWindow!
            keyWindow.rootViewController = CPFLoginController()
            completionHandler()
        }
        
    }
}
