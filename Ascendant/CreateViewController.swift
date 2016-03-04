//
//  CreateViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class CreateViewController: UITableViewController, Themable, UITextFieldDelegate {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    // MARK: - Properties
    
    var game: Game!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = NSUserDefaults.lastUsedName
        
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

        tableView.separatorColor = Theme.asc_separatorColor()

        activityIndicator.color = Theme.asc_defaultTextColor()
        
        nameTextField.backgroundColor = Theme.cellBackgroundColor()
        nameTextField.tintColor = Theme.asc_blueColor()
        nameTextField.textColor = Theme.asc_defaultTextColor()
        nameTextField.keyboardAppearance = Theme.asc_keyboardAppearance()
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: nameTextField.placeholder ?? "", attributes: [NSForegroundColorAttributeName: Theme.asc_transparentColor()])
    }

    
    // MARK: - Utility
    
    func createGame(name: String) {
        
        // Start the spinner and disable the text fields
        setLoading(true)
        
        // Attempt to create the game
        Socket.manager.createGame(name) { [weak self] game in

            // Try to grab the game, and continue if we made one
            if let game = game {
                self?.game = game
                self?.performSegueWithIdentifier(R.segue.createViewController.startViewController, sender: self)
            }
            else {
                // End the spinning and enable the text fields
                self?.setLoading(false)
                
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
            
            NSUserDefaults.lastUsedName = name
            
            createGame(name)
        }
        
        return false
    }
}
