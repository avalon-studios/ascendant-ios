//
//  StartViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerViewLineHeightConstraint: NSLayoutConstraint!
    
    var game: Game!
    var players = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        players = game.players
        tableView.reloadData()
        navigationItem.title = "Room Code: \(game.id.uppercaseString)"
        
        setUpUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(beginGame), name: Socket.rolesAssignedNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updatePlayersTable), name: Socket.updatedPlayers, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func setUpUI() {
        
        headerViewLineHeightConstraint.constant = 0.5
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70
        tableView.dataSource = self
        
        view.backgroundColor = Theme.asc_baseColor()
        
        if !game.creator { buttonContainerHeightConstraint.constant = 0 }
    }

    @IBAction func startGamePressed(sender: UIButton) {
        
        Socket.manager.startGame(game) { [weak self] result in
            
            switch result {
            case .Success:              self?.beginGame()
            case .Error(let message):   self?.showAlert("Error", message: message)
            }
        }
    }
    
    @objc func beginGame() {
        
        let gameViewController = R.storyboard.gamePlay.initialViewController()!
        
        gameViewController.game = game
        
        dismissViewControllerAnimated(true) {
            self.presentingViewController?.presentViewController(gameViewController, animated: true, completion: nil)
        }
    }
    
    @objc func updatePlayersTable() {
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.players.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.welcomePlayerCell) else {
            fatalError("Unable to deque a welcome player cell")
        }
        
        cell.nameLabel.text = game.players[indexPath.row].name
        
        return cell
    }
}
 