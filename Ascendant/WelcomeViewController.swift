//
//  ViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import ElegantPresentations

class WelcomeViewController: UIViewController, Themable, UIViewControllerTransitioningDelegate {

    
    @IBOutlet weak var startGameButton: AscendantButton!
    @IBOutlet weak var joinGameButton: AscendantButton!
    @IBOutlet weak var rulesButton: AscendantButton!
    @IBOutlet weak var settingsButton: AscendantButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        updateTheme()
    }
    
    func updateTheme() {
        view.backgroundColor = UIColor.asc_baseColor()
        
        [startGameButton, joinGameButton, rulesButton, settingsButton].forEach {
            $0.backgroundColor = UIColor.asc_transparentWhiteColor()
            $0.setTitleColor(UIColor.asc_textColor(), forState: .Normal)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        segue.destinationViewController.modalPresentationStyle = .Custom
        segue.destinationViewController.transitioningDelegate = self
    }
    
    @IBAction func unwindToWelcome(segue: UIStoryboardSegue) {
        segue.sourceViewController.view.endEditing(true)
    }
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return ElegantPresentations.controller(presentedViewController: presented, presentingViewController: presenting, options: [])
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        switch UIColor.theme {
        case .Dark:     return .LightContent
        case .Light:    return .Default
        }
    }
}
