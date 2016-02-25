//
//  CreateViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import Async

class CreateViewController: WelcomeBaseViewController {
    
    var playerName = "Kyle"
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        createGame()
    }
    
    func setUpUI() {
        view.backgroundColor = UIColor.asc_baseColor()
    }
    
    func createGame() {
        
        Socket.manager.createGame(playerName) { game in
            if let game = game {
                
                self.game = game
                
                Async.main(after: 0.5) {
                    self.performSegueWithIdentifier(R.segue.createViewController.startViewController, sender: self)
                }
            }
            else {
                self.pageController.showWelcome(true)
                self.showAlert("Error", message: "We couldn't start a game right now - try again soon!")
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if let destination = segue.destinationViewController as? StartViewController {
            destination.game = game
        }
    }
}
