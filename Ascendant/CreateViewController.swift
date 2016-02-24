//
//  CreateViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class CreateViewController: WelcomeBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    
        Game.createGame { (game, errorMessage) in
            if let game = game {
                self.beginGame(game)
            }
            else {
                self.showAlert("Error", message: errorMessage)
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
