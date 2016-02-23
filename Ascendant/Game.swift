//
//  GameManager.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/23/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation

class Game {
    
    static let manager = Game()
    
    weak var delegate: GameDelegate?
    
    var currentPlayer = Player(name: "Kyle", id: "1", team: .bad)
}
