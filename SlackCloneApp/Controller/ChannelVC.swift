//
//  ChannelVC.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 18.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

   
    // Outlets
    @IBOutlet weak var loginButton: UIButton!
    
    // Unwind Segue Implementation
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 70
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
       // segue toLogin
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
    
}
