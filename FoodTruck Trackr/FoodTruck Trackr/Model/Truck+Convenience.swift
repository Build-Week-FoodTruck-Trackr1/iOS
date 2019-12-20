//
//  Truck+Convenience.swift
//  FoodTruck Trackr
//
//  Created by Joe Thunder on 12/20/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation
import CoreData


extension Truck {
    var truckRepresentation: TruckRepresentation? {
        guard let name = name else { return nil }
    }
    return truckRepresentation(
}
