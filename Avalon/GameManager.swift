//
//  GameManager.swift
//  Avalon
//
//  Created by Kyle Bashour on 1/24/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation

struct GameManager: GameDelegate {

    let currentGameID: String
    let myPlayer: Player
    
    var allPlayers = [Player]()
    var currentLeader: Player?
    var numberOfRequiredPlayersForCurrentMission: Int
    var currentMission = 0
    var completedMissions = [Bool]()
}
