//
//  MenuItem+Convenience.swift
//  FoodTruck Trackr
//
//  Created by Jessie Ann Griffin on 12/19/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation
import CoreData

extension MenuItem {
    convenience init(
        itemName: String,
        itemPrice: Double,
        itemPhoto: String?,
        itemDescription: String,
        customerRating: Int32?,
        customerRatingAvg: Double?,
        context: NSManagedObjectContext = CoreDataStack.shared.mainContext)
    {
        self.init(context: context)
        self.itemName = itemName
        self.itemPrice = itemPrice
        self.itemPhoto = itemPhoto
        self.itemDescription = itemDescription
        if let customerRating = customerRating, let customerRatingAvg = customerRatingAvg
        {
            self.customerRating = customerRating
            self.customerRatingAvg = customerRatingAvg
        }
    }
    
    convenience init?(menuItemRepresentation: MenuItemRepresentation,
                      context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(itemName: menuItemRepresentation.itemName,
                  itemPrice: menuItemRepresentation.itemPrice,
                  itemPhoto: menuItemRepresentation.itemPhoto,
                  itemDescription: menuItemRepresentation.itemDescription,
                  customerRating: menuItemRepresentation.customerRating,
                  customerRatingAvg: menuItemRepresentation.customerRatingAvg,
                  context: context)
    }
    
    var menuItemRepresentation: MenuItemRepresentation? {
        guard let itemName = itemName,
            let itemDescription = itemDescription else { return nil }
        
        return MenuItemRepresentation(itemName: itemName,
                                       itemPrice: itemPrice,
                                       itemPhoto: itemPhoto,
                                       itemDescription: itemDescription,
                                       customerRating: customerRating,
                                       customerRatingAvg: customerRatingAvg)
    }
}
