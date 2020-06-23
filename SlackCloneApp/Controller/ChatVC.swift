//
//  ChatVC.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 18.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//

import UIKit
import SWRevealViewController

class ChatVC: UIViewController {
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
               
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        } 
        
        
        
    }
    
    @objc func channelSelected(_ notif: Notification){
        updateWithChannel()
    }
    
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
        channelNameLabel.text = "#\(channelName)"
        getMessages()
    }
    
    @objc func userDataDidChange(_ notif:Notification) {
        if AuthService.instance.isLoggedIn {
            // get Channels
           OnLoginGetMessages()
        } else {
            channelNameLabel.text = "Please Log In"
        }
    }
    
    func OnLoginGetMessages(){
        MessageService.instance.findAllChannel { (success) in
            if success {
                // Do stuff with channels
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLabel.text = "No Channels Yet"
                }
            }
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?._id else {
            return
        }
        
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success {
                print("Get Messages Success")
            } else {
                print("Get Messages Problem")
            }
        }
    }
    
    
    
}
