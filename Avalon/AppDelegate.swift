//
//  AppDelegate.swift
//  Avalon
//
//  Created by Kyle Bashour on 1/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        NSUserDefaults.standardUserDefaults().setObject("Dark", forKey: Constants.Defaults.theme)
        
        let players = Array<String>(count: 5, repeatedValue: Player().playerID)
        
        print(players.jsonString)
        
        let dict: [String: AnyObject] = [
            "players": players,
            "vote": false,
            "count": 120,
            "double": 120.4
        ]
        
        print(dict.jsonString)
        
        return true
    }
}
