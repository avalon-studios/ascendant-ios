//
//  RefreshViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/29/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class RefreshViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clearColor()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return Theme.asc_statusBarStyle()
    }
}
