//
//  ProposalResult.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/26/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import Gloss

struct ProposalResult: Decodable {
    
    let pass: Bool
    let votes: [(player: Player, value: Bool)]
    let missionMembers: [Player]
    
    init?(json: JSON) {
        
        guard let
            pass: Bool = "pass" <~~ json,
            voteValues: [String: Bool] = "votes" <~~ json,
            players = Game.currentGame?.players
        else {
            return nil
        }
        
        let votes = players.flatMap { player -> (player: Player, value: Bool)? in
            guard let vote = voteValues[player.id] else { return nil }
            return (player, vote)
        }
        
        if votes.count != players.count {
            return nil
        }
        
        let playersJSON: [JSON] = "players" <~~ json ?? []
        
        self.missionMembers = [Player].fromJSONArray(playersJSON)
        self.pass = pass
        self.votes = votes
    }
}
