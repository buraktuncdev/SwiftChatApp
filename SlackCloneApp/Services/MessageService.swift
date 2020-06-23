//
//  MessageService.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 22.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel : Channel?
    
    
    func findAllChannel(completion: @escaping CompletionHandler){
        
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                guard let data = response.data else {
                    return
                }
                
                // Json Parsing with Decodable Model
                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                } catch let error {
                    debugPrint(error as Any)
                }
                NotificationCenter.default.post(name: NOTIFC_CHANNELS_LOADED, object: nil)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
    }
    
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler){
        
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else {
                    return
                }
                if let json = JSON(data: data).array {
                    for item in json {
                        
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let id = item["_id"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timestamp = item["timestamp"].stringValue
                        
                        // Init Message
                        let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timestamp: timestamp)
                        self.messages.append(message)
                    }
                    print(self.messages)
                    completion(true)
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
            
        }
        
        
    }
    
    // When Log out
    func clearMessages() {
        messages.removeAll()
    }
    
    // When log out
    func clearChannels() {
        channels.removeAll()
    }
}


//        This is the old version JSON Parsing with SwiftyJSON.
//                if let json = JSON(data: data).array {
//                    for item in json {
//                        let name = item["name"].stringValue
//                        let channelDescription = item["description"].stringValue
//                        let id = item["_id"].stringValue
//
//                        let channel = Channel(id: id, channelTitle: name, channelDescription: channelDescription)
//                        self.channels.append(channel)
//                    }
//                    completion(true)
//                }
