//
//  SocketManager.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import Async

typealias NetworkCompletion = NetworkResult -> Void

class Socket {
    
    static let manager = Socket()
    
    func createGame(completion: NetworkCompletion) {
        Async.main(after: 0.5) {
            completion(.success)
        }
    }
}

enum NetworkResult {
    case success
    case error(message: String)
}
