//
//  LoadingViewController.swift
//  Avalon
//
//  Created by Kyle Bashour on 1/26/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import PureLayout

class GamePlayViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var missionStatusStackView: UIStackView!
    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var passButton: UIButton!
    @IBOutlet weak var failButton: UIButton!
    @IBOutlet weak var proposalDescriptionLabel: UILabel!
    @IBOutlet weak var playerTableView: UITableView!
    
    var missionStatusViews = [MissionStatusView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setThemeAndUI()
        setUpMissionViews(5)
    }
    
    func setThemeAndUI() {
        view.backgroundColor = ThemeManager.mainBackgroundColor
        statusBarView.backgroundColor = ThemeManager.statusBarViewColor
        buttonContainerView.backgroundColor = ThemeManager.mainBackgroundColor
        
        // CHANGE TO THEME COLORS:
//        buttonContainerView.layer.borderColor = UIColor.darkGrayColor().CGColor
//        buttonContainerView.layer.borderWidth = 1
//        buttonContainerView.layer.cornerRadius = 5
        passButton.layer.cornerRadius = 5
        failButton.layer.cornerRadius = 5
        
        playerTableView.backgroundColor = ThemeManager.mainBackgroundColor
        playerTableView.estimatedRowHeight = 40
        playerTableView.rowHeight = UITableViewAutomaticDimension
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
        missionStatusViews[2].setStatus(.Success)
        missionStatusViews[3].setStatus(.Current)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.playerCell) else {
            fatalError("Could not dequeue cell")
        }
        
        cell.setPlayer(Player(), secondPlayer: Player())
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
