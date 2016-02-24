//
//  JoinViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class JoinViewController: WelcomeBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    func setUpUI() {
        view.backgroundColor = UIColor.asc_baseColor()
    }
}
