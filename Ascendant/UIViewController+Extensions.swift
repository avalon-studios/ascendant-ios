//
//  UIViewController+Extensions.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/24/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String?, okAction: (UIAlertAction -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let button = UIAlertAction(title: "OK", style: .Default, handler: okAction)
        alert.addAction(button)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func presentViewControllerCustom(viewController: UIViewController, animated: Bool, completion: (Void -> Void)?) {
        
        viewController.modalPresentationStyle = .Custom
        viewController.transitioningDelegate = (self as? UIViewControllerTransitioningDelegate)
        
        presentViewController(viewController, animated: animated, completion: completion)
    }
}
