//
//  UIStoryboard+Extensions.swift
//  Dilemma
//
//  Created by Kyle Bashour on 1/25/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

// From: https://medium.com/@AndyyHope/uistoryboard-safer-with-enums-protocol-extensions-and-generics-7aad3883b44d#.5e017oij0

// MARK: - Storyboard Instantiation Helpers
extension UIStoryboard {
    
    enum Storyboard: String {
        case CreateGame
        case GamePlay
    }
    
    class func storyboard(storyboard: Storyboard, bundle: NSBundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
    }

    func instantiateViewController<T: UIViewController where T: StoryboardIdentifiable>(_: T.Type) -> T {
        let optionalViewController = self.instantiateViewControllerWithIdentifier(T.storyboardIdentifier)
        
        guard let viewController = optionalViewController as? T else {
            fatalError("Couldn’t instantiate view controller with identifier \(T.storyboardIdentifier)")
        }
        
        return viewController
    }
}
