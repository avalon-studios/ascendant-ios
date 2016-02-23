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
    
    let noneColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
    let opacityAnimationKey = "OpacityAnimationKey"
    
    let titleLabel: UILabel = {
        
        let label = UILabel(forAutoLayout: ())
        
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(18)
        label.textAlignment = .Center
        
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(titleLabel)
        
        titleLabel.autoPinEdgesToSuperviewEdges()

        backgroundColor = noneColor
    }
    
    override func layoutSubviews() {
        
        layer.cornerRadius = frame.height / 2
        
        super.layoutSubviews()
    }
    
    func setStatus(status: MissionStatus) {
        
        layer.removeAllAnimations()
        
        switch status {
        case .none:
            backgroundColor = noneColor
        case .success:
            backgroundColor = Style.green
        case .fail:
            backgroundColor = Style.red
        case .current:
            backgroundColor = Style.blue
            beginCurrentAnimation()
        }
    }
    
    private func beginCurrentAnimation() {
        
        UIView.animateWithDuration(1.5, delay: 0, options: [.Autoreverse, .Repeat],
            animations: {
                self.backgroundColor = Style.blue.colorWithAlphaComponent(0.5)
            },
            completion: nil
        )
    }
}

enum MissionStatus {
    case none
    case success
    case fail
    case current
}
