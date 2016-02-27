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
        
        players.append(Player(json: ["name": "Kyle", "id": "1", "team": 0])!)
        players.append(Player(json: ["name": "Kyle", "id": "1", "team": 0])!)
        players.append(Player(json: ["name": "Kyle", "id": "1", "team": 0])!)
        players.append(Player(json: ["name": "Kyle", "id": "1", "team": 0])!)
        players.append(Player(json: ["name": "Kyle", "id": "1", "team": 0])!)
        
        return players
    }
    
    var mockMissionPlayers: [Player] {
        
        var players = [Player]()
        
        players.append(Player(json: ["name": "Kyle", "id": "1", "team": 0])!)
        players.append(Player(json: ["name": "Kyle", "id": "1", "team": 0])!)
        
        return players
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        view.backgroundColor = Theme.asc_baseColor()
        separators.forEach { $0.backgroundColor = Theme.asc_separatorColor() }
    }
    
    func createActionViewController() -> (UINavigationController, ActionViewController)? {
        
        guard let actionNavigationController = R.storyboard.gamePlay.actionViewController(),
            actionViewController = actionNavigationController.viewControllers.first as? ActionViewController
            else {
                fatalError("Unable to create an action view controller")
        }
        
        actionViewController.game = game
        
        actionNavigationController.transitioningDelegate = self
        actionNavigationController.modalPresentationStyle = .Custom
        
        return (actionNavigationController, actionViewController)
    }
    
    
    // JUST FOR MOCKUP!
    
    @IBAction func mockupPropose(sender: AnyObject) {
        game(havePlayerProposeMission: game.player)
    }
    
    @IBAction func mockupMissionVote(sender: AnyObject) {
        game(voteOnMissionWithPlayers: mockMissionPlayers)
    }
    @IBAction func End(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showMissionAndFailedChanges() {
        
        Async.main(after: 2) {
            self.game(setMissionStatus: .Current, forMission: 0)
            self.game(setNumberOfFailedProposals: 1)
        }
        .main(after: 1) {
            self.game(setNumberOfFailedProposals: 2)
        }
        .main(after: 1) {
            self.game(setNumberOfFailedProposals: 3)
        }
        .main(after: 1) {
            self.game(setNumberOfFailedProposals: 4)
        }
        .main(after: 1) {
            self.game(setNumberOfFailedProposals: 5)
        }
        .main(after: 1) {
            self.game(setNumberOfFailedProposals: 0)
        }
        .main {
            self.game(setMissionStatus: .Success, forMission: 0)
            self.game(setMissionStatus: .Current, forMission: 1)
        }
        .main(after: 3) {
            self.game(setMissionStatus: .Fail, forMission: 1)
            self.game(setMissionStatus: .Current, forMission: 2)
        }
        .main(after: 2.5) {
            self.game(setMissionStatus: .Fail, forMission: 2)
            self.game(setMissionStatus: .Current, forMission: 3)
        }
        .main(after: 4) {
            self.game(setMissionStatus: .Success, forMission: 3)
            self.game(setMissionStatus: .Current, forMission: 4)
        }
        .main(after: 2) {
            self.game(setMissionStatus: .Success, forMission: 4)
        }
    }
}

extension GamePlayViewController: GameDelegate {
    
    func game(havePlayerProposeMission player: Player) {
        
        guard let (actionNavigationController, actionViewController) = createActionViewController() else {
            return
        }
        
        actionViewController.players = mockPlayers
        actionViewController.action = .ProposeMission
        actionViewController.numberOfPlayersForProposal = 2
        
        presentViewController(actionNavigationController, animated: true, completion: nil)
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
        
        actionViewController.players = players
        actionViewController.action = .MissionVote
        
        presentViewController(actionNavigationController, animated: true, completion: nil)
    }
    
    func game(voteOnProposalWithPlayers players: [Player]) {

        guard let (actionNavigationController, actionViewController) = createActionViewController() else {
            return
        }
        
        actionViewController.players = players
        actionViewController.action = .ProposalVote
        
        presentViewController(actionNavigationController, animated: true, completion: nil)
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
        return ElegantPresentations.controller(presentedViewController: presented, presentingViewController: presenting, options: [.CustomPresentingScale(0.9), .PresentedPercentHeight(0.8)])
    }
}
