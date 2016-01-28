//
//  PlayerCell.swift
//  Avalon
//
//  Created by Kyle Bashour on 1/27/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {
    
    @IBOutlet weak var firstPlayerImage: UIImageView!
    @IBOutlet weak var firstPlayerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        setTheme()
    }
    
    func setTheme() {
        contentView.backgroundColor = ThemeManager.mainBackgroundColor
        firstPlayerLabel.textColor = ThemeManager.mainTextColor
    }
    
    func setPlayer(player: Player) {
        
        firstPlayerImage.image = player.type != .Knight ? R.image.shield() : AvalonStyleKit.imageOfMutineersIcon
        firstPlayerLabel.text = player.displayName.uppercaseString
    }
}