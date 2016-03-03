//
//  AppDelegate.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Fabric.with([Crashlytics.self])
        
        // Set a default theme
        NSUserDefaults.standardUserDefaults().registerDefaults(["Theme": 0])
        
        // Set up appearance proxies
        Theme.setAppearances()
        
        // Connect the socket
        Socket.manager.connect()
        
        print(AppDelegate.configuration)
        
        return true
    }
    
    // Handle 3D Touch shortcuts
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        
        // Check that we're not in a game, and safely get the root vc
        if Game.currentGame == nil, let welcomeViewController = window?.rootViewController as? WelcomeViewController {
            
            // Dismiss any view controllers on welcome
            welcomeViewController.dismissViewControllerAnimated(false, completion: nil)
 
            // Check the shortcut and present the appropiate view controller
            if shortcutItem.type == "space.ascendant.Ascendant.creategame" {
                welcomeViewController.presentViewController(R.storyboard.welcome.startNavigationController()!, animated: false, completion: nil)
            }
            else if shortcutItem.type == "space.ascendant.Ascendant.joingame" {
                welcomeViewController.presentViewController(R.storyboard.welcome.joinNavigationController()!, animated: false, completion: nil)
            }
        }
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        
        NSLog("Became active with socket status: \(Socket.manager.status.description)")
        
        if Socket.manager.status != .Connected
            && Socket.manager.status != .Connecting
            && Socket.manager.status != .Reconnecting
        {
            Socket.manager.reconnect()
        }
        
        // Let's make sure we got the latest action done
        if let gameViewController = window?.rootViewController?.presentedViewController as? GamePlayViewController {
            if !gameViewController.showingAction {
                Socket.manager.getCurrentAction(gameViewController.game)
            }
        }
    }
}

extension AppDelegate {
    static var configuration: Configuration {
        return Configuration(rawValue: NSBundle.mainBundle().infoDictionary!["Configuration"] as! String)!
    }
}

enum Configuration: String {
    case Develop
    case Staging
    case Release
}
