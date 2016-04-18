//
//  AscendantTests.swift
//  AscendantTests
//
//  Created by Kyle Bashour on 2/22/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import XCTest
@testable import Ascendant

class AscendantTests: XCTestCase {

    var socketOne: Socket!
    var socketTwo: Socket!

    override func setUp() {
        super.setUp()

        socketOne = Socket()
        socketTwo = Socket()

        socketOne.connect()

        while socketOne.status != .Connected {}

        socketTwo.connect()

        while socketTwo.status != .Connected {}
    }

    override func tearDown() {

        super.tearDown()
    }

    func testGameCreation() {

        let testerName = "Tester 1"

        let createdExpectation = expectationWithDescription("Game created")

        socketOne.createGame(testerName) { game in

            XCTAssert(game != nil, "Game creation failed")
            XCTAssert(game!.creator?.name == testerName, "Creator name does not match")
            XCTAssert(game!.player.name == testerName, "Player name does not match")
            XCTAssert(game!.players.contains(game!.player), "Player was not added to players array")

            createdExpectation.fulfill()
        }
    }

    func testGameJoining() {

        let creatorName = "Tester 1"
        let joiningName = "Tester 2"

        let joinedExpectation = expectationWithDescription("Game was joined")

        socketOne.createGame(creatorName) { game in

            self.socketTwo.joinGame(game!.id, playerName: joiningName) { game in

                XCTAssert(game != nil, "Game joining failed")
                XCTAssert(game!.creator?.name != joiningName, "Joining player should not be the creator")
                XCTAssert(game!.player.name == joiningName, "Player name does not match")
                XCTAssert(game!.players.contains(game!.player), "Player was not added to players array")

                joinedExpectation.fulfill()
            }
        }
    }
}
