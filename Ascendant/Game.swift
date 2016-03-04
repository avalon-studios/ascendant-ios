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
            players = Array(Set(players))
            NSNotificationCenter.defaultCenter().postNotificationName(Socket.updatedPlayers, object: nil)
        }
    }
    
    var creator: Bool {
        return player.id == creatorID
    }
    
    var player: Player
    var id: String
    var creatorID: String
    
    var roundPasses = [Bool]()
    var numberFailedProposals = 0
    var rejoin = false
    var ready = false
    
    init?(json: JSON) {
        
        guard let
            id: String = "game_id" <~~ json,
            player: Player = "player" <~~ json,
            creatorID: String = "creator_id" <~~ json
        else {
            return nil
        }
        
        self.id = id
        self.player = player
        self.creatorID = creatorID
        self.players = [player]

        if let rejoin: Bool = "rejoin" <~~ json {
            self.rejoin = rejoin
        }

        if let ready: Bool = "ready" <~~ json {
            self.ready = ready
        }
        
        if let players: [Player] = "players" <~~ json {
            self.players = players
        }
        
        if let roundPasses: [Bool] = "round_passes" <~~ json {
            self.roundPasses = roundPasses
        }
        if let numberFailedProposals: Int = "failed_proposals" <~~ json {
            self.numberFailedProposals = numberFailedProposals
        }
        
        NSUserDefaults.lastUsedID = player.id
        Game.currentGame = self
    }
    
    func proposeMissionWithLeader(leader: Player, missionNumber: Int, numberPlayers: Int) {
        delegate?.game(setMissionStatus: .Current, forMission: missionNumber)
        delegate?.game(havePlayerProposeMission: leader, withNumberOfRequiredPlayers: numberPlayers)
    }
    
    func voteOnProposalWithPlayers(players: [Player]) {
        delegate?.game(voteOnProposalWithPlayers: players)
    }
    
    func proposalVoteResult(result: ProposalResult) {
        
        delegate?.game(setNumberOfFailedProposals: result.numberFailedProposals)
        delegate?.game(showProposalVotingResult: result)
    }
    
    func missionVoteResult(result: MissionResult) {
        delegate?.game(setMissionStatus: result.passed ? .Success : .Fail, forMission: result.missionNumber)
    }
    
    func voteOnMissionWithPlayers(players: [Player]) {
        delegate?.game(voteOnMissionWithPlayers: players)
    }
}
