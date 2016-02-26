//
//  Themable.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/26/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation

protocol Themable {
    func updateTheme()
}

enum Theme: Int {
    case Dark
    case Light
}
