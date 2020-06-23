//
//  MessageCell.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 23.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        
    }

    func configureCell(message:Message){
        messageLabel.text = message.message
        userNameLabel.text = message.userName
        userImage.image = UIImage(named: message.userAvatar)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        timestampLabel.text = message.timestamp
    }

}
