//
//  CreateViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import Async

class CreateViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
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
        
        view.backgroundColor = UIColor.asc_baseColor()
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: nameTextField.placeholder ?? "", attributes: [NSForegroundColorAttributeName: UIColor.asc_transparentWhiteColor()])
        
        nameTextField.text = Player.lastUsedName
    }
    
    func createGame(name: String) {
        
        setLoading(true)
        
        Socket.manager.createGame(name) { [weak self] game in
            
            self?.setLoading(false)

            if let game = game {
                self?.game = game
                self?.performSegueWithIdentifier(R.segue.createViewController.startViewController, sender: self)
            }
            else {
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {        
        if let destination = segue.destinationViewController as? StartViewController {
            destination.game = game
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let name = textField.validName() {
            
            Player.lastUsedName = name
            
            createGame(name)
        }
        
        return false
    }
}
