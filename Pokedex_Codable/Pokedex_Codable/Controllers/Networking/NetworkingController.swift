//
//  NetworkingController.swift
//  Pokedex_Codable
//
//  Created by Karl Pfister on 2/7/22.
//

import Foundation
import UIKit.UIImage

class NetworkingController {
    
    private static let baseURLString = "https://pokeapi.co"
    
    // MARK: - Endpoint 1
    
    static func fetchPokedex(with url: URL, completion: @escaping(Result<Pokedex, ResultError>) -> Void ) {
    
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                print("Encountered Error: \(error.localizedDescription)")
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let pokedex = try JSONDecoder().decode(Pokedex.self, from: data)
                completion(.success(pokedex))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    // MARK: - Endpoint 2
    
    static func fetchPokemon(with pokemonUrlString: String, completion: @escaping (Result<Pokemon, ResultError>) -> Void) {

        guard let finalURL = URL(string: pokemonUrlString) else {
            completion(.failure(.invalidURL(URL(string: pokemonUrlString)!)))
                       return
        }
        
        URLSession.shared.dataTask(with: finalURL) { dTaskData, _, error in
            if let error = error {
                print("Encountered error: \(error.localizedDescription)")
                completion(.failure(.noData))
            }
            
            guard let pokemonData = dTaskData else {return}
            
            do {
                // MARK: - need to Decode the object
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: pokemonData)
                completion(.success(pokemon))
            } catch {
                print("Encountered error when decoding the data:", error.localizedDescription)
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    //MARK: - Endpoint 3
    
    static func fetchImage(for pokemon: String, completetion: @escaping (Result<UIImage, ResultError>) -> Void) {
        guard let imageURL = URL(string: pokemon) else {
            completetion(.failure(.invalidURL(URL(string: pokemon)!)))
            return}
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let error = error {
                print("There was an error", error.localizedDescription)
                completetion(.failure(.thrownError(error)))
            }
            guard let data = data else {
                completetion(.failure(.noData))
                return
            }
            let pokemonImage = UIImage(data: data)
                completetion(.success(pokemonImage!))
        }.resume()
    }
}// end
