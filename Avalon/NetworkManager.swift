//
//  SocketDelegate.swift
//  Avalon
//
//  Created by Kyle Bashour on 1/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import Starscream

class NetworkManager: WebSocketDelegate {
    
    private var socket = WebSocket(url: NSURL(string: Constants.Web.endpoint)!)
    
    var connected: Bool {
        return socket.isConnected
    }
    
    var gameDelegate: GameDelegate?
    
    init() {
        socket.connect()
    }
    
    func websocketDidConnect(socket: WebSocket) {
        
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: NSData) {
        
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        
    }
    
    func proposeMission(players: [Player]) {
        print(players.jsonString)
    }
}
