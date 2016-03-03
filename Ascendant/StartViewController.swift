//
//  StartViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class StartViewController: UIViewController, Themable, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startButton: AscendantButton!
    @IBOutlet weak var buttonContainerView: UIView!
    
    static let joinService = "ascendant-join"
    
    lazy var advertiser: MCNearbyServiceAdvertiser = {
       
        let peerID = MCPeerID(displayName: "\(self.game.player.name) (\(self.game.id))")
        let advertiser = MCNearbyServiceAdvertiser(peer: peerID,
                                                  discoveryInfo: ["game_id": self.game.id],
                                                  serviceType: StartViewController.joinService)
        advertiser.delegate = self
        
        return advertiser
    }()
    
    var game: Game!
    var players = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        players = game.players
        tableView.reloadData()
        navigationItem.title = "Room Code: \(game.id.uppercaseString)"
        
        updateTheme()
        setUpUI()
        
        if game.rejoin {
            beginGame()
        }
        
        advertiser.startAdvertisingPeer()
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
    
    func updateTheme() {
        
        view.backgroundColor = Theme.asc_baseColor()
        tableView.separatorColor = Theme.asc_separatorColor()
    }
    
    func setUpUI() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70
        tableView.dataSource = self
        
        if !game.creator { buttonContainerView.removeFromSuperview() }
    }

    @IBAction func startGamePressed(sender: AscendantButton) {
        
        sender.startActivity()
            
        Socket.manager.startGame(game) { [weak self] result in
            
            sender.stopActivity()

            switch result {
            case .Success:              break
            case .Error(let message):   self?.showAlert("Error", message: message)
            }
        }
    }
    
    @objc func beginGame() {
        
        let gameViewController = R.storyboard.gamePlay.initialViewController()!
        let presentingViewController = self.presentingViewController

        gameViewController.game = game        
        
        dismissViewControllerAnimated(true) {
            presentingViewController?.presentViewController(gameViewController, animated: true, completion: nil)
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

extension StartViewController: MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: NSError) {
        
        
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: (Bool, MCSession) -> Void) {
        
        
    }
}
