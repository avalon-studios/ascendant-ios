//
//  ActionViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/23/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController, Themable, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var passButton: AscendantButton!
    @IBOutlet weak var failButton: AscendantButton!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var game: Game!
    var action = Action.MissionVote
    var actionMembers: [Player]!
    var proposalResult: ProposalResult!
    var numberOfPlayersForProposal = 0
    
    var actionMessage: String {
        switch action {
        case .ProposeMission: return "Select \(numberOfPlayersForProposal) Players for a Mission"
        case .ProposalVote: return "Approve Players for a Mission"
        case .MissionVote: return "Pass the Mission?"
        case .ProposalResult: return proposalResult.pass ? "Proposal Passed" : "Proposal Did Not Pass"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTheme()
        
        setUpUI()
    }
    
    func setUpUI() {
        
        navigationItem.title = actionMessage
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        
        switch action {
        case .ProposeMission:
            failButton.hidden = true
            passButton.setTitle("Propose", forState: .Normal)
            passButton.enabled = false
        case .ProposalResult:
            failButton.hidden = true
            passButton.setTitle("Got It", forState: .Normal)
        case .ProposalVote:
            passButton.setTitle("Approve", forState: .Normal)
            failButton.setTitle("Deny", forState: .Normal)
        case .MissionVote:
            passButton.setTitle("Pass", forState: .Normal)
            failButton.setTitle("Fail", forState: .Normal)
        }
    }
    
    func updateTheme() {
        
        passButton.backgroundColor = (action == .ProposeMission || action == .ProposalResult) ? Theme.asc_blueColor() : Theme.asc_greenColor()
        
        failButton.backgroundColor = Theme.asc_redColor()
        
        view.backgroundColor = Theme.asc_baseColor()
        
        tableView.separatorColor = Theme.asc_separatorColor()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch action {
        case .ProposalResult:   return proposalResult.missionMembers.count
        default:                return actionMembers.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.playerCell) else {
            fatalError("Unable to dequeue a player cell")
        }
        
        return configurePlayerCell(cell, forIndexPath: indexPath)
    }
    
    func configurePlayerCell(cell: PlayerCell, forIndexPath indexPath: NSIndexPath) -> PlayerCell {
        
        let player = actionMembers[indexPath.row]

        cell.nameLabel.text = player.name
        
        if action == .ProposalResult {
            cell.teamView.backgroundColor == proposalResult.votes[player.id] ? Theme.asc_greenColor() : Theme.asc_redColor()
        }
        else if game.player.team == .Good && game.player == player {
            cell.teamView.backgroundColor = Theme.asc_greenColor()
        }
        else {
            cell.teamView.backgroundColor = player.teamColor
        }
        
        return cell
    }
    
    func setCell(cell: UITableViewCell?, selected: Bool) {
        cell?.accessoryType = selected ? .Checkmark : .None
        passButton.enabled = tableView.indexPathsForSelectedRows?.count == numberOfPlayersForProposal
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
       
        // Only allow selection if we're proposing
        guard action == .ProposeMission else {
            return nil
        }
        
        return indexPath
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        setCell(tableView.cellForRowAtIndexPath(indexPath), selected: true)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        setCell(tableView.cellForRowAtIndexPath(indexPath), selected: false)
    }
    
    @IBAction func votePressed(sender: AscendantButton) {
        
        sender.startActivity()
        
        passButton.enabled = false
        failButton.enabled = false
        
        let vote = Bool(sender.tag)
        
        func parseResult(result: AckResult) {
            
            passButton.stopActivity()
            failButton.stopActivity()
            
            switch result {
            case .Success:              dismissViewControllerAnimated(true, completion: nil)
            case .Error(let message):   showAlert("Error", message: message)
            }
        }
        
        switch action {
        case .ProposalVote:
            Socket.manager.proposalVote(game, vote: vote){ result in
                parseResult(result)
            }
        case .MissionVote:
            Socket.manager.missionVote(game, vote: vote){ result in
                parseResult(result)
            }
        case .ProposeMission:
            
            guard let selectedRows = tableView.indexPathsForSelectedRows?.map({ $0.row }) else {
                return
            }
            
            let players = actionMembers.enumerate().flatMap { index, player in
                return selectedRows.contains(index) ? player : nil
            }
            
            Socket.manager.proposeMission(game, players: players) { result in
                parseResult(result)
            }
        case .ProposalResult:
            if proposalResult.pass {
                
            }
            else {
                
            }
        }
    }
}

enum Action {
    case ProposeMission
    case ProposalVote
    case ProposalResult
    case MissionVote
}
