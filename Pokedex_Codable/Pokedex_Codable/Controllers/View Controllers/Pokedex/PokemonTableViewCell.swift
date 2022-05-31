//
//  PokemonTableViewCell.swift
//  Pokedex_Codable
//
//  Created by Scott Cox on 5/31/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonSpriteImageView.image = nil
    }
    
    func updateViews(with urlString: String ) {
        NetworkingController.fetchPokemon(with: urlString) { [weak self] result in
            switch result {
            case.success(let pokemon):
                self?.fetchImage(for: pokemon)
            case.failure(let error):
                print("There was an error!", error.errorDescription!)
            }
        }
    }
    
    func fetchImage(for pokemon: Pokemon) {
        NetworkingController.fetchImage(for: pokemon) { [weak self] result in
            switch result {
            case.success(let image):
                DispatchQueue.main.async {
                    self?.pokemonSpriteImageView.image = image
                    self?.pokemonNameLabel.text = pokemon.name.capitalized
                    self?.pokemonIdLabel.text = "No: \(pokemon.id)"
                }
            case.failure(let error):
                print("There was an error!", error.errorDescription!)
            }
        }
    }

}
