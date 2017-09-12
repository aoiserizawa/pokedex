//
//  APIManager.swift
//  Pokedex
//
//  Created by Alvin Joseph Valdez on 13/09/2017.
//  Copyright © 2017 Alvin Joseph Valdez. All rights reserved.
//

import UIKit

class APIManager {
    
    
    var pokemonArray = [Pokemon]()
    
    
    func fetchPokemon(pageNumber: Int, completion: @escaping (Bool, Any?, Error?)->()){            
        guard let url = URL(string: "http://pokeapi.co/api/v2/pokemon/?offset=\(pageNumber)") else { return }
        
        let session = URLSession.shared
        ActivityManager.addActivity()
        session.dataTask(with: url) { (data, response, error) in
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
                                    self.pokemonArray.append(Pokemon(name: name as! String, pokedexId: Int(url[6])!) )
                                    completion(true, self.pokemonArray, nil)
                                    self.pokemonArray.removeAll()
                                }
                            }
                        }
                    }
                }catch{
                    completion(false, nil, error)
                    self.pokemonArray.removeAll()
                }
            }
            }.resume()
    }
}
