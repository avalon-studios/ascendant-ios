//
//  ViewController.swift
//  Avalon
//
//  Created by Kyle Bashour on 1/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class JoinGameViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    func play() {

    }
    
    func setUpUI() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
    }
    
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func testEndpointPressed(sender: UIButton) {
    
    }
}
