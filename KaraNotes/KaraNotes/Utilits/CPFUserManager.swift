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
        Alamofire.request(CPFNetworkRoute.checkEmail.rawValue, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success(let json as JSONDictionary):
                guard let result = json["success"] as? Int else{fatalError()}
                completionHandler(result)
            case .failure(let error):
                print("===\(error)")
            default:break
            }
        }
    }
    
    func login(withAccount account: String, password: String, completionHandler: @escaping (_ result:Int) -> Void) -> Void {
        let params = ["user_email":account, "user_password":password]
        Alamofire.request(CPFNetworkRoute.login.rawValue, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON { response in
            
            switch response.result {
                
            case .success(let json as JSONDictionary) :
                
                guard let result = json["success"] as? Int else {fatalError()}
                guard let user_email = json["user_email"] as? String else {fatalError()}
                guard let token_id = json["token_id"] as? String else { fatalError()}
                guard let user_path = json["user_path"] as? String else {fatalError()}
                
                UserDefaults.standard.set(token_id, forKey: CPFUserToken)
                UserDefaults.standard.set(user_email, forKey: CPFUserEmail)
                UserDefaults.standard.set(user_path, forKey: CPFUserPath)
                UserDefaults.standard.synchronize()
                
                completionHandler(result)
                
            case .failure(let error):
                print("++++\(error)")
            default: break
            }
        }
    }
    
    func register(withAccount account: String, password: String, completionHandler:@escaping (_ result:Int, _ userName:String)->Void ) {
        let params = ["user_email":account, "user_password":password]
        Alamofire.request(CPFNetworkRoute.register.rawValue, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON { response in
            
            switch response.result {
            case .success(let json as JSONDictionary):
                guard let result = json["success"] as? Int else {fatalError()}
                
                if result == 1 {
                    guard let userName = json["user_name"] as? String else {fatalError()}
                    completionHandler(result, userName)
                } else {
                    guard let errorCode = json["error"] as? Int else {fatalError()}
                    if errorCode == 3 {
                        completionHandler(result, String(errorCode))
                    } else {
                        completionHandler(result, String(errorCode))
                    }
                }
                
            case .failure(let error as JSONDictionary):
                guard let error = error["error"] as? Int else {fatalError()}
                print("----\(error)")
            default:break
            }
        }
    }
    
    func logout() -> Bool {
        UserDefaults.standard.setValue("", forKey: CPFUserToken)
        guard isLogin() else { return true }
        return false
    }
}
