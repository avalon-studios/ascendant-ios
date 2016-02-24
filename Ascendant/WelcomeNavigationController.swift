//
//  SmallNavigationController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import VCTransitionsLibrary

class WelcomeNavigationController: UINavigationController, UINavigationControllerDelegate {

    lazy var animator: CECrossfadeAnimationController = {
        let animator = CECrossfadeAnimationController()
        animator.duration = 0.2
        return animator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
}
