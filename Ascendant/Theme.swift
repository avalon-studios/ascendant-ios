//
//  Theme.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/26/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import MessageUI

struct Theme {
        
    static var theme: ThemeStyle {
        get {
            return ThemeStyle(rawValue: NSUserDefaults.standardUserDefaults().integerForKey("Theme")) ?? .Dark
        }
        set {
            
            NSUserDefaults.standardUserDefaults().setInteger(newValue.rawValue, forKey: "Theme")
            NSUserDefaults.standardUserDefaults().synchronize()
            Theme.setAppearances()
        }
    }
    
    static func asc_baseColor() -> UIColor {
        switch Theme.theme {
        case .Dark:     return UIColor(hex: "2C2E3D")
        case .Medium:   return UIColor(hex: "7B8294")
        case .Light:    return UIColor(hex: "F5F5F5")
        }
    }
    
    static func asc_darkBaseColor() -> UIColor {
        switch Theme.theme {
        case .Dark:     return UIColor(hex: "21232F")
        case .Medium:   return UIColor(hex: "61687C")
        case .Light:    return UIColor(hex: "6599F2")
        }
    }
    
    static func asc_blueColor() -> UIColor {
        switch Theme.theme {
        case .Dark:     return UIColor(hex: "3F6FDB")
        case .Medium:   return UIColor(hex: "56B7F2")
        case .Light:    return UIColor(hex: "6599F2")
        }
    }
    
    static func asc_redColor() -> UIColor {
        switch Theme.theme {
        case .Dark:     return UIColor(hex: "C94242")
        case .Medium:   return UIColor(hex: "FB6653")
        case .Light:    return UIColor(hex: "F54A4A")
        }
    }
    
    static func asc_greenColor() -> UIColor {
        switch Theme.theme {
        case .Dark:     return UIColor(hex: "40C760")
        case .Medium:   return UIColor(hex: "99E04C")
        case .Light:    return UIColor(hex: "7ACF40")
        }
    }
    
    static func asc_transparentColor() -> UIColor {
        switch Theme.theme {
        case .Dark:     return UIColor.whiteColor().colorWithAlphaComponent(0.2)
        case .Medium:   return UIColor.whiteColor().colorWithAlphaComponent(0.2)
        case .Light:    return UIColor.blackColor().colorWithAlphaComponent(0.4)
        }
    }
    
    static func asc_separatorColor() -> UIColor {
        switch Theme.theme {
        case .Dark:     return UIColor.whiteColor().colorWithAlphaComponent(0.2)
        case .Medium:   return UIColor.whiteColor().colorWithAlphaComponent(0.4)
        case .Light:    return UIColor.blackColor().colorWithAlphaComponent(0.2)
        }
    }
    
    static func asc_defaultTextColor() -> UIColor {
        switch Theme.theme {
        case .Dark:     return UIColor.whiteColor()
        case .Medium:   return UIColor.whiteColor()
        case .Light:    return UIColor.darkGrayColor()
        }
    }
    
    static func asc_buttonTextColor() -> UIColor {
        switch Theme.theme {
        case .Dark, .Medium, .Light: return UIColor.whiteColor()
        }
    }
    
    static func asc_navigationTintColor() -> UIColor {
        switch Theme.theme {
        case .Dark, .Medium, .Light: return UIColor.whiteColor()
        }
    }
    
    static func cellBackgroundColor() -> UIColor {
        switch Theme.theme {
        case .Dark:     return UIColor.blackColor().colorWithAlphaComponent(0.1)
        case .Medium:   return UIColor.whiteColor().colorWithAlphaComponent(0.1)
        case .Light:    return UIColor.whiteColor()
        }
    }
    
    static func cellHighlightColor() -> UIColor {
        switch Theme.theme {
        case .Dark:     return UIColor.whiteColor().colorWithAlphaComponent(0.1)
        case .Medium:   return UIColor.blackColor().colorWithAlphaComponent(0.1)
        case .Light:    return UIColor.blackColor().colorWithAlphaComponent(0.1)
        }
    }
    
    static func asc_keyboardAppearance() -> UIKeyboardAppearance {
        switch Theme.theme {
        case .Dark:             return .Dark
        case .Medium, .Light:   return .Light
        }
    }
    
    static func asc_statusBarStyle() -> UIStatusBarStyle {
        switch Theme.theme {
        case .Dark, .Medium:    return .LightContent
        case .Light:            return .Default
        }
    }
    
    static func setAppearances() {
        
        let navBar = UINavigationBar.appearance()
        
        navBar.translucent = false
        navBar.tintColor = Theme.asc_navigationTintColor()
        navBar.barTintColor = Theme.asc_darkBaseColor()
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: Theme.asc_navigationTintColor()]
        navBar.barStyle = .Black
        
        UILabel.appearanceWhenContainedInInstancesOfClasses([SettingsViewController.self]).textColor = Theme.asc_defaultTextColor()

        UITableViewCell.appearanceWhenContainedInInstancesOfClasses([SettingsViewController.self]).backgroundColor = Theme.cellBackgroundColor()
    }
    
    static func setAppearanceForMail() {
        
        let navBar = UINavigationBar.appearance()
        
        navBar.translucent = true
        navBar.tintColor = UIColor.blueColor()
        navBar.barTintColor = UIColor.whiteColor()
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        navBar.barStyle = .Default
    }
}

enum ThemeStyle: Int {
    case Dark = 0
    case Medium = 1
    case Light = 2
}
