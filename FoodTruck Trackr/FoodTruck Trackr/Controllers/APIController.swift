//
//  APIController.swift
//  FoodTruck Trackr
//
//  Created by Joe Thunder on 12/19/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation
import CoreData


enum NetworkError: Error {
    case noAuth
    case badData
    case badAuth
    case otherError
    case noDecode
}

struct SearchResult: Codable {
    let truckName: String
    let locaiton: String
}

struct Bearer: Codable {
    var token: String
}


class APIController {
    
    typealias CompletionHandler = (Error?) -> Void
    
    init() {
     fetchTrucksFromServer()
    }
    
    var user: User?
    var bearer: Bearer?
    var foodTruck: [FoodTruckRepresentation] = []
    var truck: FoodTruck?
    
    
    let baseURL = URL(string: "https://build-foodtruck-trackr1.herokuapp.com/")!
    
    func fetchTrucksFromServer(completion: @escaping CompletionHandler = { _ in }) {
        
        let reqeustURL = baseURL.appendingPathComponent("trucks")
        URLSession.shared.dataTask(with: reqeustURL) { data, _, error in
            guard error == nil else {
                print("error fetching tasks: \(error!)")
                completion(error)
                return
            }
            guard let data = data else {
                print("no data returned by data task")
                completion(NSError())
                return
            }
            
            do {
                let foodTruckRepresentations = try JSONDecoder().decode([FoodTruckRepresentation].self, from: data)
                // TODO: Update all of our tasks
                try self.updateFoodTrucks(with: foodTruckRepresentations)
                self.foodTruck = foodTruckRepresentations
                completion(nil)
            } catch {
                print("Error decoding task representations: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    private func saveToPersistence() throws {
    let moc = CoreDataStack.shared.mainContext
    try moc.save()
    }


    private func updateFoodTrucks(with representations: [FoodTruckRepresentation]) throws {
        let foodTrucksWithID = representations.filter { $0.id > 0 }
        let identifiersToFetch = foodTrucksWithID.compactMap { $0.id }
        let representationsByID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, foodTrucksWithID))
        var foodTrucksToCreate = representationsByID
        let fetchRequest: NSFetchRequest<FoodTruck> = FoodTruck.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id IN %@", identifiersToFetch)
        let context = CoreDataStack.shared.container.newBackgroundContext()
        
        context.perform {
            do {
                let existingTasks = try context.fetch(fetchRequest)
                for foodTruck in existingTasks {
                    guard foodTruck.id > 0,
                        let representation = representationsByID[foodTruck.id] else {
                            context.delete(foodTruck)
                            continue
                    }
                    guard let truck = self.truck else { return }
                    self.updateTruck(truck, with: representation)
                    foodTrucksToCreate.removeValue(forKey: foodTruck.id)
                }
                for representation in foodTrucksToCreate.values {
                    _ = FoodTruck(truckRepresentation: representation, context: context)
                }
            } catch {
                print("Error Fetching tasks for UUIDs: \(error)")
            }
        }
        try CoreDataStack.shared.save(context: context)
    }
    
    private func updateTruck(_ truck: FoodTruck, with representation: FoodTruckRepresentation) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy hh:mm"
    
        
        truck.name = representation.name
        truck.cuisineType = representation.cuisineType
        truck.imgUrl = representation.imgUrl
        truck.id = representation.id
        truck.customerRating = representation.customerRating ?? 0
        truck.customerRatingAvg = representation.customerRatingAvg ?? 0
        truck.currentLocation = representation.currentLocation
        truck.location = representation.location
        
        if let cdt = formatter.date(from: representation.currentDepartureTime ?? "") {
            truck.currentDepartureTime = cdt
        }
        if let arrivalTime = formatter.date(from: representation.arrivalTime ?? "") {
            truck.arrivalTime = arrivalTime
        }
        if let departureTime = formatter.date(from: representation.departureTime ?? "") {
            truck.departureTime = departureTime
        }
        let moc = CoreDataStack.shared.mainContext
        try? moc.save()
    }
    
    
    func fetchFoodTrucksFromServer(completion: @escaping (Result<[FoodTruckRepresentation], NetworkError>) -> Void) {
        guard let bearer = self.bearer else {
            completion(.failure(.noAuth))
            return
        }
        let baseURL = self.baseURL.appendingPathComponent("trucks")
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode == 401 {
                completion(.failure(.badAuth))
                return
            }
            if let error = error {
                print("There was a fetch Error: \(error)")
                completion(.failure(.otherError))
            }
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            do {
                let foodTrucks = try JSONDecoder().decode([FoodTruckRepresentation].self, from: data)
                try self.updateFoodTrucks(with: foodTrucks)
                completion(.success(foodTrucks))
                return
            } catch {
                print("Error decoding data. \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
//           func addFoodTruckToServer(_ foodTruck: FoodTruck, completion: @escaping CompletionHandler = { _ in }) {
//
//            guard let bearer = bearer else {
//                    return
//                }
//            let baseURL = self.baseURL.appendingPathComponent("trucks")
//                var request = URLRequest(url: baseURL)
//                request.httpMethod = "POST"
//                request.setValue("Bearer \(user?.token)", forHTTPHeaderField: "Authorization")
//
//                URLSession.shared.dataTask(with: request) { (data, response, error) in
//                    if let response = response as? HTTPURLResponse, response.statusCode == 401 {
//                        completion(error)
//                        return
//                    }
//                    if let error = error {
//                        print("There was a fetch Error: \(error)")
//                        completion(error)
//                    }
//                    guard let data = data else {
//                        completion(error)
//                        return
//                    }
//
//                    do {
//                        let newFoodTruck = try JSONDecoder().decode(FoodTruck.self, from: data)
//
//                    } catch {
//                        print("Error decoding data. \(error)")
//                        completion(error)
//                        return
//                    }
//                    completion(nil)
//                }.resume()
//            }
//
//
       func deleteFoodTruckFromServer(_ foodTruck: FoodTruck, completion: @escaping CompletionHandler = { _ in }) {

        guard let bearer = bearer else {
                return
            }
            let baseURL = self.baseURL.appendingPathComponent("trucks")
            var request = URLRequest(url: baseURL)
            request.httpMethod = "DELETE"
            request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")

            URLSession.shared.dataTask(with: request) { (_, response, error) in
                if let response = response as? HTTPURLResponse, response.statusCode == 401 {
                    completion(error)
                    return
                }
                if let error = error {
                    print("There was a fetch Error: \(error)")
                    completion(error)
                }
                completion(nil)
            }.resume()
        }

    
      // MARK: - Sign up / Log In Methods
     
     //create fucntion for sign up
    func signUp(with user: User, completion: @escaping (Error?) -> Void) {
            let signUpUrl = baseURL.appendingPathComponent("api/register")
            var request = URLRequest(url: signUpUrl)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(user)
                request.httpBody = jsonData
               
                let jsonString = String(data: jsonData, encoding: .utf8)!
                print(jsonString)
                
            } catch {
                print("Error encoding user object: \(error)")
                completion(NSError())
                return
            }
            URLSession.shared.dataTask(with: request) { _, response, error in
                if let response = response as? HTTPURLResponse, response.statusCode != 201 {
                    completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                    return
                    
                }
                if let error = error {
                    completion(error)
                    return
                }
                completion(nil)
            }.resume()
        }
        // MARK: - Sign IN
        // create function for sign in
    func LogIn(with user: User, completion: @escaping (Error?) -> Void = { _ in }) {
            let signInURL = baseURL.appendingPathComponent("api/login")
            var request = URLRequest(url: signInURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(user)
                request.httpBody = jsonData
                let jsonString = String(data: jsonData, encoding: .utf8)!
                print(jsonString)
               
            } catch {
                print("Error encoding user object: \(error)")
                completion(error)
                return
            }
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let response = response as? HTTPURLResponse,
                    response.statusCode != 200 {
                    completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                
                    return
                }
                if let error = error {
                    completion(error)
                    return
                }
                
                guard let data = data else {
                    completion(NSError())
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(User.self, from: data)
                    self.user = user
                    self.bearer?.token = user.token!
                } catch {
                    print("Error encoding user object: \(error)")
                    completion(error)
                    return
                }
                
                completion(nil)
                }.resume()
        }
}
