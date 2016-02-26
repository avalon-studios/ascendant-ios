//
//  UITextField+Extensions.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/26/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

extension UITextField {
    
    func validName() -> String? {
        guard let text = text where !text.componentsSeparatedByCharactersInSet(.whitespaceAndNewlineCharacterSet()).joinWithSeparator("").isEmpty else {
            return nil
        }
        
        return text
    }
    
    func validGameID() -> String? {
        guard let text = text where !text.componentsSeparatedByCharactersInSet(.whitespaceAndNewlineCharacterSet()).joinWithSeparator("").isEmpty else {
            return nil
        }
        
        return text
    }
}