//
//  UIViewController+Extensions.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/24/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let button = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(button)
        presentViewController(alert, animated: true, completion: nil)
    }
}