//
//  AckResult.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/26/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import Gloss

enum AckResult: Decodable {
    
    case Success
    case Error(message: String)

    init?(json: JSON) {
        
        if let success: Bool = "success" <~~ json where success {
            self = .Success
        }
        else {
            self = .Error(message: "error_message" <~~ json ?? "Unknown Error")
        }
    }
}
