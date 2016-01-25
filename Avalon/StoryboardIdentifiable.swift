//
//  StoryboardIdentifiable.swift
//  Dilemma
//
//  Created by Kyle Bashour on 1/25/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(self)
    }
}
