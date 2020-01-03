//
//  APIController.swift
//  FoodTruck Trackr
//
//  Created by Joe Thunder on 12/19/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

let truck: foodTruck = FoodTruck()

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

struct FoodTruck {
    var name: String
    var location: String
    var foodType: FoodType
}

struct FoodTruckRepresentation: Codable {
    var name: String
    var location: String
    var foodType: FoodType
}

struct SearchResult: Codable {
    let truckName: String
    let locaiton: String
}


class APIController {
    
    var user: User?
    var loginUser: Login?
    var registerUser: Login?
    
    let baseURL = URL(string: "https://build-foodtruck-trackr1.herokuapp.com/")!
    
    func put(truck: FoodTruck, completion: @escaping () -> Void = { }) {
        let name = truck.name
        let requestURL = baseURL.appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do {
            guard var representation = foodTruck.FoodTruckRepresentation else {
                completion()
                return
            }
            representation.id
        } catch {
            print("Error encoding task \(error)")
            return
        }
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                print("Error putting task to server: \(error)")
                completion()
                return
            }
            completion()
        }.resume()
    }
    
    private func saveToPersistence() throws {
    let moc = CoreDataStack.shared.mainContext
    try moc.save()
    }
    
    func performFetch(truck: [FoodTruckRepresentation] completion: @escaping (Error?) -> Void) {
        guard let baseURL = baseURL else { return }
        let searchURL = baseURL.appendingPathComponent("\(blah)")
        
        var request = URLRequest(url:searchURL)
        
        URLSession.shared.dataTask(with: request) {data, _, error in
            if let error = error {
                print("Error Parsing Data: \(error)")
                
                return
            }
            
            guard let data = data else {
                print("No Data returned")
                return
            }
            let jsonDecoder = jsonDecoder()
            do {
                let searchResults = try jsonDecoder.decode([FoodTruckRepresentation].self, from: data)
                print(searchResults)
            } catch {
                print("Unable to decode data: \(error)")
            }
            completion(error)
        }.resume()
    }
    
    func performSearch(searchTerm: FoodType, resultType: FoodTruckRepresentation, completion: @escaping (Error?) -> Void) {
        var urlComponents = urlComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultsTermQueryItem = URLQueryItem(name: "entity", value: resultType:rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultsTermQueryItem]
        
        guard let requestURL = urlComponents.url else {
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
            let jsonDecoder = jsonDecoder()
            do {
                let searchResults = try jsonDecoder.decode(FoodTruckRepresentation.self, from: data)
                self.search
            } catch {
                
            }
        }.resume()
    }
    
    
    func addTruck() {
           
       }
    
      // MARK: - Sign up / Log In Methods
     
     //create fucntion for sign up
        func signUp(with username: String, password: String, completion: @escaping (Error?) -> ()) {
            let signUpUrl = baseURL.appendingPathComponent("auth/register")
            var request = URLRequest(url: signUpUrl)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            registerUser = Login(username: username, password: password)
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(registerUser)
                request.httpBody = jsonData
                print(jsonData.prettyPrintedJSONString!)
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
        func LogIn(with username: String, password: String, completion: @escaping (Error?) -> ()) {
            let loginUser = Login(username: username, password: password)
            let signInURL = baseURL.appendingPathComponent("auth/login")
            var request = URLRequest(url: signInURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(loginUser)
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
                } catch {
                    print("Error encoding user object: \(error)")
                    completion(error)
                    return
                }
                
                completion(nil)
                }.resume()
        }
        
    

}
