//
//  Player.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/23/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import Gloss

struct Player: PlayerDisplayable, Glossy, Hashable {
    
    let name: String
    let id: String
    let team: Team
    
    var hashValue: Int {
        return id.hashValue
    }
    
    var teamColor: UIColor {
        switch team {
        case .Bad:  return Theme.asc_redColor()
        case .Good: return Theme.asc_greenColor()
        case .None: return Theme.asc_transparentColor()
        }
    }
    
    init?(json: JSON) {
        
        guard let
            name: String = "name" <~~ json,
            id: String = "id" <~~ json,
            team: Team = "team" <~~ json
        else {
            return nil
        }
        
        self.name = name
        self.id = id
        self.team = team
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> self.name,
            "id" ~~> self.id,
            "team" ~~> self.team
        ])
    }
}

func ==(lhs: Player, rhs: Player) -> Bool {
    return lhs.id == rhs.id
}

enum Team: Int {
    case None = -1
    case Good = 0
    case Bad = 1
}
