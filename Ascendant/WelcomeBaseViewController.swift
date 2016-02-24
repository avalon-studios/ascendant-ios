//
//  WelcomeBaseViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/24/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class WelcomeBaseViewController: UIViewController {
    
    weak var pageController: WelcomePageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(showWelcome))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let source = segue.sourceViewController as? WelcomeBaseViewController, dest = segue.destinationViewController as? WelcomeBaseViewController {
            dest.pageController = source.pageController
        }
    }
    
    @objc func showWelcome() {
        pageController.showWelcome(true)
    }
}