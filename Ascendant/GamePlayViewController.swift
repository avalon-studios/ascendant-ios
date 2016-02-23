//
//  GamePlayViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import Async

class GamePlayViewController: UIViewController {
    
    @IBOutlet weak var missionStack: UIStackView!
    @IBOutlet weak var proposalStack: UIStackView!
    
    private var didUpdateConstraints = false
    
    var missionViews: [MissionView] {
     
        if let missionViews = missionStack.arrangedSubviews as? [MissionView] {
            return missionViews
        }
        
        return []
    }
    
    var proposalViews: [UIView] {
        return proposalStack.arrangedSubviews
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        // Just for testing
        missionViews[0].setStatus(.success)
        missionViews[1].setStatus(.fail)
        missionViews[1].setStatus(.current)

        proposalViews[0].alpha = 1
        proposalViews[1].alpha = 1
        proposalViews[2].alpha = 1
        proposalViews[3].alpha = 1
    }

    func setUpUI() {

        for (index, view) in missionViews.enumerate() {
            view.titleLabel.text = "\(index + 1)"
        }
        
        for view in proposalViews {
            view.alpha = 0
        }
    }
}
