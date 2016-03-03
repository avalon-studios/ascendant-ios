//
//  RulesViewController.swift
//  Ascendant
//
//  Created by Kyle Bashour on 3/2/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit

class RulesViewController: UIViewController, Themable {
    
    @IBOutlet weak var rulesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        updateTheme()
        
        loadRules()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        rulesTextView.setContentOffset(CGPoint.zero, animated: false)
        
        UIView.animateWithDuration(0.1) {
            self.rulesTextView.alpha = 1
        }
    }
    
    func setUpUI() {
        rulesTextView.backgroundColor = UIColor.clearColor()
        rulesTextView.alpha = 0
    }
    
    func updateTheme() {
        
        view.backgroundColor = Theme.asc_baseColor()
        
        rulesTextView.textColor = Theme.asc_defaultTextColor()
    }
    
    func loadRules() {
        
        rulesTextView.text = ""
        
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
        
        rulesTextView.attributedText = attributedRules
    }
}
