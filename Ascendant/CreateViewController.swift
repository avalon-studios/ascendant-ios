//
//  CreateViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Socket.manager.createGame { result in
            switch result {
            case .Success: self.performSegueWithIdentifier(R.segue.createViewController.startViewController, sender: self)
            case .Error(let message): print(message)
            }
        }
    }
}
