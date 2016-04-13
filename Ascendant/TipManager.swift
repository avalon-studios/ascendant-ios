//
//  TipManager.swift
//  Ascendant
//
//  Created by Kyle Bashour on 4/8/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import AMPopTip

// A caseless enum, so it can't be instantiated
enum TipManager {

    private static let defaults = NSUserDefaults.standardUserDefaults()

    private struct keys {
        static let prompted = "prompted"
    }

    static var prompted: Bool {
        get {
            return defaults.boolForKey(keys.prompted)
        }
        set {
            defaults.setBool(newValue, forKey: keys.prompted)
        }
    }

    static func tipFactory() -> AMPopTip {

        let tip = AMPopTip()

        tip.textColor = Theme.asc_defaultTextColor()
        tip.popoverColor = Theme.asc_baseColor()
        tip.borderColor = Theme.asc_separatorColor()
        tip.borderWidth = 1
        tip.actionAnimation = .Float
        tip.offset = 8
        tip.entranceAnimation = .FadeIn
        tip.actionAnimationIn = 2
        tip.actionAnimationOut = 3

        return tip
    }
}
