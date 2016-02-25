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
}
