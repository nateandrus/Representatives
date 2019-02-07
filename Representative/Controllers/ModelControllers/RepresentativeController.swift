//
//  RepresentativeController.swift
//  Representative
//
//  Created by Nathan Andrus on 2/7/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import Foundation

class RepresentativeController {
    
    static let baseURL = URL(string: "https://whoismyrepresentative.com")
    
    static func searchRepresentatives(forState state: String, completion: @escaping (([Representative]) -> Void)) {
        guard var url = baseURL else { completion([]); return }
        url.appendPathComponent("getall_reps_bystate.php")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let searchQueryItems = URLQueryItem(name: "state", value: state)
        let jsonQueryItem = URLQueryItem(name: "output", value: "json")
        components?.queryItems = [searchQueryItems, jsonQueryItem]
        
        guard let componentsURL = components?.url else { completion([]); return }
        
        let dataTask = URLSession.shared.dataTask(with: componentsURL) { (data, _, error) in
            if let error = error {
                print("There was an error loading data from url: \(error.localizedDescription)")
                completion([])
                return
            }
            guard let data = data else {
                print("There was an error with the data")
                completion([])
                return
            }
            let dataAsASCII = String(data: data, encoding: .ascii)
            guard let dataAsUTF8 = dataAsASCII?.data(using: .utf8) else { return }
            
            do {
                let decoder = JSONDecoder()
                let topLevelDecoded = try decoder.decode(TopLevelDictionary.self, from: dataAsUTF8)
                let decodedReps = topLevelDecoded.results
                completion(decodedReps)
                return
            } catch {
                print("There was a big time error : \(error) ::::::: \(error.localizedDescription)")
                completion([])
            }
        }
        dataTask.resume()
    }
    
    
    
    
    
    
    
}
