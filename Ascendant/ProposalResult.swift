//
//  ProposalResult.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/26/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import Gloss

enum ProposalResult: Decodable {
    
    case Passed(votes: [(Player, Bool)])
    case Failed(votes: [(Player, Bool)], numberFailedProposals: Int)
    
    init?(json: JSON) {
        
        guard let
            pass: Bool = "pass" <~~ json,
            votesJSON: [String: Bool] = "votes" <~~ json,
            players = Game.currentGame?.players
        else {
            return nil
        }
        
        var votes = [(Player, Bool)]()
        
        // Couldn't get flatmap to work for some reason (shrug)
        for player in players {
            if let vote = votesJSON[player.id] {
                votes.append((player, vote))
            }
            else {
                return nil
            }
        }
        
        if pass {
            self = .Passed(votes: votes)
        }
        else if !pass, let failed: Int = "number_failed" <~~ json {
            self = .Failed(votes: votes, numberFailedProposals: failed)
        }
        else {
            return nil
        }
    }
}
