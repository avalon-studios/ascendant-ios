//
//  Card.swift
//  Avalon
//
//  Created by Kyle Bashour on 1/24/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import Mapper

struct Question: Mappable {
    
    let id: Int
    let text: String
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try text = map.from("text")
    }
}
