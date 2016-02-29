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
    let votes: [String: Bool]
    let missionMembers: [Player]
    
    init?(json: JSON) {
        
        guard let pass: Bool = "pass" <~~ json, votes: [String: Bool] = "votes" <~~ json
        where votes.keys.count == Game.currentGame?.players.count
        else {
            return nil
        }
        
        let playersJSON: [JSON] = "players" <~~ json ?? []
        
        self.missionMembers = [Player].fromJSONArray(playersJSON)
        self.pass = pass
        self.votes = votes
        
    }
}
