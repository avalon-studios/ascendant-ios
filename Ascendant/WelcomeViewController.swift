//
//  ViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import ElegantPresentations

class WelcomeViewController: UIViewController, Themable, UIViewControllerTransitioningDelegate {

    
    // MARK: - Outlets
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var separatorView: UIView!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var startGameButton: AscendantButton!
    @IBOutlet var joinGameButton: AscendantButton!
    @IBOutlet var rulesButton: AscendantButton!
    @IBOutlet var settingsButton: AscendantButton!
    @IBOutlet var rocketImageView: UIImageView!
    @IBOutlet weak var moonImageView: UIImageView!
    @IBOutlet var rocketView: UIView!
    
    var rocketDidAnimate = false
    var didUpdateConstraints = false
    
    // MARK: — Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rocketView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rocketView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        updateTheme()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        animateRocket()
    }
    
    
    // MARK: - Style
    
    // Set all the views colors
    func updateTheme() {
        
        view.backgroundColor = Theme.asc_baseColor()
        rocketView.backgroundColor = UIColor(hex: "#2C2E3D")
        
        titleLabel.textColor = Theme.asc_defaultTextColor().colorWithAlphaComponent(0.9)
        
        separatorView.backgroundColor = Theme.asc_separatorColor()
        
        subTitleLabel.textColor = Theme.asc_defaultTextColor()
        
        [startGameButton, joinGameButton, rulesButton, settingsButton].forEach {
            $0.backgroundColor = Theme.asc_transparentColor()
            $0.setTitleColor(Theme.asc_buttonTextColor(), forState: .Normal)
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return Theme.asc_statusBarStyle()
    }
    
    func animateRocket() {
        
        guard !rocketDidAnimate else { return }
        
        rocketDidAnimate = true
        
        UIView.animateWithDuration(0.6, delay: 0.6, options: [.CurveEaseIn],
            animations: {
            
                self.setNeedsStatusBarAppearanceUpdate()
                
                let x = self.rocketView.frame.width + self.rocketImageView.frame.width
                let y = -self.rocketImageView.frame.height
            
                self.rocketImageView.layer.position = CGPoint(x: x, y: y)
                self.rocketImageView.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1)
                
                self.moonImageView.layer.transform = CATransform3DMakeScale(0.001, 0.001, 1)
                self.moonImageView.alpha = 0
                
                self.rocketView.backgroundColor = UIColor.clearColor()
            },
            completion: { _ in
                self.rocketView.removeFromSuperview()
            }
        )
    }
    
    override func updateViewConstraints() {
        
        if !didUpdateConstraints {
            
            rocketView.autoPinEdgesToSuperviewEdges()
            
            didUpdateConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return !rocketDidAnimate
    }
    
    
    // MARK: - Navigation
    
    // Set these for the custom presentation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier != R.segue.welcomeViewController.settingsSegue.identifier {
            segue.destinationViewController.modalPresentationStyle = .Custom
            segue.destinationViewController.transitioningDelegate = self
        }
    }
    
    // Unwind segue, also dismiss the keyboard
    @IBAction func unwindToWelcome(segue: UIStoryboardSegue) {
        segue.sourceViewController.view.endEditing(true)
        Socket.manager.leaveGame()
    }
    
    // Conform to UIViewControllerTransitioningDelegate
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return ElegantPresentations.controller(presentedViewController: presented, presentingViewController: presenting, options: [])
    }
}
