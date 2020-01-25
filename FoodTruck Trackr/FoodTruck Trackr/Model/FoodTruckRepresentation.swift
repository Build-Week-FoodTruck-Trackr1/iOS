//
//  FoodTruckRepresentation.swift
//  FoodTruck Trackr
//
//  Created by Jessie Ann Griffin on 12/22/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

struct FoodTruckRepresentation: Codable {
    
    var name: String
    var imgUrl: String?
    var cuisineType: String
    var id: Int32
    var customerRating: Int32?
    var customerRatingAvg: Double?
    var currentLocation: String?
    var currentDepartureTime: String?
    var arrivalTime: String?
    var location: String?
    var departureTime: String?
    
    init(name: String, imgUrl: String?, cuisineType: String, id: Int32, customerRating: Int32?, customerRatingAvg: Double?, currentLocation: String?, currentDepartureTime: String?, arrivalTime: String?, location: String?, departureTime: String?) {
        self.name = name
        self.imgUrl = imgUrl
        self.cuisineType = cuisineType
        self.id = id
        self.customerRating = customerRating
        self.customerRatingAvg = customerRatingAvg
        self.currentLocation = currentLocation
        self.currentDepartureTime = currentDepartureTime
        self.arrivalTime = arrivalTime
        self.location = location
        self.departureTime = departureTime
        
    }
    
    init(from foodTruck: FoodTruck) {
        self.name = foodTruck.name ?? ""
        self.imgUrl = foodTruck.imgUrl
        self.cuisineType = foodTruck.cuisineType ?? ""
        self.id = foodTruck.id
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

struct TruckLocation: Codable {
    var currentLocation: String
    var currentDepartureTime: String
    var arrivalTime: String
    var location: String
    var departureTime: String
}
