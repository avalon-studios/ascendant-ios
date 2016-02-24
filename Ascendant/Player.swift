//
//  Player.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/23/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import Gloss

struct Player: PlayerDisplayable, Glossy {
    
    let name: String
    let id: String
    let team: Team
    
    var teamColor: UIColor {
        return team == .Bad ? UIColor.asc_redColor() : UIColor.asc_greenColor()
    }
    
    init(name: String, id: String, team: Team) {
        self.name = name
        self.id = id
        self.team = team
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

enum Team: Int {
    case Good
    case Bad
}
