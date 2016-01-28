//
//  MissionStatusView.swift
//  Avalon
//
//  Created by Kyle Bashour on 1/26/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import ChameleonFramework

class MissionStatusView: UIView {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var highlightImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStatus(.None)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func setStatus(status: MissionStatus) {
        UIView.animateWithDuration(0.3) {
            switch status {
            case .Current:  self.highlightImageView.image = AvalonStyleKit.imageOfCurrentMissionHighlight
                // self.backgroundColor = ThemeManager.MissionStatus.currentMissionColor
            case .Success:  self.highlightImageView.image = AvalonStyleKit.imageOfSuccessfulMissionHighlight
                // self.backgroundColor = ThemeManager.MissionStatus.successfulMissionColor
            case .Fail:     self.highlightImageView.image = AvalonStyleKit.imageOfFailedMissionHighlight
                //self.backgroundColor = ThemeManager.MissionStatus.failedMissionColor
            default:        self.highlightImageView.image = AvalonStyleKit.imageOfDefaultMissionHighlight
                // self.backgroundColor = ThemeManager.mainBackgroundColor
            }
            
            switch status {
            case .None: self.numberLabel.textColor = ThemeManager.MissionStatus.plainNumberColor
            default:    self.numberLabel.textColor = ThemeManager.MissionStatus.highLightedNumberColor
            }
        }
    }
}

enum MissionStatus {
    case None
    case Fail
    case Success
    case Current
}
