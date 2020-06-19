//
//  CreateAccountVC.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 20.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        
        // when pressed the close button (exit segue)
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    
    
    
    
    
}
