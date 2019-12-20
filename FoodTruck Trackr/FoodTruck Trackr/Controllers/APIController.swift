//
//  APIController.swift
//  FoodTruck Trackr
//
//  Created by Joe Thunder on 12/19/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

struct Blah {
    name: String
    location: String
}


class APIController {
    
    let baseURL = URL(String: "")!
    
    func performFetch(blah: [Blah] completion: @escaping (Error?) -> Void) {
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
                let searchResults = try jsonDecoder.decode([Blah].self, from: data)
                print(searchResults)
            } catch {
                print("Unable to decode data: \(error)")
            }
            completion(error)
        }.resume()
    }
}
