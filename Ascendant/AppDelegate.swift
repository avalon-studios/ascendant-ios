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
        
        // Set a default theme
        NSUserDefaults.standardUserDefaults().registerDefaults(["Theme": 1])
        
        // Set up appearance proxies
        setUpAppearance()
        
        // Connect the socket
        Socket.manager.connect()
                
        return true
    }

    func setUpAppearance() {
        
        let navBar = UINavigationBar.appearance()
        
        navBar.translucent = false
        navBar.tintColor = Theme.asc_navigationTintColor()
        navBar.barTintColor = Theme.asc_darkBaseColor()
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: Theme.asc_navigationTintColor()]
        navBar.barStyle = .Black
    }
    
    // Handle 3D Touch shortcuts
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        
        // Check that we're not in a game, and safely get the root vc
        if Game.currentGame == nil, let welcomeViewController = window?.rootViewController as? WelcomeViewController {
            
            // Dismiss any view controllers on welcome
            welcomeViewController.dismissViewControllerAnimated(false, completion: nil)
 
            // Check the shortcut and present the appropiate view controller
            if shortcutItem.type == "space.ascendant.Ascendant.creategame" {
                welcomeViewController.presentViewControllerCustom(R.storyboard.welcome.startNavigationController()!, animated: true, completion: nil)
            }
            else if shortcutItem.type == "space.ascendant.Ascendant.joingame" {
                welcomeViewController.presentViewControllerCustom(R.storyboard.welcome.joinNavigationController()!, animated: true, completion: nil)
            }
        }
    }
}
