//
//  ViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class WelcomeViewController: WelcomeBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        setUpUI()
    }
    
    func setUpUI() {
        view.backgroundColor = UIColor.asc_baseColor()
    }
    
    @IBAction func startGamePressed(sender: AnyObject) {
        pageController.showCreateGame()
    }
    
    @IBAction func joinGamePressed(sender: AnyObject) {
        pageController.showJoinGame()
    }
    
    
}
