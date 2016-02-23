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
        
        backgroundColor = Style.red
    }
    
    override func layoutSubviews() {
        
        layer.cornerRadius = frame.height / 2
        
        super.layoutSubviews()
    }
}
