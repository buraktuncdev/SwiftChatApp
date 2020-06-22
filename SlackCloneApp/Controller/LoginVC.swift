//
//  LoginVCViewController.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 19.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        guard let email = usernameTextField.text , usernameTextField.text != "" else {
            return
        }
        
        guard let password = passwordTextField.text , passwordTextField.text != "" else {
            return
        }
        
        // MARK: Login User
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.findUserByEmail { (success) in
                    if success {
                        // Post Logged In Notification
                        NotificationCenter.default.post(name:NOTIF_USER_DATA_DID_CHANGE, object:nil)
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
        
        
        
    }
    
    func setupView() {
        activityIndicator.isHidden = true
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor:purplePlaceHolder])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "pasword", attributes: [NSAttributedString.Key.foregroundColor:purplePlaceHolder])
    }
}
