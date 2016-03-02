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
    let numberFailedProposals: Int
    
    init?(json: JSON) {
        
        guard let
            pass: Bool = "pass" <~~ json,
            voteValues: [String: Bool] = "votes" <~~ json,
            missionMemberIDs: [String] = "players" <~~ json,
            numberFailedProposals: Int = "failed_proposals" <~~ json,
            players = Game.currentGame?.players
        else {
            return nil
        }
        
        let votes = players.flatMap { player -> (player: Player, value: Bool)? in
            guard let vote = voteValues[player.id] else { return nil }
            return (player, vote)
        }
        
        let members = missionMemberIDs.flatMap { id in
            players.filter({ $0.id == id }).first
        }
        
        if votes.count != players.count || members.count != missionMemberIDs.count {
            return nil
        }
        
        self.numberFailedProposals = numberFailedProposals
        self.missionMembers = members
        self.pass = pass
        self.votes = votes
    }
}
