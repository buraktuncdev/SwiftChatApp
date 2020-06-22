//
//  SocketService.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 22.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    /* socket.on --> receive, socket.emit --> post*/
    
    static let instance = SocketService()
    
    let manager: SocketManager
    let socket: SocketIOClient
    
    // NSObject init
    override init() {
        self.manager = SocketManager(socketURL: URL(string: BASE_URL)!)
        self.socket = manager.defaultSocket
        super.init()
    }
    
    // add to AppDelegate
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(channelName:String, channelDescription:String, completion: @escaping CompletionHandler){
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler){
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return}
            
            let newChannel = Channel(_id: channelId, name: channelName, description: channelDescription)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    
    
    
    
}
