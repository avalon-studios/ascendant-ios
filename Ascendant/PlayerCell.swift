//
//  PlayerCell.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/23/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import EXTView

class PlayerCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamView: EXTView!

    var teamColor = UIColor.asc_transparentWhiteColor()
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        setHighlightedOrSelected(highlighted)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        setHighlightedOrSelected(selected)
    }
    
    func setHighlightedOrSelected(highlightedOrSelected: Bool) {
        if highlightedOrSelected {
            teamView.backgroundColor = teamColor
        }
        else {
            teamView.backgroundColor = UIColor.asc_transparentWhiteColor()
        }
    }
}
