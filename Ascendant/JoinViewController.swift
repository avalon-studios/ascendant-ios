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
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var roomCodeTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        nameTextField.becomeFirstResponder()
    }
    
    func setUpUI() {
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: nameTextField.placeholder ?? "", attributes: [NSForegroundColorAttributeName: UIColor.asc_transparentWhiteColor()])
        roomCodeTextField.attributedPlaceholder = NSAttributedString(string: roomCodeTextField.placeholder ?? "", attributes: [NSForegroundColorAttributeName: UIColor.asc_transparentWhiteColor()])
        
        tableView.backgroundColor = UIColor.asc_baseColor()
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
                self?.showAlert("Error", message: "We couldn't join that game right now - try again soon!") { _ in
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
