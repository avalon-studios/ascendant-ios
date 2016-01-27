//
//  ThemeManager.swift
//  Avalon
//
//  Created by Kyle Bashour on 1/26/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

struct ThemeManager {
    
    static var theme: Theme {
        let savedTheme = NSUserDefaults.standardUserDefaults().stringForKey(Constants.Defaults.theme) ?? ""
        return Theme(rawValue: savedTheme) ?? .Light
    }
    
    static var mainBackgroundColor: UIColor {
        switch theme {
        case .Dark:     return .flatBlackColorDark()
        case .Plum:     return .flatPlumColorDark()
        case .Light:    return .whiteColor()
        }
    }
    
    static var statusBarViewColor: UIColor {
        switch theme {
        case .Dark:     return UIColor.flatBlackColorDark().darkenByPercentage(0.3)
        case .Plum:     return UIColor.flatPlumColorDark().darkenByPercentage(0.3)
        case .Light:    return .darkGrayColor()
        }
    }
    
    struct MissionStatus {
        
        static var currentMissionColor: UIColor {
            switch theme {
            case .Dark, .Plum:  return UIColor.whiteColor().colorWithAlphaComponent(0.2)
            case .Light:        return .lightGrayColor()
            }
        }
        
        static var failedMissionColor: UIColor {
            return .flatRedColor()
        }
        
        static var successfulMissionColor: UIColor {
            return .flatGreenColor()
        }
        
        static var plainNumberColor: UIColor {
            switch theme {
            case .Dark, .Plum:  return .whiteColor()
            case .Light:        return .darkGrayColor()
            }
        }
        
        static var highLightedNumberColor: UIColor {
            return .whiteColor()
        }
    }
}

enum Theme: String {
    case Dark
    case Light
    case Plum
}
