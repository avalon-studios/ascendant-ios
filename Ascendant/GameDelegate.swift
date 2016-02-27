//
//  GameDelegate.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/23/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation

protocol GameDelegate: class {
    func game(voteOnProposalWithPlayers players: [Player])
    func game(voteOnMissionWithPlayers players: [Player])
    func game(havePlayerProposeMission player: Player)
    func game(setNumberOfFailedProposals failed: Int)
    func game(setMissionStatus status: MissionStatus, forMission missionNumber: Int)
}
