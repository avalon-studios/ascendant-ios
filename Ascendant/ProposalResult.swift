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
    
    case Passed(votingPlayers: [Player])
    case Failed(failedProposals: Int)
    
    init?(json: JSON) {
        
        guard let result: Bool = "proposal_vote_result" <~~ json else {
            return nil
        }
        
        if result, let players: [Player] = "players" <~~ json {
            self = .Passed(votingPlayers: players)
        }
        else if !result, let failed: Int = "number_failed" <~~ json {
            self = .Failed(failedProposals: failed)
        }
        else {
            return nil
        }
    }
}
