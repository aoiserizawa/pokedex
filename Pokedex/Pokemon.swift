//
//  Pokemon.swift
//  Pokedex
//
//  Created by Alvin Joseph Valdez on 11/09/2017.
//  Copyright © 2017 Alvin Joseph Valdez. All rights reserved.
//

import UIKit

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
    
}


