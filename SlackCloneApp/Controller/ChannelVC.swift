//
//  ChannelVC.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 18.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    // Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userImage: CircleImage!
    
    @IBOutlet weak var tableView: UITableView!
    
    // Unwind Segue Implementation
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 70
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChanged(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            // show profile page
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            // segue toLogin
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @objc func userDataDidChanged(_ notif:Notification) {
        setupUserInfo()
    }
    
    // XIB file as View Controller
    @IBAction func addChannelButtonPressed(_ sender: Any) {
        let addChannelVC = AddChannelVC()
        addChannelVC.modalPresentationStyle = .custom
        present(addChannelVC, animated: true, completion: nil)
    }
    
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginButton.setTitle(UserDataService.instance.name, for: .normal)
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginButton.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = .clear
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
}
