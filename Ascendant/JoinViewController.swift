//
//  JoinViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import Async

class JoinViewController: UITableViewController, Themable, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var roomCodeTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = NSUserDefaults.lastUsedName
        
        updateTheme()
        
        setUpUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.lastUsedName == nil {
            nameTextField.becomeFirstResponder()
        }
        else {
            roomCodeTextField.becomeFirstResponder()
        }
    }
    
    func setUpUI() {
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: nameTextField.placeholder ?? "", attributes: [NSForegroundColorAttributeName: Theme.asc_transparentColor()])
        roomCodeTextField.attributedPlaceholder = NSAttributedString(string: roomCodeTextField.placeholder ?? "", attributes: [NSForegroundColorAttributeName: Theme.asc_transparentColor()])
    }
    
    func updateTheme() {
        
        tableView.backgroundColor = Theme.asc_baseColor()
        tableView.separatorColor = Theme.asc_separatorColor()
        
        nameTextField.textColor = Theme.asc_defaultTextColor()
        nameTextField.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        nameTextField.tintColor = Theme.asc_blueColor()
        nameTextField.keyboardAppearance = Theme.asc_keyboardAppearance()
        
        roomCodeTextField.textColor = Theme.asc_defaultTextColor()
        roomCodeTextField.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        roomCodeTextField.tintColor = Theme.asc_blueColor()
        roomCodeTextField.keyboardAppearance = Theme.asc_keyboardAppearance()
        
        activityIndicator.color = Theme.asc_defaultTextColor()        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? StartViewController {
            destination.game = game
        }
    }
    
    func joinGame(gameID: String, name: String) {
        
        setLoading(true)
        
        Socket.manager.joinGame(gameID, playerName: name) { [weak self] game in
            
            self?.setLoading(false)

            if let game = game {
                self?.game = game
                self?.performSegueWithIdentifier(R.segue.joinViewController.waitViewController, sender: self)
            }
            else {
                self?.showAlert("Error", message: "We couldn't join that game right now. Make sure you're entering a valid room code.") { _ in
                    self?.roomCodeTextField.becomeFirstResponder()
                }
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField === nameTextField {
            roomCodeTextField.becomeFirstResponder()
        }
        else if let name = nameTextField.validName(), gameID = roomCodeTextField.validGameID() {
            
            NSUserDefaults.lastUsedName = name

            joinGame(gameID, name: name)
        }
        
        return false
    }
    
    func setLoading(loading: Bool) {
        nameTextField.enabled = !loading
        roomCodeTextField.enabled = !loading
        loading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}
