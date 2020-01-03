//
//  User.swift
//  FoodTruck Trackr
//
//  Created by Joe Thunder on 1/3/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import Foundation

struct User: Codable {
    let user: String
    let firstName: String
    let lastName: String
}

struct Login: Codable {
    let username: String
    let password: String
}
