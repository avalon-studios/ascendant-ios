//
//  ViewController.swift
//  Avalon
//
//  Created by Kyle Bashour on 1/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class JoinGameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    func play() {
        
        var game = GameManager(currentGameID: "1234", myPlayer: Player(), allPlayers: [Player(), Player(), Player()], currentLeader: Player(), numberOfRequiredPlayersForCurrentMission: 2, currentMission: 0, completedMissions: [Bool](), networkManager: nil)
        let networkManager = SocketManager()
        
        game.networkManager = networkManager
        game.networkManager?.proposeMission(game.allPlayers)
    }
    
    func setUpUI() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
    }
    
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
}
