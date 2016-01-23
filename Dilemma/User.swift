//
//  User.swift
//  Dilemma
//
//  Created by Kyle Bashour on 1/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import Mapper

struct Card: Mappable {
    
    let id: Int
    let text: String
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try text = map.from("text")
    }
}
