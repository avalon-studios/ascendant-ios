//
//  AscendantButton.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/24/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import PureLayout

class AscendantButton: UIButton, Themable {
    
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .White)
    private var didSetConstraints = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTitleColor(Theme.asc_transparentColor(), forState: .Disabled)
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        
        addSubview(activityIndicator)
        
        layer.cornerRadius = 8
        
        updateTheme()
    }
    
    func updateTheme() {
        backgroundColor = Theme.asc_transparentColor()
        setTitleColor(Theme.asc_buttonTextColor(), forState: .Normal)
    }
    
    override func updateConstraints() {
        
        if !didSetConstraints {
            
            activityIndicator.autoAlignAxisToSuperviewAxis(.Horizontal)
            activityIndicator.autoPinEdgeToSuperviewEdge(.Leading, withInset: 12)
            
            didSetConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func startActivity() {
        activityIndicator.startAnimating()
        enabled = false
    }
    
    func stopActivity() {
        activityIndicator.stopAnimating()
        enabled = true
    }
}
