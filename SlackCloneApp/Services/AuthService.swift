//
//  AuthService.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 20.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

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
        
        let body:[String:Any] = [
            "email":lowerCaseEmail,
            "password":password
        ]
        
        Alamofire.request(REGISTER_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: REQUEST_HEADER).responseString { (response) in
            
            if response.result.error == nil {
                completion(true)
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
        
    }
    
    // Login Function with Completion Handler and SwiftyJSON
    func loginUser(email:String, password: String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        
        let body:[String:Any] = [
            "email":lowerCaseEmail,
            "password":password
        ]
        
        // MARK: Parse  with SwiftyJSON
        Alamofire.request(LOGIN_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: REQUEST_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                
                guard let data = response.data else {return}
                let json = JSON(data: data)
                self.userEmail = json["user"].stringValue  // SwiftyJSON automatically unwrapped for us.
                self.authToken = json["token"].stringValue // SwiftyJSON automatically unwrapped for us.
                
                self.isLoggedIn = true
                completion(true)
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
        /* //json parse manuel
         Alamofire.request(LOGIN_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: REQUEST_HEADER).responseJSON { (response) in
         if response.result.error == nil {
         if let json = response.result.value as? Dictionary<String,Any> {
         if let email = json["user"] as? String {
         self.userEmail = email
         }
         if let token = json["token"] as? String {
         self.authToken = token
         }
         }
         self.isLoggedIn = true
         completion(true)
         }
         else {
         completion(false)
         debugPrint(response.result.error as Any)
         }
         }
         */
        
    }
    
    
    // Create User with Request Header as Authorization (Bearer token)
    func createUser(name:String, email:String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        
        let body:[String:Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        let authHeader = [
            "Authorization": "Bearer \(AuthService.instance.authToken)",
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        
        Alamofire.request(CREATE_USER_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: authHeader).responseJSON { (response) in
            
            if response.result.error == nil {
                
                // SwiftyJSON Parse
                
                guard let data = response.data else {return}
                let json = JSON(data: data)
                let id = json["_id"].stringValue  // SwiftyJSON automatically unwrapped for us.
                let color = json["color"].stringValue
                let avatarName = json["avatarName"].stringValue
                let email = json["email"].stringValue
                let name = json["name"].stringValue
                
                UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
                completion(true)
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
        
        
    }
    
    
    
}




