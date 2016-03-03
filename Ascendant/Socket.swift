//
//  SocketManager.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import Gloss
import SocketIOClientSwift

typealias SocketAckCallback = AckResult -> Void

class Socket {
    
    static let manager = Socket()
    
    static let rolesAssignedNotification = "AssignedRoles"
    static let updatedPlayers = "UpdatedPlayers"
    
    let baseURL: NSURL = {
        switch AppDelegate.configuration {
        case .Develop: return NSURL(string: "https://ascendant-api-dev.herokuapp.com/")!
        case .Staging: return NSURL(string: "https://ascendant-api-staging.herokuapp.com/")!
        case .Release: return NSURL(string: "https://ascendant-api.herokuapp.com/")!
        }
    }()
    
    let timeout: UInt64 = 2
    
    let options: Set<SocketIOClientOption> = {
        
        var options: Set<SocketIOClientOption> = [.Secure(true), .ReconnectWait(1), .ForceWebsockets(true)]

        if AppDelegate.configuration == .Develop {
            options.insert(.Log(true))
        }
        
        return options
    }()
    
    var status: SocketIOClientStatus {
        return socket.status
    }
    
    private lazy var socket: SocketIOClient = SocketIOClient(socketURL: self.baseURL, options: self.options)
    
    func connect() {
        socket.connect()
    }
    
    func reconnect() {
        socket.reconnect()
    }
    
    func createGame(playerName: String, completion: Game? -> Void) {
        
        let items = ["name": playerName]
        
        socket.emitWithAck(EmitEvent.create, items)(timeoutAfter: timeout) { [weak self] data in
            self?.createOrJoinGameFromData(data, completion: completion)
        }
    }
    
    func joinGame(gameID: String, playerName: String, completion: Game? -> Void) {

        let items = ["name": playerName, "game_id": gameID, "old_id": NSUserDefaults.lastUsedID]
        
        socket.emitWithAck(EmitEvent.join, items)(timeoutAfter: timeout) { [weak self] data in
            self?.createOrJoinGameFromData(data, completion: completion)
        }
    }
    
    func leaveGame() {
        
        guard let game = Game.currentGame else { return }
        
        let items = ["game_id": game.id, "player_id": game.player.id]
        
        socket.emitWithAck(EmitEvent.leave, items)(timeoutAfter: timeout) { _ in
            Game.currentGame = nil
        }
    }
    
    func startGame(game: Game, completion: SocketAckCallback) {
        
        let items = ["game_id": game.id, "player_id": game.player.id]
        
        socket.emitWithAck(EmitEvent.start, items)(timeoutAfter: timeout) { [weak self] data in
            self?.parseAckResult(data, completion: completion)
        }
    }
    
    func sendReady(game: Game, completion: SocketAckCallback) {
        
        let items = ["game_id": game.id, "player_id": game.player.id]
        
        socket.emitWithAck(EmitEvent.ready, items)(timeoutAfter: timeout) { [weak self] data in
            self?.parseAckResult(data, completion: completion)
        }
    }
    
    func proposeMission(game: Game, players: [Player], completion: SocketAckCallback) {
        
        let playerIDs = players.map { $0.id }
        let items = ["game_id": game.id, "player_ids": playerIDs, "player_id": game.player.id]
        
        socket.emitWithAck(EmitEvent.proposeMission, items)(timeoutAfter: timeout) { [weak self] data in
            self?.parseAckResult(data, completion: completion)
        }
    }
    
    func proposalVote(game: Game, vote: Bool, completion: SocketAckCallback) {
        
        let items = ["game_id": game.id, "player_id": game.player.id, "vote": vote]
        
        socket.emitWithAck(EmitEvent.proposalVote, items)(timeoutAfter: timeout) { [weak self] data in
            self?.parseAckResult(data, completion: completion)
        }
    }
    
    func missionVote(game: Game, vote: Bool, completion: SocketAckCallback) {
        
        let items = ["game_id": game.id, "player_id": game.player.id, "vote": vote]
        
        socket.emitWithAck(EmitEvent.missionVote, items)(timeoutAfter: timeout) { [weak self] data in
            self?.parseAckResult(data, completion: completion)
        }
    }
    
    func getCurrentAction(game: Game) {
        
        let items = ["game_id": game.id, "player_id": game.player.id]
        
        socket.emit(EmitEvent.getCurrentAction, items)
    }
    
    // NOT DONE:
    
    func addHandlersForGame(game: Game) {
        
        socket.removeAllHandlers()

        socket.on(Event.updatePlayers) { data, ack in
            
            guard let json = data.first as? [JSON] else {
                return
            }
            
            game.players = [Player].fromJSONArray(json)
        }
        
        socket.on(Event.assignRoles) { data, ack in
            
            guard let
                json = data.first as? JSON,
                playerJSON = json["player"] as? JSON,
                player = Player(json: playerJSON),
                playersJSON = json["players"] as? [JSON]
            else {
                return
            }
            
            game.player = player
            game.players = [Player].fromJSONArray(playersJSON)
            
            NSNotificationCenter.defaultCenter().postNotificationName(Socket.rolesAssignedNotification, object: nil)
        }
        
        socket.on(Event.proposeMission) { data, ack in
            
            guard let
                json = data.first as? JSON,
                leaderJSON = json["leader"] as? JSON,
                leader = Player(json: leaderJSON),
                missionNumber = json["mission_number"] as? Int,
                numberPlayers = json["number_players"] as? Int
            else {
                return
            }
            
            game.proposeMissionWithLeader(leader, missionNumber: missionNumber, numberPlayers: numberPlayers)
        }
        
        socket.on(Event.proposalVote) { data, ack in
            
            guard let json = data.first as? JSON, playerIDs = json["players"] as? [String] else {
                return
            }
            
            let players = game.players.filter { playerIDs.contains($0.id) }
            
            game.voteOnProposalWithPlayers(players)
        }
        
        socket.on(Event.proposalVoteResult) { data, ack in
            
            guard let
                json = data.first as? JSON,
                result = ProposalResult(json: json)
            else {
                return
            }
            
            game.proposalVoteResult(result)
        }
        
        socket.on(Event.missionVoteResult) { data, ack in
            
            guard let
                json = data.first as? JSON,
                result = MissionResult(json: json)
            else {
                    return
            }
            
            game.missionVoteResult(result)
        }
    }
    
    func createOrJoinGameFromData(data: [AnyObject], completion: Game? -> Void) {
        if let json = data.first as? JSON, game = Game(json: json) {
            
            addHandlersForGame(game)
            
            completion(game)
        }
        else {
            completion(nil)
        }
    }
    
    func parseAckResult(data: [AnyObject], completion: SocketAckCallback) {
        if let json = data.first as? JSON, result = AckResult(json: json) {
            completion(result)
        }
        else {
            completion(.Error(message: "Unknown Error"))
        }
    }
}

struct Event {
    static let create = "create"
    static let join = "join"
    static let updatePlayers = "update_players"
    static let start = "start"
    static let assignRoles = "assign_roles"
    static let proposeMission = "propose_mission"
    static let proposalVote = "do_proposal_vote"
    static let proposalVoteResult = "proposal_vote_result"
    static let missionVoteResult = "mission_vote_result"
}

struct EmitEvent {
    static let create = "create"
    static let join = "join"
    static let leave = "leave"
    static let start = "start"
    static let ready = "ready"
    static let proposeMission = "propose_mission"
    static let proposalVote = "proposal_vote"
    static let missionVote = "mission_vote"
    static let getCurrentAction = "get_current_action"
}
