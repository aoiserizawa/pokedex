//
//  APIManager.swift
//  Pokedex
//
//  Created by Alvin Joseph Valdez on 13/09/2017.
//  Copyright © 2017 Alvin Joseph Valdez. All rights reserved.
//

import UIKit
import BrightFutures

enum NetworkError: Error {
    case RequestFailed
    case TimeServiceError
    case SerializationError
}

class APIManager {
    
    func fetchPokemon(pageNumber: Int) -> Future<[Pokemon], NetworkError> {
        return Future { completion in
            guard let url = URL(string: "http://pokeapi.co/api/v2/pokemon/?offset=\(pageNumber)") else { return }
            
            let session = URLSession.shared
            ActivityManager.addActivity()
            session.dataTask(with: url) { (data, response, error) in
                var pokemonArray = [Pokemon]()
                if response != nil{
                    DispatchQueue.main.async {
                        ActivityManager.removeActivity()
                        
                        if let data = data {
                            do{
                                let json = try JSONSerialization.jsonObject(with: data, options: [])
                                if let dictionary = json as? [String:AnyObject] {
                                    if let results = dictionary["results"] as? [[String:AnyObject]]{
                                        for result in results{
                                            if let url = result["url"]?.components(separatedBy: "/"), let name = result["name"] {
                                                pokemonArray.append(Pokemon(name: name as! String, pokedexId: Int(url[6])!) )
                                            }
                                        }
                                        completion(.success(pokemonArray))
                                    }
                                }
                            }catch {
                                completion(.failure(NetworkError.SerializationError))
                            }
                        }
                    }
                }else{
                    completion(.failure(NetworkError.RequestFailed))
                }
                }.resume()
            }
        }
}
