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

        backgroundColor = UIColor.asc_transparentWhiteColor()
    }
    
    override func layoutSubviews() {
        
        layer.cornerRadius = frame.height / 2
        
        super.layoutSubviews()
    }
    
    func setStatus(status: MissionStatus) {
        
        UIView.animateWithDuration(1, delay: 0, options: [.BeginFromCurrentState],
            animations: {
                switch status {
                case .None:
                    self.backgroundColor = UIColor.asc_transparentWhiteColor()
                case .Success:
                    self.backgroundColor = UIColor.asc_greenColor()
                case .Fail:
                    self.backgroundColor = UIColor.asc_redColor()
                case .Current:
                    self.backgroundColor = UIColor.asc_blueColor()
                }
            },
            completion: { _ in
                
                self.layer.removeAllAnimations()

                if status == .Current {
                    self.beginCurrentAnimation()
                }
            }
        )
    }
    
    private func beginCurrentAnimation() {
        
        UIView.animateWithDuration(2, delay: 0, options: [.Autoreverse, .Repeat],
            animations: {
                self.backgroundColor = UIColor.asc_transparentWhiteColor()
            },
            completion: nil
        )
    }
}

enum MissionStatus {
    case None
    case Success
    case Fail
    case Current
}
