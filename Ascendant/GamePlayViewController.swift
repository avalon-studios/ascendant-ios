//
//  GamePlayViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class GamePlayViewController: UIViewController {
    
    @IBOutlet weak var missionStack: UIStackView!
    
    private var didUpdateConstraints = false
    
    var missionViews: [MissionView] {
     
        if let missionViews = missionStack.arrangedSubviews as? [MissionView] {
            return missionViews
        }
        
        return []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMissionViews()
    }
    
    func setUpMissionViews() {

        for (index, view) in missionViews.enumerate() {
            view.titleLabel.text = "\(index + 1)"
        }
    }
}
