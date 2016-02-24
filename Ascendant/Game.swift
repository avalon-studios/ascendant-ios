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
    
    let player: Player
    let id: String
    
    var players = [Player]() {
        didSet {
            delegate?.game(updatePlayers: players)
        }
    }
    
    init?(json: JSON) {
        
        guard let id: String = "id" <~~ json, player: Player = "player" <~~ json else {
            return nil
        }
        
        self.id = id
        self.player = player
    }
    
    static func createGame(completion: (game: Game?, errorMessage: String) -> Void) {
        Socket.manager.createGame { (json, errorMessage) in
            if let json = json, game = Game(json: json) {
                completion(game: game, errorMessage: errorMessage)
            }
            else {
                completion(game: nil, errorMessage: errorMessage)
            }
        }
    }
    
    
}
