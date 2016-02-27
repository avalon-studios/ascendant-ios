//
//  Theme.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/26/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

struct Theme {
    
    static let notificationName = "ThemeChanged"
    
    static var theme: ThemeStyle {
        get {
            return ThemeStyle(rawValue: NSUserDefaults.standardUserDefaults().integerForKey("Theme")) ?? .Dark
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue.rawValue, forKey: "Theme")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    static func asc_baseColor() -> UIColor {
        switch Theme.theme {
        case .Dark:     return UIColor(hex: "#2C2E3D")
        case .Light:    return UIColor.whiteColor()
        }
    }
    
    static func asc_darkAccentColor() -> UIColor {
        return UIColor(hex: "#21232F")
    }
    
    static func asc_blueColor() -> UIColor {
        return UIColor(red: 0.247, green: 0.437, blue: 0.860, alpha: 1.000)
    }
    
    static func asc_redColor() -> UIColor {
        return UIColor(red: 0.742, green: 0.230, blue: 0.230, alpha: 1.000)
    }
    
    static func asc_greenColor() -> UIColor {
        return UIColor(red: 0.250, green: 0.757, blue: 0.380, alpha: 1.000)
    }
    
    static func asc_transparentWhiteColor() -> UIColor {
        switch Theme.theme {
        case .Dark:     return UIColor.whiteColor().colorWithAlphaComponent(0.2)
        case .Light:    return UIColor.blackColor().colorWithAlphaComponent(0.2)
        }
    }
    
    static func asc_separatorColor() -> UIColor {
        return UIColor(hex: "#4B4E67")
    }
    
    static func asc_textColor() -> UIColor {
        switch Theme.theme {
        case .Dark:     return UIColor.whiteColor()
        case .Light:    return UIColor.blackColor()
        }
    }
}

enum ThemeStyle: Int {
    case Dark
    case Light
}
