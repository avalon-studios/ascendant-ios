//
//  Dictionary+Extensions.swift
//  Avalon
//
//  Created by Kyle Bashour on 2/17/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation

extension Dictionary where Key: StringLiteralConvertible, Value: Any {
    
    var jsonString: String {
        
        var string = "{"
        
        for (index, (key, value)) in self.enumerate() {
            string += "\"\(key)\":"
            string += jsonStringForValue(value)
            
            if index < self.keys.count - 1 {
                string += ","
            }
        }
        
        string += "}"
        
        return string
    }
}
