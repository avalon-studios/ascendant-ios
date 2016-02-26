//
//  UIColor+Extensions.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/24/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var theme: Theme {
        get {
            return Theme(rawValue: NSUserDefaults.standardUserDefaults().integerForKey("Theme")) ?? .Dark
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue.rawValue, forKey: "Theme")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    static func asc_baseColor() -> UIColor {
        switch UIColor.theme {
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
        switch UIColor.theme {
        case .Dark:     return UIColor.whiteColor().colorWithAlphaComponent(0.2)
        case .Light:    return UIColor.blackColor().colorWithAlphaComponent(0.2)
        }
    }
    
    static func asc_separatorColor() -> UIColor {
        return UIColor(hex: "#4B4E67")
    }
    
    static func asc_textColor() -> UIColor {
        switch UIColor.theme {
        case .Dark:     return UIColor.whiteColor()
        case .Light:    return UIColor.blackColor()
        }
    }
}

//
//  UIColorExtension.swift
//  UIColor-Hex-Swift
//
//  Created by R0CKSTAR on 6/13/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

extension UIColor {
    
    public convenience init(hex hexString: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        let index   = hexString.hasPrefix("#") ? hexString.startIndex.advancedBy(1) : hexString.startIndex
        
        let hex     = hexString.substringFromIndex(index)
        let scanner = NSScanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        
        if scanner.scanHexLongLong(&hexValue) {
            switch (hex.characters.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                break
            }
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
