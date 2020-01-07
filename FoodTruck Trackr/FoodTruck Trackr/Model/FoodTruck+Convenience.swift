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
    convenience init(
        truckTitle: String,
        imageOfTruck: String? = nil,
        cuisineType: String,
        identifier: UUID = UUID(),
        customerRating: Int32? = 0,
        customerRatingAvg: Double? = 0.0,
        context: NSManagedObjectContext = CoreDataStack.shared.mainContext)
    {
        self.init(context: context)
        self.truckTitle = truckTitle
        self.imageOfTruck = imageOfTruck
        self.cuisineType = cuisineType
        self.identifier = identifier
        if let customerRating = customerRating, let customerRatingAvg = customerRatingAvg
        {
            self.customerRating = customerRating
            self.customerRatingAvg = customerRatingAvg
        }
    }
    
    convenience init?(truckRepresentation: FoodTruckRepresentation,
                      context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(truckTitle: truckRepresentation.truckTitle,
                  imageOfTruck: truckRepresentation.imageOfTruck,
                  cuisineType: truckRepresentation.cuisineType,
                  identifier: truckRepresentation.identifier,
                  customerRating: truckRepresentation.customerRating,
                  customerRatingAvg: truckRepresentation.customerRatingAvg,
                  context: context)
    }
    
    var truckRepresentation: FoodTruckRepresentation? {
        guard let truckTitle = truckTitle,
            let cuisineType = cuisineType,
            let identifier = identifier else { return nil }
        
        return FoodTruckRepresentation(truckTitle: truckTitle,
                                       imageOfTruck: imageOfTruck,
                                       cuisineType: cuisineType,
                                       identifier: identifier,
                                       customerRating: customerRating,
                                       customerRatingAvg: customerRatingAvg)
    }
}
