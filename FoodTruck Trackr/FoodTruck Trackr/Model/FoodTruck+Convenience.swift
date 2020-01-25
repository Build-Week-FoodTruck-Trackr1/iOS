//
//  FoodTruck+Convenience.swift
//  FoodTruck Trackr
//
//  Created by Jessie Ann Griffin on 12/19/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation
import CoreData

extension FoodTruck {
    convenience init(name: String,
                     cuisineType: String,
                     imgUrl: String? = nil,
                     id: Int32 = -1,
                     customerRating: Int32? = 0,
                     customerRatingAvg: Double? = 0.0,
                     currentLocation: String? = nil,
                     currentDepartureTime: Date? = nil,
                     arrivalTime: Date? = nil,
                     location: String? = nil,
                     departureTime: Date? = nil,
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext
    ) {
        self.init(context: context)
        self.name = name
        self.imgUrl = imgUrl
        self.cuisineType = cuisineType
        self.id = id
        if let customerRating = customerRating, let customerRatingAvg = customerRatingAvg {
            self.customerRating = customerRating
            self.customerRatingAvg = customerRatingAvg
        }
    }
    
    convenience init?(truckRepresentation: FoodTruckRepresentation,
                      context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(name: truckRepresentation.name,
                  cuisineType: truckRepresentation.cuisineType,
                  imgUrl: truckRepresentation.imgUrl,
                  id: truckRepresentation.id,
                  customerRating: truckRepresentation.customerRating,
                  customerRatingAvg: truckRepresentation.customerRatingAvg,
                  context: context)
    }
    
    var truckRepresentation: FoodTruckRepresentation? {
        guard name == name,
            cuisineType == cuisineType,
            id > 0 else { return nil }
        
        return FoodTruckRepresentation(from: self)
    }
}
