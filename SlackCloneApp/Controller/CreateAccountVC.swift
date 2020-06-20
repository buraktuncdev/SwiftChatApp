//
//  CreateAccountVC.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 20.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let email = emailTxt.text, emailTxt.text != "" else {
            return
        }
        
        guard let pass = passTxt.text, passTxt.text != "" else {
            return
        }
        
        // Register and Login
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass) { (success) in
                    if success {
                        print("Logged in User!", AuthService.instance.authToken)
                    }
                    
                }
            }
        }
        
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        
        // when pressed the close button (exit segue)
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        
    }
    
    
    
    
    
}
