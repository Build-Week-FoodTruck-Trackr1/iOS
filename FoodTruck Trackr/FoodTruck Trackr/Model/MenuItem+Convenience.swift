//
//  MenuItem+Convenience.swift
//  FoodTruck Trackr
//
//  Created by Jessie Ann Griffin on 12/19/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation
import CoreData

enum Category: Int16, CaseIterable, Codable {
    case appetizer = 0
    case entree = 1
    case side = 2
    case drink = 3
    case dessert = 4
    
    var type: String {
        switch self {
        case .appetizer:
            return "Appetizer"
        case .entree:
            return "Entree"
        case .side:
            return "Side"
        case .drink:
            return "Drink"
        case .dessert:
            return "Dessert"
        }
    }
    
    init?(typeName: String) {
        switch typeName {
        case "appetizer":
            self = .appetizer
        case "entree":
            self = .entree
        case "side":
            self = .side
        case "drink":
            self = .drink
        case "dessert":
            self = .dessert
        default:
            return nil
        }
    }
}

extension MenuItem {
    convenience init(
        itemName: String,
        itemPrice: String,
        itemPhoto: Data?,
        itemDescription: String?,
        category: Category = .appetizer,
        customerRating: Int32? = 0,
        customerRatingAvg: Double? = 0.0,
        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.itemName = itemName
        self.itemPrice = itemPrice
        self.itemPhoto = itemPhoto
        self.itemDescription = itemDescription
        self.category = category.type
        if let customerRating = customerRating, let customerRatingAvg = customerRatingAvg {
            self.customerRating = customerRating
            self.customerRatingAvg = customerRatingAvg
        }
    }
    
    convenience init?(menuItemRepresentation: MenuItemRepresentation,
                      context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        //guard let category = menuItemRepresentation.category else { return nil }
        
        self.init(itemName: menuItemRepresentation.itemName,
                  itemPrice: menuItemRepresentation.itemPrice,
                  itemPhoto: menuItemRepresentation.itemPhoto,
                  itemDescription: menuItemRepresentation.itemDescription,
                  category: menuItemRepresentation.category,
                  customerRating: menuItemRepresentation.customerRating,
                  customerRatingAvg: menuItemRepresentation.customerRatingAvg,
                  context: context)
    }
    
    var menuItemRepresentation: MenuItemRepresentation? {
        guard let itemName = itemName,
            let itemDescription = itemDescription,
            let category = Category(typeName: category!),
            let itemPrice = itemPrice else { return nil }
        
        return MenuItemRepresentation(itemName: itemName,
                                      itemPrice: itemPrice,
                                      itemPhoto: itemPhoto,
                                      itemDescription: itemDescription,
                                      category: category,
                                      customerRating: customerRating,
                                      customerRatingAvg: customerRatingAvg)
    }
}
