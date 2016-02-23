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
    
    var mockPlayers: [Player] {
        
        var players = [Player]()
        
        players.append(Player(name: "Kyle", id: "1", team: .good))
        players.append(Player(name: "Elliot", id: "2", team: .bad))
        players.append(Player(name: "Joseph", id: "3", team: .good))
        players.append(Player(name: "Tyler", id: "4", team: .good))
        players.append(Player(name: "Jared", id: "5", team: .bad))
        
        return players
    }
    
    var mockMissionPlayers: [Player] {
        
        var players = [Player]()
        
        players.append(Player(name: "Kyle", id: "1", team: .good))
        players.append(Player(name: "Elliot", id: "2", team: .bad))
        players.append(Player(name: "Joseph", id: "3", team: .good))
        players.append(Player(name: "Tyler", id: "4", team: .good))
        
        return players
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Game.manager.delegate = self
        
        setUpUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        gameSetFailedProposals(2)
        gameSetMissionStatus(.success, missionNumber: 0)
        gameSetMissionStatus(.fail, missionNumber: 1)
        gameSetMissionStatus(.current, missionNumber: 2)
    }
    
    func setUpUI() {

        for (index, view) in missionViews.enumerate() {
            view.titleLabel.text = "\(index + 1)"
        }
        
        for view in proposalViews {
            view.alpha = 0
        }
    }
    
    func resetProposals() {
        for view in proposalViews {
            view.alpha = 0
        }
    }
    
    func createActionViewController() -> (UINavigationController, ActionViewController)? {
        
        guard let actionNavigationController = R.storyboard.gamePlay.actionViewController(),
            actionViewController = actionNavigationController.viewControllers.first as? ActionViewController
            else {
                assertionFailure("Unable to create an action view controller")
                return nil
        }
        
        actionNavigationController.transitioningDelegate = self
        actionNavigationController.modalPresentationStyle = .Custom
        
        return (actionNavigationController, actionViewController)
    }
    
    // just for mockup!
    
    @IBAction func mockupPropose(sender: AnyObject) {
        gameProposeMission()
    }
    
    @IBAction func mockupProposeVote(sender: AnyObject) {
        gameVoteOnProposal(mockMissionPlayers)
    }
    
    @IBAction func mockupMissionVote(sender: AnyObject) {
        gameVoteOnMission(mockMissionPlayers)
    }
}

extension GamePlayViewController: GameDelegate {
    
    func gameProposeMission() {
        
        guard let (actionNavigationController, actionViewController) = createActionViewController() else {
            return
        }
        
        actionViewController.players = mockPlayers
        actionViewController.action = .proposeMission
        actionViewController.numberOfPlayersForProposal = 2
        
        presentViewController(actionNavigationController, animated: true, completion: nil)
    }
    
    func gameSetFailedProposals(failed: Int) {
        
        UIView.animateWithDuration(0.3) { 
            
            self.resetProposals()
            
            for index in 0..<failed where index < self.proposalViews.count {
                self.proposalViews[index].alpha = 1
            }
        }
    }
    
    func gameVoteOnMission(players: [Player]) {
        
        guard let (actionNavigationController, actionViewController) = createActionViewController() else {
            return
        }
        
        actionViewController.players = players
        actionViewController.action = .missionVote
        
        presentViewController(actionNavigationController, animated: true, completion: nil)
    }
    
    func gameVoteOnProposal(players: [Player]) {
        
        guard let (actionNavigationController, actionViewController) = createActionViewController() else {
            return
        }
        
        actionViewController.players = players
        actionViewController.action = .proposalVote
        
        presentViewController(actionNavigationController, animated: true, completion: nil)
    }
    
    func gameSetMissionStatus(status: MissionStatus, missionNumber: Int) {
        
        guard missionNumber < missionViews.count else {
            return
        }
        
        missionViews[missionNumber].setStatus(status)
    }
}

extension GamePlayViewController: UIViewControllerTransitioningDelegate {
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return ElegantPresentations.controller(presentedViewController: presented, presentingViewController: presenting, options: [.PresentedPercentHeight(0.7), .CustomPresentingScale(0.9)])
    }
}
