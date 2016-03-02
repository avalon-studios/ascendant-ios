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
    
    var creator = false
    var player: Player
    var id: String
    
    var numberFailedProposals = 0
    
    init?(json: JSON) {
        
        guard let
            id: String = "game_id" <~~ json,
            player: Player = "player" <~~ json
        else {
            return nil
        }
        
        self.id = id
        self.player = player
        
        if let players: [Player] = "players" <~~ json {
            self.players.appendContentsOf(players)
        }
        
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
        
        numberFailedProposals = result.pass ? 0 : numberFailedProposals + 1
        
        delegate?.game(setNumberOfFailedProposals: numberFailedProposals)
        delegate?.game(showProposalVotingResult: result)
    }
    
    func missionVoteResult(result: MissionResult) {
        delegate?.game(setMissionStatus: result.passed ? .Success : .Fail, forMission: result.missionNumber)
    }
    
    func voteOnMissionWithPlayers(players: [Player]) {
        delegate?.game(voteOnMissionWithPlayers: players)
    }
}
