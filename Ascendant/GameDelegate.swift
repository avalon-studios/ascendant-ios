//
//  GameDelegate.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/23/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation

protocol GameDelegate: class {
    func gameVoteOnProposal(players: [Player])
    func gameVoteOnMission(players: [Player])
    func gameProposeMission()
    func gameSetFailedProposals(failed: Int)
    func gameSetMissionStatus(status: MissionStatus, missionNumber: Int)
}
