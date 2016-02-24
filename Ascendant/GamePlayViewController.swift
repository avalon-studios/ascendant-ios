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
    
    var mockPlayers: [Player] {
        
        var players = [Player]()
        
        players.append(Player(name: "Kyle", id: "1", team: .Good))
        players.append(Player(name: "Elliot", id: "2", team: .Bad))
        players.append(Player(name: "Joseph", id: "3", team: .Good))
        players.append(Player(name: "Tyler", id: "4", team: .Good))
        players.append(Player(name: "Jared", id: "5", team: .Bad))
        
        return players
    }
    
    var mockMissionPlayers: [Player] {
        
        var players = [Player]()
        
        players.append(Player(name: "Kyle", id: "1", team: .Good))
        players.append(Player(name: "Elliot", id: "2", team: .Bad))
        
        return players
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = Game(id: "123", player: Player(name: "Kyle", id: "1", team: .Good))
        
        game.delegate = self
        
        setUpUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        showMissionAndFailedChanges()
    }
    
    func setUpUI() {

        for (index, view) in missionViews.enumerate() {
            view.titleLabel.text = "\(index + 1)"
        }
        
        view.backgroundColor = UIColor.asc_baseColor()
        separators.forEach { $0.backgroundColor = UIColor.asc_separatorColor() }
    }
    
    func createActionViewController() -> (UINavigationController, ActionViewController)? {
        
        guard let actionNavigationController = R.storyboard.gamePlay.actionViewController(),
            actionViewController = actionNavigationController.viewControllers.first as? ActionViewController
            else {
                assertionFailure("Unable to create an action view controller")
                return nil
        }
        
        actionViewController.game = game
        
        actionNavigationController.transitioningDelegate = self
        actionNavigationController.modalPresentationStyle = .Custom
        
        return (actionNavigationController, actionViewController)
    }
    
    
    // JUST FOR MOCKUP!
    
    @IBAction func mockupPropose(sender: AnyObject) {
        gameProposeMission()
    }
    
    @IBAction func mockupMissionVote(sender: AnyObject) {
        gameVoteOnMission(mockMissionPlayers)
    }
    
    func showMissionAndFailedChanges() {
        
        Async.main(after: 2) {
            self.gameSetMissionStatus(.Current, missionNumber: 0)
            self.gameSetFailedProposals(1)
        }
        .main(after: 1) {
            self.gameSetFailedProposals(2)
        }
        .main(after: 1) {
            self.gameSetFailedProposals(3)
        }
        .main(after: 1) {
            self.gameSetFailedProposals(4)
        }
        .main(after: 1) {
            self.gameSetFailedProposals(5)
        }
        .main(after: 1) {
            self.gameSetFailedProposals(0)
        }
        .main {
            self.gameSetMissionStatus(.Success, missionNumber: 0)
            self.gameSetMissionStatus(.Current, missionNumber: 1)
        }
        .main(after: 3) {
            self.gameSetMissionStatus(.Fail, missionNumber: 1)
            self.gameSetMissionStatus(.Current, missionNumber: 2)
        }
        .main(after: 2.5) {
            self.gameSetMissionStatus(.Fail, missionNumber: 2)
            self.gameSetMissionStatus(.Current, missionNumber: 3)
        }
        .main(after: 4) {
            self.gameSetMissionStatus(.Success, missionNumber: 3)
            self.gameSetMissionStatus(.Current, missionNumber: 4)
        }
        .main(after: 2) {
            self.gameSetMissionStatus(.Success, missionNumber: 4)
        }
    }
}

extension GamePlayViewController: GameDelegate {
    
    func gameProposeMission() {
        
        guard let (actionNavigationController, actionViewController) = createActionViewController() else {
            return
        }
        
        actionViewController.players = mockPlayers
        actionViewController.action = .ProposeMission
        actionViewController.numberOfPlayersForProposal = 2
        
        presentViewController(actionNavigationController, animated: true, completion: nil)
    }
    
    func gameSetFailedProposals(failed: Int) {
        
        UIView.animateWithDuration(0.3) { 
            for (index, view) in self.proposalViews.enumerate() {
                view.setFailed(index < failed)
            }
        }
    }
    
    func gameVoteOnMission(players: [Player]) {
        
        guard let (actionNavigationController, actionViewController) = createActionViewController() else {
            return
        }
        
        actionViewController.players = players
        actionViewController.action = .MissionVote
        
        presentViewController(actionNavigationController, animated: true, completion: nil)
    }
    
    func gameVoteOnProposal(players: [Player]) {
        
        guard let (actionNavigationController, actionViewController) = createActionViewController() else {
            return
        }
        
        actionViewController.players = players
        actionViewController.action = .ProposalVote
        
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
        return ElegantPresentations.controller(presentedViewController: presented, presentingViewController: presenting, options: [.CustomPresentingScale(0.9), .PresentedPercentHeight(0.8)])
    }
}
