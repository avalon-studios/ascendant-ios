//
//  SettingsViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/29/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class SettingsViewController: UITableViewController, Themable, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var darkThemeCell: UITableViewCell!
    @IBOutlet weak var mediumThemeCell: UITableViewCell!
    @IBOutlet weak var lightThemeCell: UITableViewCell!
    @IBOutlet weak var websiteCell: UITableViewCell!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var privacyCell: UITableViewCell!
    @IBOutlet weak var betaFeedbackCell: SettingsCell!
    @IBOutlet var labels: [UILabel]!
    
    lazy var cells: [UITableViewCell] = [self.darkThemeCell, self.mediumThemeCell, self.lightThemeCell]
    
    var versionNumber: String {
        if let version = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as? String,
            build = NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleVersionKey as String) as? String
        {
            return "\(version) (\(build))"
        }
        return "Unknown"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setVersionNumber()
        setCheckedTheme()
        
        updateTheme()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        deSelectCells(animated)
    }
    
    func deSelectCells(animated: Bool) {
        tableView.indexPathsForSelectedRows?.forEach {
            tableView.deselectRowAtIndexPath($0, animated: true)
        }
    }
    
    func setVersionNumber() {
        versionLabel.text = "Version \(versionNumber)"
    }
    
    func updateTheme() {
        
        tableView.reloadData()
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
        case darkThemeCell:     setTheme(.Dark)
        case mediumThemeCell:   setTheme(.Medium)
        case lightThemeCell:    setTheme(.Light)
        case websiteCell:       presentSafariViewControllerWithURL("http://ascendant.space")
        case privacyCell:       presentSafariViewControllerWithURL("http://ascendant.space/privacy")
        case betaFeedbackCell:  presentFeedbackEmailForm()
        default:                return
        }
    }
    
    func setTheme(theme: ThemeStyle) {
        
        Theme.theme = theme
        
        setCheckedTheme()
        
        /*
         So, you can't refresh UIAppearance on existing views -
         they have to be removed from view and re-added.
         
         What we do is create a brand new settings view controller,
         present it with a crossfade, update the theme here, and
         dismiss it with no animation. By presenting and bring back
         this view controller, it updates the nav bar and tableview
         header/footer labels, which are set with UIAppearance. We
         also get a nice fade animation to the new theme.
         */
        
        let refreshVC = R.storyboard.settings.settingsViewController()!
        let navigationController = UINavigationController(rootViewController: refreshVC)
        
        refreshVC.tableView.contentOffset = tableView.contentOffset
        refreshVC.view.userInteractionEnabled = false
        refreshVC.modalTransitionStyle = .CrossDissolve
        
        self.presentViewController(navigationController, animated: true) { _ in
            self.updateTheme()
            self.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    func presentSafariViewControllerWithURL(url: String) {
        
        guard let url = NSURL(string: url) else { return }
        
        let safariVC = SFSafariViewController(URL: url)
        
        presentViewController(safariVC, animated: true, completion: nil)
    }
    
    func presentFeedbackEmailForm() {
        
        Theme.setAppearanceForMail()

        let mailComposeViewController = MFMailComposeViewController()
        
        mailComposeViewController.mailComposeDelegate = self
        mailComposeViewController.setToRecipients(["kylebshr@me.com"])
        mailComposeViewController.setSubject("Ascendant Beta Feedback")
        mailComposeViewController.setMessageBody("Feedback: \n\n\n\nDevice: \(UIDevice.currentDevice().modelName)\nVersion: \(versionNumber)", isHTML: false)
        
        if MFMailComposeViewController.canSendMail() {
            presentViewController(mailComposeViewController, animated: true) {
                self.deSelectCells(false)
            }
        }
        else {
            self.showAlert("No Email Configured", message: "Please make sure you have an email account set up in your settings")
        }
        
        Theme.setAppearances()
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
