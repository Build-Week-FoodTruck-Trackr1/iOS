//
//  Menu.swift
//  FoodTruck Trackr
//
//  Created by Jessie Ann Griffin on 12/19/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation
import CoreData



class MenuController {
    
    typealias CompletionHandler = (Error?) -> Void
    
    let baseURL = URL(string: "https://build-foodtruck-trackr1.herokuapp.com/api")!
    var menuItems: [MenuItem]?
    var categories: [Category]?
    
    func put(item: MenuItem) {
        
    }
    
    func fetchItemsFromServer(completion: @escaping CompletionHandler = { _ in }) { // replaced with typealias CompletionHandler
        
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                print("Error fetching tasks: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("No data returned by data task")
                completion(nil)
                return
            }
            
            do {
                // Create an instance of a json decoder
                let decoder = JSONDecoder()
                // Attempting to decode our data (from our HTTP response) into a dictionary of TaskRepresentation objects keyed by String values (UUIDS)
                let dictionaryOfMenuItems = try decoder.decode([String: MenuItemRepresentation].self, from: data)
                // Creating an array of just the values (TaskRepresentation objects), discarding the keys ([TaskRepresentation])
                let menuItemRepresentations = Array(dictionaryOfMenuItems.values)
                
                //TODO: Implement a way to update all the tasks using the data we recieved
                try self.updateMenu(with: menuItemRepresentations)
                
                completion(nil)
            } catch {
                print("Error decoding item representations: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
     private func updateMenu(with representations: [MenuItemRepresentation]) throws { // this will require a try when it's called
            
//            let itemsWithID = representations.filter({ $0.identifier != nil })
//            
//            let identifiersToFetch = itemsWithID.compactMap({ UUID(uuidString: $0.identifier!)})
//            // Creating a dictionary of TaskRepresentation objects keyed by UUID
//            let representationsByID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, itemsWithID)) // array of uuids and second is tasks with ids
//            
//            // Running log of all the tasks we need to
//            var itemsToCreate = representationsByID
//            
//            let fetchRequest: NSFetchRequest<MenuItem> = MenuItem.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "uuid IN %@", identifiersToFetch)
//            
//    //        let context = CoreDataStack.shared.mainContext
//            let context = CoreDataStack.shared.container.newBackgroundContext()
//            context.perform {
//                do {
//                    let existingItems = try context.fetch(fetchRequest)
//                    
//                    for item in existingItems {
//                        guard let id = item.uuid,
//                            let representation = representationsByID[id] else { continue } // continue will break out of the iteration of the loop instead of ending it
//                        
//                        self.update(menuItem: item, with: representation)
//                        
//                        itemsToCreate.removeValue(forKey: id)
//                    }
//                    
//                    for representation in itemsToCreate.values {
//                        let _ = Task(taskRepresentation: representation, context: context)
//                    }
//                } catch {
//                    print("Error fetching tasks for UUIDS: \(error)")
//                }
//            }
//            try CoreDataStack.shared.save(context: context)
    //        try saveToPersistentStore()
        }
}
