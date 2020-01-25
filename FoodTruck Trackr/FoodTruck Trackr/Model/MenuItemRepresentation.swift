//
//  MenuItemRepresentation.swift
//  FoodTruck Trackr
//
//  Created by Jessie Ann Griffin on 12/22/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

struct MenuItemRepresentation: Codable {
    
    var itemName: String
    var itemPrice: String
    var itemPhoto: Data?
    var itemDescription: String?
    var category: Category
    var customerRating: Int32?
    var customerRatingAvg: Double?

}
