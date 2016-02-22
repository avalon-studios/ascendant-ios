//
//  User.swift
//  Avalon
//
//  Created by Kyle Bashour on 1/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import Mapper

struct Player {
    
    let playerID: String
    let displayName: String
    let type: PlayerType
    let specialType: SpecialType?
    
    init() {
        self.playerID = "1234abc"
        self.displayName = "Elliot"
        self.type = .Knight
        self.specialType = nil
    }
}

enum PlayerType: String {
    case Knight
    case EvilMinion
}

enum SpecialType: String {
    case Percival   // Intern
    case Merlin     // Technician
    case Mordred    // Mutineer Leader
    case Oberon     // Discontent Cadet?
    case Morgana    // Intern 2?
}
