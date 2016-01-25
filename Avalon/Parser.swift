//
//  Parser.swift
//  Dilemma
//
//  Created by Kyle Bashour on 1/24/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation

struct Parser {
    
    func parseQuestions(json: NSData) -> [Question] {
        return [Question]()
    }
    
    func parsePlayer(json: NSDictionary) -> Player? {
        return Player.from(json)
    }
}
