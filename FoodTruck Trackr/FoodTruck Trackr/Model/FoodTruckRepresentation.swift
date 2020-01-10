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
    var truckID: Int32
    var customerRating: Int32?
    var customerRatingAvg: Double?
    var currentLocation: String?
    var currentDepartureTime: String?
    var arrivalTime: String?
    var location: String?
    var departureTime: String?
    
    init(from foodTruck: FoodTruck) {
        self.truckTitle = foodTruck.truckTitle ?? ""
        self.imageOfTruck = foodTruck.imageOfTruck
        self.cuisineType = foodTruck.cuisineType ?? ""
        self.truckID = foodTruck.truckID
        self.customerRating = foodTruck.customerRating
        self.customerRatingAvg = foodTruck.customerRatingAvg
        self.currentLocation = foodTruck.currentLocation
        self.location = foodTruck.location                      // NEXT location the truck will be at
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm"
        
        if let cdt = foodTruck.currentDepartureTime {
            self.currentDepartureTime = dateFormatter.string(from: cdt)
        }
        if let arrivalTime = foodTruck.arrivalTime {
            self.arrivalTime = dateFormatter.string(from: arrivalTime)
        }
        if let departureTime = foodTruck.departureTime {
            self.departureTime = dateFormatter.string(from: departureTime)
        }
    }
    
}
