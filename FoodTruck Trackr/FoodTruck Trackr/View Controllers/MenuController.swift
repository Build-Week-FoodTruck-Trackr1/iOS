//
//  Menu.swift
//  FoodTruck Trackr
//
//  Created by Jessie Ann Griffin on 12/19/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation
import CoreData

enum Category: CaseIterable {
    case appetizer
    case entree
    case side
    case drink
}

class MenuController {
    
    var menuItems: [MenuItem]?
    var categories: [Category]?
    
    
}
