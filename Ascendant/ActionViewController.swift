//
//  ActionViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/23/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import EXTView

class ActionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var passButton: EXTButton!
    @IBOutlet weak var failButton: EXTButton!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var game: Game!
    var action = Action.MissionVote
    var actionMembers: [Player]!
    var numberOfPlayersForProposal = 0
    
    var actionMessage: String {
        switch action {
        case .ProposeMission: return "Select \(numberOfPlayersForProposal) Players for a Mission"
        case .ProposalVote: return "Approve Players for a Mission"
        case .MissionVote: return "Pass the Mission?"
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
        case .ProposeMission:
            failButton.hidden = true
            passButton.setTitle("Propose", forState: .Normal)
            passButton.backgroundColor = Theme.asc_blueColor()
            passButton.enabled = false
        case .ProposalVote:
            passButton.setTitle("Approve", forState: .Normal)
            failButton.setTitle("Deny", forState: .Normal)
        case .MissionVote:
            passButton.setTitle("Pass", forState: .Normal)
            failButton.setTitle("Fail", forState: .Normal)
        }
        
        
        // THEME
        
        view.backgroundColor = Theme.asc_baseColor()
        tableView.separatorColor = Theme.asc_separatorColor()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionMembers.count
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
        
        if game.player.team == .Bad {
            cell.teamView.backgroundColor = player.teamColor
        }
        else if game.player.id == player.id {
            cell.teamView.backgroundColor = Theme.asc_greenColor()
        }
        else {
            cell.teamView.backgroundColor = Theme.asc_transparentWhiteColor()
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
    
    @IBAction func votePressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

enum Action {
    case ProposeMission
    case ProposalVote
    case MissionVote
}
