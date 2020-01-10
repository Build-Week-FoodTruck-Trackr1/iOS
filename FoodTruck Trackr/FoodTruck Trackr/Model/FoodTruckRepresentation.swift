//
//  FoodTruckRepresentation.swift
//  FoodTruck Trackr
//
//  Created by Jessie Ann Griffin on 12/22/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

struct FoodTruckRepresentation: Codable {
    
    var truckTitle: String
    var imageOfTruck: String?
    var cuisineType: String
    var identifier: Int32
    var customerRating: Int32?
    var customerRatingAvg: Double?
    
}
