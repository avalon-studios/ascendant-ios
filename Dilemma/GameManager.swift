//
//  GameManager.swift
//  Dilemma
//
//  Created by Kyle Bashour on 1/24/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation

class GameManager: GameDelegate {
    
    weak var gameInterface: GameInterfaceUpdatable?
    
    var socketManager = SocketManager()
    
    var players = [Player]()
    var myQuestions = [Question]()
    var currentPlayer: Player?
    var me: Player

    init(player: Player) {
        me = player
    }
    
    func askQuestion(question: Question, againstPlayer player: Player) {
        // Send the card played so other players know which card is being played
    }
    
    // Should the server automatically know who owns the card? how much is managed server-side vs client side...
    func answerCard(card: Question, answer: Answer) {
        // Answer the card
    }
    
    func updateQuestions(questions: [Question]) {
        myQuestions = questions
        gameInterface?.updateQuestions(self)
    }
    
    func setPlayersTurn(player: Player) {
        currentPlayer = player
        gameInterface?.updateCurrentPlayersTurn(self)
    }
}
