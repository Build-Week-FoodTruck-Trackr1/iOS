//
//  FoodTruck+Convenience.swift
//  FoodTruck Trackr
//
//  Created by Jessie Ann Griffin on 12/19/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation
import CoreData

//https://build-foodtruck-trackr1.herokuapp.com/api

extension FoodTruck {
    convenience init(truckTitle: String,
                     cuisineType: String,
                     imageOfTruck: String? = nil,
                     truckID: Int32 = -1,
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
        self.truckTitle = truckTitle
        self.imageOfTruck = imageOfTruck
        self.cuisineType = cuisineType
        self.truckID = truckID
        if let customerRating = customerRating, let customerRatingAvg = customerRatingAvg {
            self.customerRating = customerRating
            self.customerRatingAvg = customerRatingAvg
        }
    }
    
    convenience init?(truckRepresentation: FoodTruckRepresentation,
                      context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(truckTitle: truckRepresentation.truckTitle,
                  cuisineType: truckRepresentation.cuisineType,
                  imageOfTruck: truckRepresentation.imageOfTruck,
                  truckID: truckRepresentation.identifier,
                  customerRating: truckRepresentation.customerRating,
                  customerRatingAvg: truckRepresentation.customerRatingAvg,
                  context: context)
    }
    
    var truckRepresentation: FoodTruckRepresentation? {
        guard let truckTitle = truckTitle,
            let cuisineType = cuisineType,
            truckID > 0 else { return nil }
        
        return FoodTruckRepresentation(truckTitle: truckTitle,
                                       imageOfTruck: imageOfTruck,
                                       cuisineType: cuisineType,
                                       identifier: truckID,
                                       customerRating: customerRating,
                                       customerRatingAvg: customerRatingAvg)
    }
}
