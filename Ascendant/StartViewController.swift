//
//  StartViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class StartViewController: WelcomeBaseViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var waitingMessageLabel: UILabel!
    @IBOutlet weak var buttonContainer: UIView!
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        
        navigationItem.title = "Room Code: \(game.id)"
        
        setUpUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(reloadTableView), name: Game.updatePlayers, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func setUpUI() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.dataSource = self
        
        view.backgroundColor = UIColor.asc_baseColor()
    }
    
    @objc func reloadTableView() {
        tableView.reloadData()
    }
    
    @IBAction func joinGamePressed(sender: UIButton) {
        beginGame()
    }
    
    func beginGame() {
        
        let gameViewController = R.storyboard.gamePlay.initialViewController()!
        
        Socket.manager.game = game
        gameViewController.game = game
        
        presentViewController(gameViewController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        waitingMessageLabel.hidden = game.players.count != 0
        
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
 