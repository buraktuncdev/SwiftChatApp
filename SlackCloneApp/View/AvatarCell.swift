//
//  AvatarCell.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 21.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//

import UIKit

enum AvatarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    
    func configureCell(index: Int, typeOfAvatar:AvatarType){
        if typeOfAvatar == AvatarType.dark {
            avatarImage.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        } else {
            avatarImage.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }
    
    func setupView() {
        self.layer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
