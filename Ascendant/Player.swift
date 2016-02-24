//
//  Player.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/23/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

struct Player: PlayerDisplayable {
    
    let name: String
    let id: String
    let team: Team
    
    var teamColor: UIColor {
        return team == .Bad ? UIColor.asc_redColor() : UIColor.asc_greenColor()
    }
}

enum Team {
    case Good
    case Bad
}
