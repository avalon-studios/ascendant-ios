//
//  AppDelegate.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        setUpAppearance()
        
        NSUserDefaults.standardUserDefaults().registerDefaults(["Theme": 0])
        
        Socket.manager.connect()
                
        return true
    }

    func setUpAppearance() {
        
        let navBar = UINavigationBar.appearance()
        
        navBar.translucent = false
        navBar.tintColor = UIColor.asc_textColor()
        navBar.barTintColor = UIColor.asc_darkAccentColor()
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.asc_textColor()]
        navBar.barStyle = .Black
    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        
        // Check that we're not in a game, and safely get the root vc
        if let welcomeViewController = window?.rootViewController as? WelcomeViewController {
            
            // Dismiss any view controllers on welcome
            welcomeViewController.dismissViewControllerAnimated(false, completion: nil)
            
            // For presenting whatever we need to present with the custom presentation
            func presentShortcutViewController(presented: UIViewController) {
                
                presented.modalPresentationStyle = .Custom
                presented.transitioningDelegate = welcomeViewController
                
                welcomeViewController.presentViewController(presented, animated: false, completion: nil)
            }
            
            // Check the shortcut and present the appropiate view controller
            if shortcutItem.type == "space.ascendant.Ascendant.creategame" {
                presentShortcutViewController(R.storyboard.welcome.startNavigationController()!)
            }
            else if shortcutItem.type == "space.ascendant.Ascendant.joingame" {
                presentShortcutViewController(R.storyboard.welcome.joinNavigationController()!)
            }
            
        }
    }
}
