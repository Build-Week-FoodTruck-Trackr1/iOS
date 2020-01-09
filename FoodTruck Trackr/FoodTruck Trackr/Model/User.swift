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
    
    let email: String?
    let currentLocation: String?
    let type: String
    let id: Int

    
    init(username: String, password: String, email: String, currentLocation: String, type: String, id: Int) {
        self.username = username
        self.password = password
        self.email = email
        self.currentLocation = currentLocation
        self.type = type
        self.id = id


    }
    
   
    
}

