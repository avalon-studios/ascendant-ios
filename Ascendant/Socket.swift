//
//  SocketManager.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import Async

typealias NetworkCompletion = (json: [String: AnyObject]?, errorMessage: String)  -> Void

class Socket {
    
    static let manager = Socket()
    
    weak var game: Game?
    
    func createGame(completion: NetworkCompletion) {
                
        Async.main(after: 1) {
            completion(json: ["id": "1234", "player": ["id": "123", "name": "Kyle", "team": 0]], errorMessage: "")
        }
    }
}
