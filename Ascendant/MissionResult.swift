//
//  MissionResult.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/26/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import Gloss

struct MissionResult: Decodable {
    
    let missionNumber: Int
    let passed: Bool
    
    init?(json: JSON) {
        
        guard let
            missionNumber: Int = "mission_number" <~~ json,
            passed: Bool = "pass" <~~ json
        else {
            return nil
        }
        
        self.missionNumber = missionNumber
        self.passed = passed
    }
}
