//
//  APIManager.swift
//  Pokedex
//
//  Created by Alvin Joseph Valdez on 13/09/2017.
//  Copyright © 2017 Alvin Joseph Valdez. All rights reserved.
//

import UIKit

class APIManager {
    
    func fetchPokemon(pageNumber: Int, completion: @escaping (Bool, Any?, Error?)->()){
        print(pageNumber)
        guard let url = URL(string: "http://pokeapi.co/api/v2/pokemon/?offset=\(pageNumber)") else { return }
        
        let session = URLSession.shared
        ActivityManager.addActivity()
        session.dataTask(with: url) { (data, response, error) in
            var pokemonArray = [Pokemon]()
            if response != nil{
                ActivityManager.removeActivity()
            }
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
                            completion(true, pokemonArray, nil)
                        }
                    }
                    
                }catch{
                    completion(false, nil, error)
                    
                }

            }
            }.resume()
    }
}
