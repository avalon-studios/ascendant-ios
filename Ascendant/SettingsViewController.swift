//
//  SettingsViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/29/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, Themable {
    
    @IBOutlet weak var darkThemeCell: UITableViewCell!
    @IBOutlet weak var mediumThemeCell: UITableViewCell!
    @IBOutlet weak var lightThemeCell: UITableViewCell!
    @IBOutlet var labels: [UILabel]!
    
    lazy var cells: [UITableViewCell] = [self.darkThemeCell, self.mediumThemeCell, self.lightThemeCell]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCheckedTheme()
        
        updateTheme()
    }
    
    func updateTheme() {
        
        cells.forEach {
            $0.backgroundColor = Theme.cellBackgroundColor()
        }
        
        labels.forEach {
            $0.textColor = Theme.asc_defaultTextColor()
        }
        
        tableView.tintColor = Theme.asc_defaultTextColor()
        tableView.backgroundColor = Theme.asc_baseColor()
        tableView.separatorColor = Theme.asc_separatorColor()
    }
    
    func setCheckedTheme() {
        
        cells.forEach {
            $0.accessoryType = .None
        }
        
        switch Theme.theme {
        case .Dark:     darkThemeCell.accessoryType = .Checkmark
        case .Medium:   mediumThemeCell.accessoryType = .Checkmark
        case .Light:    lightThemeCell.accessoryType = .Checkmark
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) else {
            return
        }
        
        switch cell {
        case darkThemeCell:     Theme.theme = .Dark
        case mediumThemeCell:   Theme.theme = .Medium
        case lightThemeCell:    Theme.theme = .Light
        default: break
        }
        
        setCheckedTheme()
        
        let refreshVC = R.storyboard.settings.initialViewController()!
        
        refreshVC.view.userInteractionEnabled = false
        refreshVC.modalTransitionStyle = .CrossDissolve
        
        self.presentViewController(refreshVC, animated: true) { _ in
            self.updateTheme()
            self.dismissViewControllerAnimated(false, completion: nil)
        }
    }
}