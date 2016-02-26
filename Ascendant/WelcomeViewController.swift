//
//  ViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import ElegantPresentations

class WelcomeViewController: UIViewController, UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        setUpUI()
    }
    
    func setUpUI() {
        view.backgroundColor = UIColor.asc_baseColor()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        segue.destinationViewController.modalPresentationStyle = .Custom
        segue.destinationViewController.transitioningDelegate = self
    }
    
    @IBAction func unwindToWelcome(segue: UIStoryboardSegue) { }
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return ElegantPresentations.controller(presentedViewController: presented, presentingViewController: presenting, options: [])
    }
}
