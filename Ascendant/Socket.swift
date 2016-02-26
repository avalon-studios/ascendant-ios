//
//  SocketManager.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import Async
import Gloss
import SocketIOClientSwift

typealias NetworkCompletion = (json: [String: AnyObject]?, errorMessage: String)  -> Void

class Socket {
    
    static let manager = Socket()
    
    let baseURL = NSURL(string: "https://ascendant-api.herokuapp.com/")!
    let options: Set<SocketIOClientOption> = [.Secure(true), .ReconnectWait(10), .Log(true), .ForceWebsockets(true)]

    private lazy var socket: SocketIOClient = SocketIOClient(socketURL: self.baseURL, options: self.options)
    
    weak var game: Game?
    
    private var createGameCompletion: (Game? -> Void)?
    
    init() {
        addSocketHandlers()
    }
    
    func connect() {
        socket.connect()
    }
    
    func createGame(playerName: String, completion: Game? -> Void) {
        createGameCompletion = completion
        socket.emitWithAck(EmitEvent.create, ["name": playerName])(timeoutAfter: 5)
        { [weak self] data in
            self?.createOrJoinGameFromData(data)
        }
    }
    
    func joinGame(gameID: String, playerName: String, completion: Game? -> Void) {
        createGameCompletion = completion
        socket.emitWithAck(EmitEvent.join, ["name": playerName, "game_id": gameID])(timeoutAfter: 5)
        { [weak self] data in
            self?.createOrJoinGameFromData(data)
        }
    }
    
    func startGame() {
        socket.emit(EmitEvent.start)
    }
    
    func proposeMission(players: [Player]) {
        socket.emit(EmitEvent.proposeMission, [["players": players.toJSONArray() ?? []]])
    }
    
    func proposalVote(vote: Bool) {
        socket.emit(EmitEvent.proposalVote, [["vote": vote]])
    }
    
    func missionVote(vote: Bool) {
        socket.emit(EmitEvent.missionVote, [["vote": vote]])
    }
    
    func addSocketHandlers() {
        
        socket.on("connect") { _ in
            print("Connected!")
        }

        socket.on(Event.updatePlayers) { [weak self] data, ack in
            guard let json = data.first as? [JSON] else { return }
            self?.game?.players = [Player].fromJSONArray(json)
        }
        
        socket.on(Event.assignRoles) { [weak self] data, ack in
            guard let
                json = data.first as? JSON,
                playerJSON = json["player"] as? JSON,
                player = Player(json: playerJSON),
                playersJSON = json["players"] as? [JSON]
            else {
                return
            }
            
            self?.game?.player = player
            self?.game?.players = [Player].fromJSONArray(playersJSON)
        }
    }
    
    func createOrJoinGameFromData(data: [AnyObject]) {
        if let json = data.first as? JSON, game = Game(json: json) {
            self.game = game
            createGameCompletion?(game)
        }
        else {
            createGameCompletion?(nil)
        }
        
        createGameCompletion = nil
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
    static let start = "start"
    static let proposeMission = "propose_mission"
    static let proposalVote = "proposal_vote"
    static let missionVote = "mission_vote"
}
