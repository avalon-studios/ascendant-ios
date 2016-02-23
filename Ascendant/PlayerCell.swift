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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        teamView.hidden = Game.manager.currentPlayer.team == .good
    }
    
    func setPlayer(player: Player) {
        nameLabel.text = player.name
        teamView.backgroundColor = player.team == .bad ? Style.red : Style.green
    }
}
