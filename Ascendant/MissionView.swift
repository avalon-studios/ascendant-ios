//
//  MissionView.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import PureLayout

class MissionView: UIView {
    
    let titleLabel: UILabel = {
        
        let label = UILabel(forAutoLayout: ())
        
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(18)
        label.textAlignment = .Center
        
        return label
    }()
    
    private var didSetConstraints = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(titleLabel)
        
        backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
    }
    
    override func updateConstraints() {
        
        if !didSetConstraints {
            titleLabel.autoPinEdgesToSuperviewEdges()
            didSetConstraints = true
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        
        layer.cornerRadius = frame.height / 2
        
        super.layoutSubviews()
    }
}
