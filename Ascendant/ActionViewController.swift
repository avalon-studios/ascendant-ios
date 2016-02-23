//
//  ActionViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/23/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class ActionViewController: UITableViewController {
    
    @IBOutlet var passButton: UIBarButtonItem!
    @IBOutlet var failButton: UIBarButtonItem!
    
    var action = Action.missionVote
    var players: [Player]!
    var numberOfPlayersForProposal = 0
    
    var actionMessage: String {
        switch action {
        case .proposeMission: return "Select \(numberOfPlayersForProposal) players to propose a mission"
        case .proposalVote: return "Would you like to approve the following players for a mission?"
        case .missionVote: return "Vote on whether or not this mission succeeds. The following players are also voting"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    func setUpUI() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        
        switch action {
        case .proposeMission:
            navigationItem.leftBarButtonItem = nil
            passButton.title = "Propose"
        case .proposalVote:
            passButton.title = "Approve"
            failButton.title = "Deny"
        case .missionVote:
            passButton.title = "Pass"
            failButton.title = "Fail"
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0, let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.actionMessageCell) {
            cell.messageLabel.text = actionMessage
            return cell
        }
        else if indexPath.row > 0, let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.playerCell) {
            cell.setPlayer(players[indexPath.row - 1])
            return cell
        }
        
        assertionFailure("Unable to dequeue proper cell")
        
        return UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        // We can only select cells if we're proposing a mission
        guard action == .proposeMission else {
            return nil
        }
        
        // Only allow them to select the maximum needed
        guard tableView.indexPathsForSelectedRows?.count < numberOfPlayersForProposal else {
            return nil
        }
        
        // Can't select the header cell!
        guard indexPath.row > 0 else {
            return nil
        }
     
        // Okay, we can select this!
        return indexPath
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .None
    }
}

enum Action {
    case proposeMission
    case proposalVote
    case missionVote
}
