//
//  User.swift
//  FoodTruck Trackr
//
//  Created by Joe Thunder on 1/3/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import Foundation

struct User: Codable {
    let userName: String
    let password: String
    let email: String
    let currentLocation: String
    let isOperator: Bool?
    let trucksOwned: String?
    let favoriteTrucks: [FoodTruck]
    
    convenience init(userName: String, password: String, currentLocation: String, email: String, isOperator: Bool?) {
        self.userName = userName
        self.password = passwordj
        self.email = email
        self.currentLocation = currentLocation
        self.isOperator = isOperator
    }
    

    // password, email, current location, and type(either “diner” or “operator”)
    
    convenience init(username: String, password: String, currentLocation: String, email: String, favoriteTrucks: [FoodTruck], isOperator: Bool) {
        self.userName = userName
        self.password = password
        self.currentLocation = currentLocation
        self.email = email
        self.isOperator = isOperator
        self.favoriteTrucks = favoriteTrucks
    }
    
    convenience init(username: String, password: String, currentLocation: String, email: String trucksOwned: [FoodTruck], isOperator: Bool) {
            self.userName = userName
            self.password = password
            self.currentLocation = currentLocation
            self.email = email
            self.isOperator = isOperator
            self.trucksOwned = trucksOwned
    }
    
}

