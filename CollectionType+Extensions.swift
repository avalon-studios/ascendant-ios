//
//  CollectionType+Extensions.swift
//  Avalon
//
//  Created by Kyle Bashour on 2/17/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation

extension CollectionType {
    
    func jsonStringForValue(value: Any) -> String {
        
        if let value = value as? [AnyObject] {
            return value.jsonString
        }
        else if let value = value as? [String: AnyObject] {
            return value.jsonString
        }
        else if let value = value as? String {
            return "\"\(value)\""
        }
        else {
            return "\(value)"
        }
    }
}
