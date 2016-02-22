//
//  VoteButton.swift
//  Avalon
//
//  Created by Kyle Bashour on 2/11/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import PureLayout

class VoteButton: UIButton {
    
    lazy var voteTitleLabel: UILabel = self.createLabel()
    lazy var voteDescriptionLabel: UILabel = self.createLabel()

    private var didLayoutSubviews = false
    
    func createLabel() -> UILabel {
        
        let label = UILabel()
        
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.systemFontOfSize(24)
        label.minimumScaleFactor = 0.2
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .Center
        
        return label
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel?.text = ""
            
        addSubview(voteTitleLabel)
        addSubview(voteDescriptionLabel)
    }
    
    override func layoutSubviews() {
        
        if !didLayoutSubviews {
            
            let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            
            voteTitleLabel.autoPinEdgesToSuperviewEdgesWithInsets(insets, excludingEdge: .Bottom)
            voteTitleLabel.autoPinEdge(.Bottom, toEdge: .Top, ofView: voteDescriptionLabel)
            voteTitleLabel.autoMatchDimension(.Height, toDimension: .Height, ofView: voteDescriptionLabel)
            voteDescriptionLabel.autoPinEdgesToSuperviewEdgesWithInsets(insets, excludingEdge: .Top)
            
            didLayoutSubviews = true
        }
        
        super.layoutSubviews()
    }
}
