//
//  GameManager.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/23/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import Gloss

final class Game: Decodable {
    
    weak var delegate: GameDelegate?
    weak var playerUpdatable: PlayerUpdatable?
    
    var players = [Player]() {
        didSet {
            // Make sure no duplicates
            players = Array(Set(players))
            delegate?.game(updatePlayers: players)
            playerUpdatable?.updatePlayers(players) // change this please
        }
    }
    
    var player: Player
    var id: String
    
    init?(json: JSON) {
        
        guard let
            id: String = "game_id" <~~ json,
            player: Player = "player" <~~ json
        else {
            return nil
        }
        
        self.id = id
        self.player = player
        self.players.append(player)
    }
    
    func start() {
        
    }
}
