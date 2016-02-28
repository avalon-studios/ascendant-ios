//
//  GamePlayViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import Async
import ElegantPresentations

class GamePlayViewController: UIViewController {
    
    @IBOutlet weak var missionStack: UIStackView!
    @IBOutlet weak var proposalStack: UIStackView!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet var separators: [UIView]!
    
    var game: Game!
    
    var missionViews: [MissionView] {
        // If we can't cast all these as MissionViews, then we should crash
        return missionStack.arrangedSubviews as! [MissionView]
    }
    
    var proposalViews: [ProposalView] {
        // If we can't cast all these as ProposalViews, then we should crash
        return proposalStack.arrangedSubviews as! [ProposalView]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game.delegate = self
        
        messageLabel.text = "You're on the " + (game.player.team == .Good ? "good" : "bad") + " team"
        
        setUpUI()
    }
    
    func setUpUI() {

        for (index, view) in missionViews.enumerate() {
            view.titleLabel.text = "\(index + 1)"
        }
        
        view.backgroundColor = Theme.asc_baseColor()
        separators.forEach { $0.backgroundColor = Theme.asc_separatorColor() }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func createActionViewController() -> (UINavigationController, ActionViewController)? {
        
        guard let actionNavigationController = R.storyboard.gamePlay.actionViewController(),
            actionViewController = actionNavigationController.viewControllers.first as? ActionViewController
            else {
                fatalError("Unable to create an action view controller")
        }
        
        actionViewController.game = game
        
        return (actionNavigationController, actionViewController)
    }
}

extension GamePlayViewController: GameDelegate {
    
    func game(havePlayerProposeMission player: Player) {
        
        guard let (actionNavigationController, actionViewController) = createActionViewController() else {
            return
        }
        
        actionViewController.actionMembers = game.players
        actionViewController.action = .ProposeMission
        actionViewController.numberOfPlayersForProposal = 2
        
        presentViewControllerCustom(actionNavigationController, animated: true, completion: nil)
    }
    
    func game(setNumberOfFailedProposals failed: Int) {
    
        UIView.animateWithDuration(0.3) { 
            for (index, view) in self.proposalViews.enumerate() {
                view.setFailed(index < failed)
            }
        }
    }
    
    func game(voteOnMissionWithPlayers players: [Player]) {
    
        guard let (actionNavigationController, actionViewController) = createActionViewController() else {
            return
        }
        
        actionViewController.actionMembers = players
        actionViewController.action = .MissionVote
        
        presentViewControllerCustom(actionNavigationController, animated: true, completion: nil)
    }
    
    func game(voteOnProposalWithPlayers players: [Player]) {

        guard let (actionNavigationController, actionViewController) = createActionViewController() else {
            return
        }
        
        actionViewController.actionMembers = players
        actionViewController.action = .ProposalVote
        
        presentViewControllerCustom(actionNavigationController, animated: true, completion: nil)
    }
    
    func game(setMissionStatus status: MissionStatus, forMission missionNumber: Int) {
    
        guard missionNumber < missionViews.count else {
            return
        }
        
        missionViews[missionNumber].setStatus(status)
    }
}

extension GamePlayViewController: UIViewControllerTransitioningDelegate {
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return ElegantPresentations.controller(presentedViewController: presented, presentingViewController: presenting, options: [.PresentedPercentHeight(0.8)])
    }
}
