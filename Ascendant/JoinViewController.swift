//
//  JoinViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import Async

class JoinViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var roomCodeTextField: UITextField!
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        Async.main(after: 0.1) {
            self.roomCodeTextField.becomeFirstResponder()
        }
    }
    
    func setUpUI() {
        
        roomCodeTextField.attributedPlaceholder = NSAttributedString(string: "Room Code", attributes: [NSForegroundColorAttributeName: UIColor.asc_transparentWhiteColor()])

        tableView.backgroundColor = UIColor.asc_baseColor()
    }
    
    @IBAction func joinButtonPressed(sender: UIButton) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let destination = segue.destinationViewController as? StartViewController {
            let _ = destination.view
            destination.game = game
            destination.buttonContainerView.removeFromSuperview()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
                
        let gameID = textField.text!
        Socket.manager.joinGame("Joseph", gameID: gameID) { game in
            if let game = game {
                
                self.game = game
                
                Async.main(after: 0.5) {
                    self.performSegueWithIdentifier(R.segue.joinViewController.waitViewController, sender: self)
                }
            }
            else {
                self.showAlert("Error", message: "We couldn't join that game right now - try again soon!")
            }
        }
        
        return false
    }
}
