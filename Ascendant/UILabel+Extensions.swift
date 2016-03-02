//
//  UILabel+Extensions.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/28/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setTextWithCrossFade(text: String?) {
        UIView.transitionWithView(self, duration: 0.3, options: [.TransitionCrossDissolve],
            animations: {
                self.text = text
            },
            completion: nil
        )
    }
}
