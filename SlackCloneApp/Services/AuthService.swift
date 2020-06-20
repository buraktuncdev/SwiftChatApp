//
//  AuthService.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 20.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//

import Foundation
import Alamofire

class AuthService {
    
    //Singleton
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get{
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set{
            defaults.setValue(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set{
            defaults.setValue(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
             return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
             defaults.setValue(newValue, forKey: USER_EMAIL)
        }
    }
    
    // User Registration Function with Completion Handler
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler){
       // Web requests are asynchronous so we should use completion handler
       
        let lowerCaseEmail = email.lowercased()
        
        let requestHeader = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        let body:[String:Any] = [
            "email":lowerCaseEmail,
            "password":password
        ]
        
        Alamofire.request(REGISTER_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: requestHeader).responseString { (response) in
            
            if response.result.error == nil {
                completion(true)
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
        
    }
    
    
    
    
}



