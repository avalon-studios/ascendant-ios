//
//  User.swift
//  Dilemma
//
//  Created by Kyle Bashour on 1/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import Mapper

struct Player: Mappable {
    
    let id: Int
    let displayName: String
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try displayName = map.from("display_name")
    }
}
