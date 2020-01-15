//
//  FoodTruck_TrackrTests.swift
//  FoodTruck TrackrTests
//
//  Created by Joel Groomer on 12/18/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import XCTest
@testable import FoodTruck_Trackr

class FoodTruckTrackrTests: XCTestCase {

    func testApiController() {
        let apiController = APIController()
        let expectation = self.expectation(description: "Download food trucks from API")
        
        apiController.fetchTrucksFromServer { error in
            XCTAssertNil(error)
            XCTAssertFalse(apiController.foodTruckRepresentations.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
    }

    func testLogin() {
        
        /*
         I believe that my test works, but it will fail. The login function never actually worked correctly.
         */
        
        let apiController = APIController()
        let expectation = self.expectation(description: "Logged in")
        
        let user = User(username: "test123", password: "test", email: "test123@test.com", currentLocation: "test", type: "operator")
        apiController.LogIn(with: user) { error in
            XCTAssertNil(error)
            XCTAssertNotNil(apiController.bearer)
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 5)
    }

    func testFailedLogin() {
        let apiController = APIController()
        let expectation = self.expectation(description: "Not logged in")
        
        let user = User(username: "assdzvvdsg", password: "32458", email: "randomasdfasdfag@test.com", currentLocation: "test", type: "operator")
        apiController.LogIn(with: user) { error in
            XCTAssertNotNil(error)
            XCTAssertNil(apiController.bearer)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
}
