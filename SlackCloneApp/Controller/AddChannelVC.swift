//
//  AddChannelVC.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 22.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var channelNameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let channelName = channelNameTextField.text, channelNameTextField.text != "nil" else {
            return
        }
        guard let channelDesc = descriptionTextField.text, descriptionTextField.text != "nil" else {
            return
        }
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDesc) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Kanal oluşturulamadı")
            }
        }
    }
    
    func setupView() {
        
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        channelNameTextField.attributedPlaceholder = NSAttributedString(string: "Channel Name", attributes: [NSAttributedString.Key.foregroundColor:purplePlaceHolder])
        descriptionTextField.attributedPlaceholder = NSAttributedString(string: "Channel Description", attributes: [NSAttributedString.Key.foregroundColor:purplePlaceHolder])
        
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
