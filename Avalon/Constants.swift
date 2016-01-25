//
//  Constants.swift
//  Dilemma
//
//  Created by Kyle Bashour on 1/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Web {
        static let inboxEndpoint = "ws://dilemma-api.herokuapp.com" + "/receive"
        static let outboxEndpoint = "ws://dilemma-api.herokuapp.com" + "/submit"
    }
    
    struct Segues {
        static let showGamePlay = "ShowGamePlay"
    }
}
