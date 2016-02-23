//
//  Player.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/23/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation

struct Player {
    let name: String
    let id: String
    let team: Team
}

enum Team {
    case good
    case bad
}
