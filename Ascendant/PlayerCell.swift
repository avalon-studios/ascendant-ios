//
//  PlayerCell.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/23/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        teamView.layer.cornerRadius = frame.height / 2
    }
}
