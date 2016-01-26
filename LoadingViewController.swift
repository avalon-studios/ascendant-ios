//
//  LoadingViewController.swift
//  Avalon
//
//  Created by Kyle Bashour on 1/26/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import PureLayout

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var missionStatusStackView: UIStackView!
    @IBOutlet weak var statusBarView: UIView!
    
    var missionStatusViews = [MissionStatusView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTheme()
        setUpMissionViews(5)
    }
    
    func setTheme() {
        view.backgroundColor = ThemeManager.mainBackgroundColor
        statusBarView.backgroundColor = ThemeManager.statusBarViewColor
    }
    
    func setUpMissionViews(numberOfMissions: Int) {
        
        for index in 1...numberOfMissions {
            
            guard let missionView = R.nib.missionStatusView.firstView(owner: self) else {
                fatalError("Could not load mission status view from nin")
            }
            
            missionView.numberLabel.text = "\(index)"
            missionStatusStackView.addArrangedSubview(missionView)
            missionStatusViews.append(missionView)
        }

        missionStatusViews[0].setStatus(.Success)
        missionStatusViews[1].setStatus(.Fail)
        missionStatusViews[2].setStatus(.Fail)
        missionStatusViews[3].setStatus(.Current)
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
