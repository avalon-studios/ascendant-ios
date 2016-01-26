//
//  User.swift
//  Avalon
//
//  Created by Kyle Bashour on 1/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import Mapper

struct Player: Mappable {
    
    let playerID: String
    let displayName: String
    let type: PlayerType
    let specialType: SpecialType?
    
    init(map: Mapper) throws {
        try playerID = map.from("id")
        try displayName = map.from("display_name")
        try type = map.from("player_type")
        try specialType = map.from("special_type")
    }
    
    init() {
        self.playerID = "1234"
        self.displayName = "John Smith"
        self.type = .Knight
        self.specialType = nil
    }
}

enum PlayerType: String {
    case Knight
    case EvilMinion
}

enum SpecialType: String {
    case Percival
    case Merlin
    case Mordred
    case Oberon
    case Morgana
}
