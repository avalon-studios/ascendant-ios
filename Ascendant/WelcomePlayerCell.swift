//
//  WelcomePlayerCell.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/24/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class WelcomePlayerCell: UITableViewCell, Themable {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateTheme()
    }
    
    func updateTheme() {
        
        nameLabel.textColor = Theme.asc_defaultTextColor()
        
        backgroundColor = Theme.cellBackgroundColor()
    }
}
