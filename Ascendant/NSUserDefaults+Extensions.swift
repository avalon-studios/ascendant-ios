//
//  NSUserDefaults+Extensions.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/28/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation

extension NSUserDefaults {
    
    static var lastUsedName: String? {
        get {
            return NSUserDefaults.standardUserDefaults().stringForKey("LastUsedName")
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "LastUsedName")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
