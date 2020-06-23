//
//  MessageTextFieldDelegate.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 23.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//

import Foundation
import UIKit


class MessageTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    
    // When users click the return button this method runs
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
   
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    
    
    
   
}
