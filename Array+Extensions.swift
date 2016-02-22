//
//  Array+Extensions.swift
//  Avalon
//
//  Created by Kyle Bashour on 2/17/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation

extension Array where Element: Any {
    
    var jsonString: String {
        
        var string = "["
        
        for (index, value) in self.enumerate() {
            string += jsonStringForValue(value)
            
            if index < self.count - 1 {
                string += ","
            }
        }
        
        return string + "]"
    }
}
