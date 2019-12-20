//
//  APIController.swift
//  FoodTruck Trackr
//
//  Created by Joe Thunder on 12/19/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

let truck: Truck = Truck()

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

struct Truck: Codable {
    name: String
    location: String
    foodType: FoodType
}

struct TruckRepresentation: Codable {
    name: String
    location: String
    foodType: FoodType
}

struct SearchResult: Codable {
    let truckName: String
    let locaiton: String
}


class APIController {
    
    let baseURL = URL(String: "https://build-foodtruck-trackr1.herokuapp.com/")!
    
    func put(truck: Truck, completion: @escaping () -> Void = { }) {
        let name = truck.name
        let requestURL = baseURL.appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do {
            guard var reqpresentation = truck.truc
        } catch {
            
        }
    }
    
    func performFetch(truck: [TruckRepresentation] completion: @escaping (Error?) -> Void) {
        guard let baseURL = baseURL else { return }
        let searchURL = baseURL.appendingPathComponent("\(blah)")
        
        var request = URLRequest(url:searchURL)
        
        URLSession.shared.dataTask(with: reqeust) {data, _, error in
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
                let searchResults = try jsonDecoder.decode([TruckRepresentation].self, from: data)
                print(searchResults)
            } catch {
                print("Unable to decode data: \(error)")
            }
            completion(error)
        }.resume()
    }
    
    func performSearch(searchTerm: FoodType, resultType: TruckRepresentation, completion: @escaping (Error?) -> Void) {
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
                let searchResults = try jsonDecoder.decode(TruckRepresentation.self, from: data)
                self.search
            } catch {
                
            }
        }.resume()
    }
    
    
    func addTruck() {
           
       }
    

}
