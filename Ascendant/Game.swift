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
    
    static var currentGame: Game?
    
    var players = [Player]() {
        didSet {
            // Make sure no duplicates
            players = Array(Set(players))
        }
    }
    
    var creator = false
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
        self.players = [player]
        
        if let players: [Player] = "players" <~~ json {
            self.players.appendContentsOf(players)
        }
        
        Game.currentGame = self
    }
    
    func proposeMissionWithLeader(leader: Player, missionNumber: Int) {
        delegate?.game(setMissionStatus: .Current, forMission: missionNumber)
        delegate?.game(havePlayerProposeMission: leader)
    }
    
    func voteOnProposalWithPlayers(players: [Player]) {
        delegate?.game(voteOnProposalWithPlayers: players)
    }
    
    func proposalVoteResult(result: ProposalResult) {
        switch result {
        case .Passed(let players):  delegate?.game(voteOnMissionWithPlayers: players)
        case .Failed(let failed):   delegate?.game(setNumberOfFailedProposals: failed)
        }
    }
    
    func missionVoteResult(result: MissionResult) {
        delegate?.game(setMissionStatus: result.passed ? .Success : .Fail, forMission: result.missionNumber)
    }
}
