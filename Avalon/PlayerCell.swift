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
    @IBOutlet weak var secondPlayerImage: UIImageView!
    @IBOutlet weak var secondPlayerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        setTheme()
    }
    
    func setTheme() {
        contentView.backgroundColor = ThemeManager.mainBackgroundColor
        firstPlayerLabel.textColor = ThemeManager.mainTextColor
        secondPlayerLabel.textColor = ThemeManager.mainTextColor
    }
    
    func setPlayer(firstPlayer: Player, secondPlayer: Player? = nil) {
        
        firstPlayerImage.image = firstPlayer.type != .Knight ? R.image.shield() : AvalonStyleKit.imageOfMutineersIcon
        firstPlayerLabel.text = firstPlayer.displayName.uppercaseString
        
        guard let secondPlayer = secondPlayer else {
            return
        }
        
        secondPlayerImage.image = secondPlayer.type == .Knight ? R.image.shield() : AvalonStyleKit.imageOfMutineersIcon
        secondPlayerLabel.text = secondPlayer.displayName.uppercaseString
    }
}