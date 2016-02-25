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
    
    weak var pageController: WelcomePageViewController!

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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(showWelcome))

        roomCodeTextField.attributedPlaceholder = NSAttributedString(string: "Room Code", attributes: [NSForegroundColorAttributeName: UIColor.asc_transparentWhiteColor()])

        tableView.backgroundColor = UIColor.asc_baseColor()
    }
    
    @IBAction func joinButtonPressed(sender: UIButton) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dest = segue.destinationViewController as? WelcomeBaseViewController {
            dest.pageController = pageController
        }
    }
    
    @objc func showWelcome() {
        pageController.showWelcome(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.enabled = false
        
        return false
    }
}
