//
//  Pokemon.swift
//  Pokedex_Codable
//
//  Created by Karl Pfister on 2/7/22.
//

import Foundation

// Top Level Dictionary
struct Pokedex: Decodable {
    let results: [ResultsDictionary]
}

struct ResultsDictionary: Decodable {
    let name: String
    let url: String
}

struct Pokemon: Decodable {
    enum Keys: String {
        case name = "name"
        case id = "id"
        case moves = "moves"
        case sprites = "sprites"
        case frontShiny = "front_shiny"
        case move = "move"
    }
    
    let name: String
    let id: Int
    let sprites: Sprites
}

struct Sprites: Decodable {
    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontFemale = "front_female"
        case frontShinyFemale = "front_shiny_female"
        
    }
    
    let frontDefault: String
    let frontShiny: String
    let frontFemale: String?
    let frontShinyFemale: String?
}
