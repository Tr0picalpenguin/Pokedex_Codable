//
//  PokedexTableViewController.swift
//  Pokedex_Codable
//
//  Created by Scott Cox on 5/31/22.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    var pokedex: [ResultsDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkingController.fetchPokedex(with: URL(string: "https://pokeapi.co/api/v2/pokemon")!) { [weak self] result in
            switch result {
            case.success(let pokedex):
                self?.pokedex = pokedex.results
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case.failure(let error):
                print("There was an error!", error.errorDescription!)
            }
        }
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokedex.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()}
        
        let pokemon = pokedex[indexPath.row]
        cell.updateViews(with: pokemon.url)
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        if segue.identifier == "toPokedexTableVC" {
            //Index
            if let indexPath = tableView.indexPathForSelectedRow {
                //Destination
                if let destination = segue.destination as? PokemonViewController {
                    let pokemonToSend = pokedex[indexPath.row]
                    NetworkingController.fetchPokemon(with: pokemonToSend.url) { result in
                        switch result {
                        case.success(let pokemon):
                            DispatchQueue.main.async {
                                destination.pokemon = pokemon
                            }
                        case.failure(let error):
                            print("There was an Error!", error.localizedDescription)
                        }
                    
                    }
                }
            }
        }
    } // End of class
    
    
    



