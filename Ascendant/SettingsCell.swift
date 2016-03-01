//
//  SettingsCell.swift
//  Ascendant
//
//  Created by Kyle Bashour on 3/1/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    override func setSelected(selected: Bool, animated: Bool) {
        setSelectedOrHighlighted(selected, animated: animated)
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        setSelectedOrHighlighted(highlighted, animated: animated)
    }
    
    func setSelectedOrHighlighted(selected: Bool, animated: Bool) {
        
        let changes = {
            self.backgroundColor = selected ? Theme.cellHighlightColor() : Theme.cellBackgroundColor()
        }
        
        if animated {
            UIView.animateWithDuration(0.3) {
                changes()
            }
        }
        else {
            changes()
        }
    }
}
