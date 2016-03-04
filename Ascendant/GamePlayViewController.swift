//
//  GamePlayViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import ElegantPresentations

typealias ActionStackBlock = Void -> Void

class GamePlayViewController: UIViewController, Themable {
    
    @IBOutlet weak var missionLabel: UILabel!
    @IBOutlet weak var failedLabel: UILabel!
    @IBOutlet weak var missionStack: UIStackView!
    @IBOutlet weak var proposalStack: UIStackView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var failedMissionsBottomSeparator: UIView!
    @IBOutlet weak var readyButton: AscendantButton!
    @IBOutlet weak var roomCodeLabel: UILabel!
    @IBOutlet weak var leaveButton: UIButton!
    @IBOutlet var separators: [UIView]!
    
    var game: Game!
    
    var showingAction = false {
        didSet {
            // If we got set to false, it's time to run the next action (if it exists)
            if !showingAction, let action = actionStack.popLast() {
                showingAction = true
                action()
            }
        }
    }
    
    var actionStack = [ActionStackBlock]()
    
    var missionViews: [MissionView] {
        // If we can't cast all these as MissionViews, then we should crash
        return missionStack.arrangedSubviews as! [MissionView]
    }
    
    var proposalViews: [ProposalView] {
        // If we can't cast all these as ProposalViews, then we should crash
        return proposalStack.arrangedSubviews as! [ProposalView]
    }
    
    var heightForAction: CGFloat {
        
        let height = view.frame.height
        let distanceFromTop = failedMissionsBottomSeparator.frame.origin.y + 16
        
        return height - distanceFromTop
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game.delegate = self
        
        updateTheme()
        
        setUpUI()
        
        if game.rejoin {
            Socket.manager.getCurrentAction(game)
        }
    }
    
    func setUpUI() {
        
        messageLabel.text = ""
        
        var teamText = "You're a " + (game.player.team == .Bad ? "Mutineer" : "Space Explorer")
        
        // Just grab all the bad players (if we're bad) and add their names to our team text
        if game.player.team == .Bad {
            teamText += "\n along with "
            
            let badPlayers = game.players.filter {
                $0 != self.game.player
            }
            .flatMap {
                return $0.team == .Bad ? $0.name : nil
            }
            
            teamText += badPlayers[0..<badPlayers.count - 1].joinWithSeparator(", ")
            
            if let lastPlayer = badPlayers.last {
                if badPlayers.count > 1 {
                    teamText += " and \(lastPlayer)"
                }
                else {
                    teamText += lastPlayer
                }
            }
        }
        
        messageLabel.setTextWithCrossFade(teamText)
        
        game(setNumberOfFailedProposals: game.numberFailedProposals)
        
        for (index, pass) in game.roundPasses.enumerate() {
            
            let status = pass ? MissionStatus.Success : MissionStatus.Fail
    
            game(setMissionStatus: status, forMission: index)
        }
        
        game(setMissionStatus: .Current, forMission: game.roundPasses.count)

        for (index, view) in missionViews.enumerate() {
            view.titleLabel.text = "\(index + 1)"
        }
        
        if game.ready {
            readyButton.removeFromSuperview()
        }
        
        roomCodeLabel.text = game.id
    }
    
    func updateTheme() {

        view.backgroundColor = Theme.asc_baseColor()
        
        [missionLabel, failedLabel, messageLabel, roomCodeLabel].forEach {
            $0.textColor = Theme.asc_defaultTextColor()
        }
        
        leaveButton.tintColor = Theme.asc_defaultTextColor()
        
        separators.forEach { $0.backgroundColor = Theme.asc_separatorColor() }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return Theme.asc_statusBarStyle()
    }
    
    func createActionViewController() -> (UINavigationController, ActionViewController) {
        
        guard let actionNavigationController = R.storyboard.gamePlay.actionViewController(),
            actionViewController = actionNavigationController.viewControllers.first as? ActionViewController
            else {
                fatalError("Unable to create an action view controller")
        }
        
        actionViewController.game = game
        
        return (actionNavigationController, actionViewController)
    }
    
    @IBAction func readyButtonPressed(sender: AscendantButton) {
    
        sender.startActivity()
        
        Socket.manager.sendReady(game) { result in
            
            sender.stopActivity()
            
            switch result {
            case .Success:
                sender.hidden = true
                self.messageLabel.setTextWithCrossFade("Waiting for other players to check their team")
            case .Error(let message):
                self.showAlert("Error", message: message)
            }
        }
    }
    
    func runOrSaveAction(action: ActionStackBlock) {
        if showingAction {
            actionStack.insert(action, atIndex: 0)
        }
        else {
            showingAction = true
            action()
        }
    }
    @IBAction func leaveButtonPressed(sender: UIButton) {
        
        let alert = UIAlertController(title: "Leave Game", message: "Are you sure you want to leave the game?\n\nThis has not been fully implemented yet, and merely closes the game for you, leaving the other players lost in space until you rejoin", preferredStyle: .Alert)
        
        let leaveButton = UIAlertAction(title: "Leave", style: .Default) { _ in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alert.addAction(leaveButton)
        alert.addAction(cancelButton)
        
        presentViewController(alert, animated: true, completion: nil)
    }
}

extension GamePlayViewController: GameDelegate {
    
    func game(havePlayerProposeMission player: Player, withNumberOfRequiredPlayers numberPlayers: Int) {
        
        guard player.id == game.player.id else {
            
            messageLabel.setTextWithCrossFade("Waiting for \(player.name) to propose a mission team")
            
            return
        }
        
        runOrSaveAction { [unowned self] in

            let (actionNavigationController, actionViewController) = self.createActionViewController()
            
            actionViewController.actionMembers = self.game.players
            actionViewController.action = .ProposeMission
            actionViewController.numberOfPlayersForProposal = numberPlayers

            self.presentViewControllerCustom(actionNavigationController, animated: true, completion: nil)
        }
    }
    
    func game(setNumberOfFailedProposals failed: Int) {
    
        UIView.animateWithDuration(0.3) { 
            for (index, view) in self.proposalViews.enumerate() {
                view.setFailed(index < failed)
            }
        }
    }
    
    func game(voteOnMissionWithPlayers players: [Player]) {
        
        messageLabel.setTextWithCrossFade("Waiting for mission votes")
        
        guard players.contains(game.player) else {
            return
        }
        
        runOrSaveAction { [unowned self] in

            let (actionNavigationController, actionViewController) = self.createActionViewController()
            
            actionViewController.actionMembers = players
            actionViewController.action = .MissionVote
        
            self.presentViewControllerCustom(actionNavigationController, animated: true, completion: nil)
        }
    }
    
    func game(voteOnProposalWithPlayers players: [Player]) {

        messageLabel.setTextWithCrossFade("Waiting for players to vote on mission proposal")

        runOrSaveAction { [unowned self] in

            let (actionNavigationController, actionViewController) = self.createActionViewController()

            actionViewController.actionMembers = players
            actionViewController.action = .ProposalVote

            self.presentViewControllerCustom(actionNavigationController, animated: true, completion: nil)
        }
    }
    
    func game(setMissionStatus status: MissionStatus, forMission missionNumber: Int) {
    
        guard missionNumber < missionViews.count else {
            return
        }
        
        missionViews[missionNumber].setStatus(status)
    }
    
    func game(showProposalVotingResult result: ProposalResult) {
        
        if result.pass {
            messageLabel.setTextWithCrossFade("Waiting for mission votes")
        }
        else {
            messageLabel.setTextWithCrossFade("Waiting for a new leader")
        }

        runOrSaveAction { [unowned self] in

            let (actionNavigationController, actionViewController) = self.createActionViewController()
            
            actionViewController.proposalResult = result
            actionViewController.action = .ProposalResult

            self.presentViewControllerCustom(actionNavigationController, animated: true, completion: nil)
        }
    }
    
    func game(endWithMessage message: String, winningTeam: Team) {
        
        runOrSaveAction {
            
            let alert = UIAlertController(title: "Game Over!", message: message, preferredStyle: .Alert)

            var title = "Aww shucks"
            
            if self.game.player.team == .Bad && winningTeam == .Bad {
                title = "Mwahaha!"
            }
            else if winningTeam == .Good {
                title = "Huzzah!"
            }
            
            let okButton = UIAlertAction(title: title, style: .Cancel) { _ in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            
            alert.addAction(okButton)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}

extension GamePlayViewController: UIViewControllerTransitioningDelegate {
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return ElegantPresentations.controller(presentedViewController: presented, presentingViewController: presenting, options: [.PresentedHeight(heightForAction), .PresentingViewKeepsSize, .CustomDimmingViewAlpha(0.3)])
    }
}
