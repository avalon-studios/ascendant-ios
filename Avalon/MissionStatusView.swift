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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStatus(.None)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 10
    }
    
    func setStatus(status: MissionStatus) {
        UIView.animateWithDuration(0.3) {
            switch status {
            case .Current:  self.backgroundColor = ThemeManager.currentMissionColor
            case .Success:  self.backgroundColor = ThemeManager.successfulMissionColor
            case .Fail:     self.backgroundColor = ThemeManager.failedMissionColor
            default:        self.backgroundColor = ThemeManager.mainBackgroundColor
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
