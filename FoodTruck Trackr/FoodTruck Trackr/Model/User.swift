//
//  User.swift
//  FoodTruck Trackr
//
//  Created by Joe Thunder on 1/3/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import Foundation

class User: Codable {
    let username: String
    let password: String
    let email: String
    let currentLocation: String
    let type: String
    let isOperator: Bool?
    let trucksOwned: [FoodTruckRepresentation]?
    let favoriteTrucks: [FoodTruckRepresentation]?
    


    
    init(username: String, password: String, currentLocation: String, type: String, email: String, isOperator: Bool?, trucksOwned: [FoodTruckRepresentation], favoriteTrucks: [FoodTruckRepresentation]) {
        self.username = username
        self.password = password
        self.email = email
        self.currentLocation = currentLocation
        self.isOperator = isOperator
        self.type = type
        self.trucksOwned = trucksOwned
        self.favoriteTrucks = favoriteTrucks
    }
    
    convenience init?(userName: String, password: String, currentLocation: String, email: String, isOperator: Bool?) {
        self.init(userName: userName,
            password: password,
            currentLocation: currentLocation,
            email: email,
            isOperator: isOperator)
    }
    

    // password, email, current location, and type(either “diner” or “operator”)
    
    convenience init?(username: String, password: String, currentLocation: String, email: String, favoriteTrucks: [FoodTruckRepresentation], isOperator: Bool) {
        self.init(username: username,
                  password: password,
                  currentLocation: currentLocation,
                  email: email,
                  favoriteTrucks: favoriteTrucks,
                  isOperator: isOperator)
    }
    
   convenience init?(username: String, password: String, currentLocation: String, email: String, trucksOwned: [FoodTruckRepresentation], isOperator: Bool) {
    self.init(username: username,
              password: password,
              currentLocation: currentLocation,
              email: email,
              trucksOwned: trucksOwned,
              isOperator: isOperator)
    }
    
}

