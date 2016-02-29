//
//  PlayerCell.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/23/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell, Themable {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        teamView.layer.cornerRadius = teamView.frame.height / 2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateTheme()
    }
    
    func updateTheme() {
        
        tintColor = Theme.asc_defaultTextColor()
        
        nameLabel.textColor = Theme.asc_defaultTextColor()
        
        backgroundColor = Theme.cellBackgroundColor()
    }
}
