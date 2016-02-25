//
//  CreateViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class CreateViewController: WelcomeBaseViewController {
    
    var playerName = "Kyle"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    
        Socket.manager.createGame(playerName) { game in
            if let game = game {
                self.beginGame(game)
            }
            else {
                self.showAlert("Error", message: "We couldn't start a game right now - try again soon!")
            }
        }
    }
    
    func setUpUI() {
        view.backgroundColor = UIColor.asc_baseColor()
    }
    
    func beginGame(game: Game) {
        
        let gameViewController = R.storyboard.gamePlay.initialViewController()!
        
        Socket.manager.game = game
        gameViewController.game = game
        
        presentViewController(gameViewController, animated: true, completion: nil)
    }
}
