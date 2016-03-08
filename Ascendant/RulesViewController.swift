//
//  RulesViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 3/2/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class RulesViewController: UIViewController, Themable {
    
    @IBOutlet weak var rulesLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTheme()
        
        loadRules()
    }
    
    func updateTheme() {
        
        view.backgroundColor = Theme.asc_baseColor()
        
        rulesLabel.textColor = Theme.asc_defaultTextColor()
    }
    
    func loadRules() {
        
        guard let
            rulePath = NSBundle.mainBundle().pathForResource("rules", ofType: "html"),
            ruleString = try? String(contentsOfFile: rulePath),
            data = ruleString.dataUsingEncoding(NSUTF8StringEncoding),
            attributedRules = try? NSMutableAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        else {
            return
        }
        
        let attributes = [NSForegroundColorAttributeName: Theme.asc_defaultTextColor(), NSBackgroundColorAttributeName: UIColor.clearColor()]
        
        attributedRules.beginEditing()
        attributedRules.addAttributes(attributes, range: NSRange(location: 0, length: attributedRules.length))
        attributedRules.endEditing()
        
        rulesLabel.attributedText = attributedRules
    }
}
