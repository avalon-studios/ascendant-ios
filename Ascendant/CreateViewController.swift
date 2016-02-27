//
//  CreateViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import Async

class CreateViewController: UITableViewController, Themable, UITextFieldDelegate {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Properties
    
    var game: Game!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTheme()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        nameTextField.becomeFirstResponder()
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? StartViewController {
            destination.game = game
        }
    }
    
    
    // MARK: - Style
    
    func updateTheme() {
        
        view.backgroundColor = Theme.asc_baseColor()
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: nameTextField.placeholder ?? "", attributes: [NSForegroundColorAttributeName: Theme.asc_transparentWhiteColor()])
    }

    
    // MARK: - Utility
    
    func createGame(name: String) {
        
        // Start the spinner and disable the text fields
        setLoading(true)
        
        // Attempt to create the game
        Socket.manager.createGame(name) { [weak self] game in
            
            // End the spinning and enable the text fields
            self?.setLoading(false)

            // Try to grab the game, and continue if we made one
            if let game = game {
                self?.game = game
                game.creator = true
                self?.performSegueWithIdentifier(R.segue.createViewController.startViewController, sender: self)
            }
            else {
                // We couldn't make a game, tell the use :(
                self?.showAlert("Error", message: "We couldn't start a game right now - try again soon!") { _ in
                    self?.nameTextField.becomeFirstResponder()
                }
            }
        }
    }
    
    func setLoading(loading: Bool) {
        nameTextField.enabled = !loading
        loading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let name = textField.validName() {
            createGame(name)
        }
        
        return false
    }
}
