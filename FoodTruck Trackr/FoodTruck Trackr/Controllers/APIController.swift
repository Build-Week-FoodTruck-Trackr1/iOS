//
//  APIController.swift
//  FoodTruck Trackr
//
//  Created by Joe Thunder on 12/19/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation



enum ResultType: String {
    case software
    case musicTrack
    case movie
}

enum FoodType: String {
    case italian
    case american
    case soulfood
    case texmex
    case chinese
    case thai
    case caribbean
    case middleeastern
}


//struct FoodTruckRepresentation: Codable {
//    var name: String
//    var location: String
////    var foodType: FoodType
//}

struct SearchResult: Codable {
    let truckName: String
    let locaiton: String
}


class APIController {
    
    var user: User?
    
    let baseURL = URL(string: "https://build-foodtruck-trackr1.herokuapp.com/")!
    
//    func put(foodTruck: FoodTruck, completion: @escaping () -> Void = { }) {
//        let name = foodTruck.truckTitle
//        let requestURL = baseURL.appendingPathExtension("json")
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = "PUT"
//
//        do {
//            //Put FoodTruckRepresentation Here
//            guard let representation = foodTruck.truckRepresentation else {
//              completion()
//                        return
//                    }
//                    representation.identifier = UUID().uuidString
//                    task.identifier = uuid
//                    try saveToPersistence()
//                    request.httpBody = try JSONEncoder().encode(representation)
//        } catch {
//            print("Error encoding task \(error)")
//            completion()
//            return
//        }
//        URLSession.shared.dataTask(with: request) { (data, _, error) in
//            guard error == nil else {
//                print(NSError())
//                completion()
//                return
//            }
//            completion()
//        }.resume()
//    }
    
    private func saveToPersistence() throws {
    let moc = CoreDataStack.shared.mainContext
    try moc.save()
    }
    
    func performFetch(truck: [FoodTruckRepresentation], completion: @escaping (Error?) -> Void) {
        // guard let baseURL = baseURL else { return }
        let searchURL = baseURL.appendingPathComponent("json")
        
        let request = URLRequest(url:searchURL)
        
        URLSession.shared.dataTask(with: request) {data, _, error in
            if let error = error {
                print("Error Parsing Data: \(error)")
                
                return
            }
            
            guard let data = data else {
                print("No Data returned")
                return
            }
            let decoder = JSONDecoder()
            do {
                let searchResults = try decoder.decode([FoodTruckRepresentation].self, from: data)
                print(searchResults)
            } catch {
                print("Unable to decode data: \(error)")
            }
            completion(error)
        }.resume()
    }
    
    func performSearch(searchTerm: FoodType, resultType: FoodTruckRepresentation, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm.rawValue)
        let resultsTermQueryItem = URLQueryItem(name: "entity", value: resultType.truckTitle)
        urlComponents?.queryItems = [searchTermQueryItem, resultsTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is invalid")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error parsing Data: \(error)")
                return
            }
            guard let data = data else {
                print("No data returned from data task.")
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let searchResults = try jsonDecoder.decode(FoodTruckRepresentation.self, from: data)
            
            } catch {
                
            }
        }.resume()
    }
    
    
    func addTruck() {
           
       }
    
      // MARK: - Sign up / Log In Methods
     
     //create fucntion for sign up
    func signUp(with user: User, completion: @escaping (Error?) -> Void = { _ in }) {
            let signUpUrl = baseURL.appendingPathComponent("api/register")
            var request = URLRequest(url: signUpUrl)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(user)
                request.httpBody = jsonData
//                print(jsonData.prettyPrintedJSONString!)
            } catch {
                print("Error encoding user object: \(error)")
                completion(error)
                return
            }
            URLSession.shared.dataTask(with: request) { _, response, error in
                if let response = response as? HTTPURLResponse,
                    response.statusCode != 201 {
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
            let signInURL = baseURL.appendingPathComponent("auth/login")
            var request = URLRequest(url: signInURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(user)
                request.httpBody = jsonData
               
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
                } catch {
                    print("Error encoding user object: \(error)")
                    completion(error)
                    return
                }
                
                completion(nil)
                }.resume()
        }
        
    

}
