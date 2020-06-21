//
//  CreateAccountVC.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 20.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    
    // Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    // Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName) // From the Avatar Picker VC
            avatarName = UserDataService.instance.avatarName
        }
    }
    
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        guard let name = usernameTxt.text, usernameTxt.text != "" else {return}
        guard let email = emailTxt.text, emailTxt.text != "" else {return}
        guard let pass = passTxt.text, passTxt.text != "" else {return}
        
        // Register, Login and Create User Chain Requests
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("Success1")
                AuthService.instance.loginUser(email: email, password: pass) { (success) in
                    if success {
                        print("Success2")
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor) { (success) in
                            if success {
                                print("Success3")
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
                            }
                        }
                    }
                    
                }
            }
        }
        
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        
        // when pressed the close button (exit segue)
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        
    }
    
    
    
    
    
}
