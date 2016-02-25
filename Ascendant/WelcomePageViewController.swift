//
//  WelcomePageViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/24/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class WelcomePageViewController: UIPageViewController {
    
    lazy var welcomeViewController: UIViewController = {
    
        let welcomeViewController = R.storyboard.welcome.welcomeViewController()!
        
        welcomeViewController.pageController = self
        
        return welcomeViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        showWelcome(false)
    }
    
    func showWelcome(animated: Bool) {
        setViewControllers([welcomeViewController], direction: .Reverse, animated: animated, completion: nil)
    }
    
    func setUpViewController(viewController: WelcomeBaseViewController) -> UINavigationController {
        
        let navigationController = WelcomeNavigationController(rootViewController: viewController)
        
        viewController.pageController = self
        
        return navigationController
    }
    
    func setJoinUpViewController(viewController: JoinViewController) -> UINavigationController {
        
        let navigationController = WelcomeNavigationController(rootViewController: viewController)
        
        viewController.pageController = self
        
        return navigationController
    }
    
    func showCreateGame() {
        let navigationController = setUpViewController(R.storyboard.welcome.createViewController()!)
        setViewControllers([navigationController], direction: .Forward, animated: true, completion: nil)
    }
    
    func showJoinGame() {
        let navigationController = setJoinUpViewController(R.storyboard.welcome.joinViewController()!)
        setViewControllers([navigationController], direction: .Forward, animated: true, completion: nil)
    }
    
    func showAbout() {
        
    }
    
    func showRules() {
        
    }
}
