//
//  ChatVC.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 18.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//

import UIKit
import SWRevealViewController

class ChatVC: UIViewController{
    
    // Variables
    let messageTextFieldDelegate = MessageTextFieldDelegate()
    
    
    
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    
    
    func setupTextFieldConfig(toTextField textField: UITextField) {
        textField.delegate = messageTextFieldDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Message Text Field Configs
        self.setupTextFieldConfig(toTextField: messageTextField)
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        subscribeToKeyboardShowNotifications()
        
        
        // Menu Button Config
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        // User Data and Channel Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        // Check the whether logged in
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
        
    }
    
    @IBAction func sendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?._id else { return }
            guard let message = messageTextField.text else { return }
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (success) in
                if success {
                    self.messageTextField.text = ""
                    self.messageTextField.resignFirstResponder()
                }
            }
            
        }
    }
    
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
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
        
        print("ChannelId: \(channelId)")
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success {
                print("Get Messages Success")
            } else {
                print("Get Messages Problem")
            }
        }
    }
    
    
    func subscribeToKeyboardShowNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    // MARK: Keyboard Notifications
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if(messageTextField.isFirstResponder) {
            // check the frame origin y
            if self.view.frame.origin.y == 0{
                view.frame.origin.y -= getKeyboardHeight(notification)
            }
            
        }
        
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    
    
    
    
}
