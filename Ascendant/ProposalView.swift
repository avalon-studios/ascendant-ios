//
//  ProposalView.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class ProposalView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = Theme.asc_transparentColor()
    }
    
    override func layoutSubviews() {
        
        layer.cornerRadius = frame.height / 2
        
        super.layoutSubviews()
    }
    
    func setFailed(failed: Bool) {
        backgroundColor = failed ? Theme.asc_redColor() : Theme.asc_transparentColor()
    }
}
