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

class SocketManager {
    
    private static let manager = SocketManager()
    
    private func createGame(completion: NetworkCompletion) {
        Async.main(after: 0.5) {
            completion(.success)
        }
    }
}

extension SocketManager {
    
    class func createGame(completion: NetworkCompletion) {
        manager.createGame(completion)
    }
}

enum NetworkResult {
    case success
    case error(message: String)
}
