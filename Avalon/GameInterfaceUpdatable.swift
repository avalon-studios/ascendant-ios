//
//  GameInterfaceUpdatable.swift
//  Avalon
//
//  Created by Kyle Bashour on 1/24/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation

protocol GameInterfaceUpdatable: class {
    func updateQuestions(gameManager: GameManager)
    func updateCurrentPlayersTurn(gameManager: GameManager)
}
