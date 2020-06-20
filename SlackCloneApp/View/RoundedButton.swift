//
//  RoundedButton.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 20.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
  
    override func prepareForInterfaceBuilder() {
        self.awakeFromNib()
        self.setupView()
    }
    
    func setupView() {
          self.layer.cornerRadius = cornerRadius
      }
      
      
    
    
    
    
}
