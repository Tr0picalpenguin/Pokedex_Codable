//
//  Pokemon.swift
//  Pokedex_Codable
//
//  Created by Karl Pfister on 2/7/22.
//

import Foundation

// Top Level Dictionary
struct Pokedex: Decodable {
    private enum CodingKeys: String, CodingKey {
        case results
        case nextURL = "next"
    }
    let results: [ResultsDictionary]
    let nextURL: String
}

struct ResultsDictionary: Decodable {
    let name: String
    let url: String
}

struct Pokemon: Decodable {
    private enum Keys: String {
        case name = "name"
        case id = "id"
        case sprites = "sprites"
    }
    
    let name: String
    let id: Int
    let sprites: Sprites
    let moves: [Moves]
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

struct Moves: Decodable {
    private enum CodingKeys: String, CodingKey {
        case move = "move"
    }
    let move: Move
}

struct Move: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name = "name"
    }
    let name: String
    
}
