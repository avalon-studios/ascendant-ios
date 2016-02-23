//
//  ActionViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/23/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import EXTView

class ActionViewController: UIViewController {
    
    
    @IBOutlet weak var passButton: EXTButton!
    @IBOutlet weak var failButton: EXTButton!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    var action = Action.missionVote
    var players: [Player]!
    var numberOfPlayersForProposal = 0
    
    var actionMessage: String {
        switch action {
        case .proposeMission: return "Select \(numberOfPlayersForProposal) Players for a Mission"
        case .proposalVote: return "Approve Players for a Mission"
        case .missionVote: return "Pass the Mission?"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    func setUpUI() {
        
        navigationItem.title = actionMessage
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        
        switch action {
        case .proposeMission:
            failButton.hidden = true
            passButton.setTitle("Propose", forState: .Normal)
            passButton.backgroundColor = Style.blue
        case .proposalVote:
            passButton.setTitle("Approve", forState: .Normal)
            failButton.setTitle("Deny", forState: .Normal)
        case .missionVote:
            passButton.setTitle("Pass", forState: .Normal)
            failButton.setTitle("Fail", forState: .Normal)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       if let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.playerCell) {
            cell.setPlayer(players[indexPath.row])
            return cell
        }
        
        assertionFailure("Unable to dequeue proper cell")
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        // We can only select cells if we're proposing a mission
        guard action == .proposeMission else {
            return nil
        }
        
        // Only allow them to select the maximum needed
        guard tableView.indexPathsForSelectedRows?.count < numberOfPlayersForProposal else {
            return nil
        }
        
        // Okay, we can select this!
        return indexPath
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .None
    }
    
    @IBAction func votePressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

enum Action {
    case proposeMission
    case proposalVote
    case missionVote
}
