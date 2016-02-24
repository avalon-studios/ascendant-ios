//
//  GameManager.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/23/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation

class Game {
    
    weak var delegate: GameDelegate?
    
    let player: Player
    let id: String
    
    init(id: String, player: Player) {
        self.id = id
        self.player = player
    }
}
