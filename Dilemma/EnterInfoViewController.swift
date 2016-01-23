//
//  File.swift
//  Dilemma
//
//  Created by Kyle Bashour on 1/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import Starscream

class EnterInfoViewController: UIViewController, WebSocketDelegate {
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var userNameTextField: UITextField!
    
    var inbox = WebSocket(url: NSURL(string: Constants.Web.inboxEndpoint)!)
    var outbox = WebSocket(url: NSURL(string: Constants.Web.outboxEndpoint)!)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inbox.delegate = self
        outbox.delegate = self
        
        inbox.connect()
        outbox.connect()
        
        NSNotificationCenter.defaultCenter().addObserverForName(
            UIKeyboardWillChangeFrameNotification,
            object: nil,
            queue: nil
        ) { [weak self] notification in
            
            let userInfo = notification.userInfo!
            let height = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.height

            self?.bottomConstraint.constant = height
            self?.view.layoutIfNeeded()
        }
        
        setUpUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        userNameTextField.becomeFirstResponder()
    }
    
    func setUpUI() {
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
    }
    
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func websocketDidConnect(socket: WebSocket) {
        
        print("Socket connected")
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        print("websocket is disconnected: \(error?.localizedDescription)")
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {

        print("got a string: \(text)")
        
        if text != "{\"handle\":\"iPhone\",\"text\":\"Hello from iOS! I just got a message, so here's one back :)\"}" {
           
            let dict = "{\"handle\":\"iPhone\",\"text\":\"Hello from iOS! I just got a message, so here's one back :)\"}"
            let data = dict.dataUsingEncoding(NSUTF8StringEncoding)!
            print(data)
            outbox.writeData(data)
        }
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: NSData) {
        print("got some data: \(data.length)")
        
        if let jsonStuff = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as? [NSDictionary] {
            for json in jsonStuff {
                let card = Card.from(json)!
                print("\(card.id): \(card.text)")
            }
        }
    }
}
