//
//  TruckController.swift
//  FoodTruck Trackr
//
//  Created by Joe on 1/13/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import Foundation
import CoreData

class TruckController {
    
    let apiController = APIController()
    
    //CRUD
    
    func create(truck: FoodTruck) {
        let moc = CoreDataStack.shared.mainContext
        try? moc.save()
        apiController.addFoodTruckToServer(truck)
    }
    
    func save() {
        let moc = CoreDataStack.shared.mainContext
        moc.save()
    }
    
    func update(truck: FoodTruck) {
        let moc = CoreDataStack.shared.mainContext
        try? moc.save()
        apiController.updateFoodTrucks(with: )
    }
    
    func delete(truck: FoodTruck) {
        let moc = CoreDataStack.shared.mainContext
        try? moc.save()
    }
    
    
}
