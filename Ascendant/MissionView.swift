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

        backgroundColor = Style.transparentWhite
    }
    
    override func layoutSubviews() {
        
        layer.cornerRadius = frame.height / 2
        
        super.layoutSubviews()
    }
    
    func setStatus(status: MissionStatus) {
        
        UIView.animateWithDuration(1, delay: 0, options: [.BeginFromCurrentState],
            animations: {
                switch status {
                case .none:
                    self.backgroundColor = Style.transparentWhite
                case .success:
                    self.backgroundColor = Style.green
                case .fail:
                    self.backgroundColor = Style.red
                case .current:
                    self.backgroundColor = Style.blue
                }
            },
            completion: { _ in
                
                self.layer.removeAllAnimations()

                if status == .current {
                    self.beginCurrentAnimation()
                }
            }
        )
    }
    
    private func beginCurrentAnimation() {
        
        UIView.animateWithDuration(2, delay: 0, options: [.Autoreverse, .Repeat],
            animations: {
                self.backgroundColor = Style.transparentWhite
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
