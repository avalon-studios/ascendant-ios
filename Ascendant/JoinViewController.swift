//
//  JoinViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class JoinViewController: UITableViewController, Themable, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var roomCodeTextField: UITextField!
    @IBOutlet weak var nearbyLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nearbyIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nearbyCell: UITableViewCell!
    
    lazy var browser: MCNearbyServiceBrowser = {
        
        let peerID = MCPeerID(displayName: NSUserDefaults.lastUsedName ?? "Unknown")
        let browser = MCNearbyServiceBrowser(peer: peerID, serviceType: StartViewController.joinService)
        
        browser.delegate = self
        
        return browser
    }()
    
    var game: Game!
    
    var discoveredGameID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = NSUserDefaults.lastUsedName
        
        updateTheme()
        
        setUpUI()
        
        browser.startBrowsingForPeers()
        nearbyIndicator.startAnimating()
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
        nameTextField.backgroundColor = Theme.cellBackgroundColor()
        nameTextField.tintColor = Theme.asc_blueColor()
        nameTextField.keyboardAppearance = Theme.asc_keyboardAppearance()
        
        roomCodeTextField.textColor = Theme.asc_defaultTextColor()
        roomCodeTextField.backgroundColor = Theme.cellBackgroundColor()
        roomCodeTextField.tintColor = Theme.asc_blueColor()
        roomCodeTextField.keyboardAppearance = Theme.asc_keyboardAppearance()
        
        nearbyLabel.textColor = Theme.asc_transparentColor()
        
        nearbyCell.backgroundColor = Theme.cellBackgroundColor()
        
        activityIndicator.color = Theme.asc_defaultTextColor()
        nearbyIndicator.color = Theme.asc_defaultTextColor()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? StartViewController {
            destination.game = game
        }
    }
    
    func joinGame(gameID: String, name: String) {
        
        setLoading(true)
        
        Socket.manager.joinGame(gameID, playerName: name) { [weak self] game in
            
            if let game = game {
                self?.game = game
                self?.performSegueWithIdentifier(R.segue.joinViewController.waitViewController, sender: self)
            }
            else {

                self?.setLoading(false)

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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) where cell === nearbyCell else {
            return
        }
        
        guard let gameID = discoveredGameID else {
            return
        }
        
        guard let name = nameTextField.validName() else {
            showAlert("Please Enter a Name", message: nil)
            return
        }
        
        roomCodeTextField.text = gameID
        
        joinGame(gameID, name: name)
    }
}

extension JoinViewController: MCNearbyServiceBrowserDelegate {
 
    func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        
        // Get the game ID — if it's the same as one we've seen, ignore it
        guard let gameID = info?["game_id"] where gameID != discoveredGameID else {
            return
        }
        
        discoveredGameID = gameID
        
        nearbyLabel.textColor = Theme.asc_defaultTextColor().colorWithAlphaComponent(0.7)
        nearbyLabel.text = peerID.displayName
        nearbyCell.accessoryType = .DisclosureIndicator
        nearbyIndicator.stopAnimating()
    }
    
    func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) { }
    
    func browser(browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: NSError) { }
}
