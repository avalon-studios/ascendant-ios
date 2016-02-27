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

    
    // MARK: - Outlets
    
    @IBOutlet var startGameButton: AscendantButton!
    @IBOutlet var joinGameButton: AscendantButton!
    @IBOutlet var rulesButton: AscendantButton!
    @IBOutlet var settingsButton: AscendantButton!
    
    
    // MARK: — Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        updateTheme()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Register for theme updates
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateTheme), name: Theme.notificationName, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Deregister for theme updates
        NSNotificationCenter.defaultCenter().removeObserver(self, name: Theme.notificationName, object: nil)
    }
    
    func updateTheme() {
        view.backgroundColor = Theme.asc_baseColor()
        
        [startGameButton, joinGameButton, rulesButton, settingsButton].forEach {
            $0.backgroundColor = Theme.asc_transparentWhiteColor()
            $0.setTitleColor(Theme.asc_textColor(), forState: .Normal)
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
        switch Theme.theme {
        case .Dark:     return .LightContent
        case .Light:    return .Default
        }
    }
}
