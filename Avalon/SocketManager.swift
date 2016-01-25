//
//  SocketDelegate.swift
//  Avalon
//
//  Created by Kyle Bashour on 1/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import Starscream

class SocketManager: WebSocketDelegate {
    
    private var socket = WebSocket(url: NSURL(string: Constants.Web.outboxEndpoint)!)
    
    var connected: Bool {
        return socket.isConnected
    }
    
    weak var gameDelegate: GameDelegate?
    
    init() {
        socket.connect()
    }
    
    func sendMessage(string: String) {
        socket.writeString(string)
    }
    
    func sendData(data: NSData) {
        socket.writePing(data)
    }
    
    func websocketDidConnect(socket: WebSocket) {
        
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: NSData) {
        
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        
    }

}
