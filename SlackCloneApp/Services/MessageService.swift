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
                print(self.channels)
                completion(true)
                
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
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
    }
    
}


