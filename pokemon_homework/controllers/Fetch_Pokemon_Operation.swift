//
//  Fetch_Pokemon_Operation.swift
//  pokemon_homework
//
//  Created by Field Employee on 10/30/20.
//

import UIKit


class Fetch_Pokemon_Operation: Operation {
    
    var operation_index: Int
    var table_controller_reference: PokemonTableController?
    
    init(_ index: Int, _ passed_table_controller: PokemonTableController?){
        operation_index = index
        super.init()
        table_controller_reference = passed_table_controller
    }
    
    override func main(){
        request_single_pokemons_data(operation_index)
    }
    
    private func request_single_pokemons_data(_ index: Int){
        let data_url = pokemon_previous_next_and_results.results[index].url!
        NetworkManager.shared.fetch_single_pokemons_data(url: data_url, index: index) { [weak self] in ()
            guard let self = self else {return}
            self.request_single_image(index)
        }
    }
    
    private func request_single_image(_ index: Int){
        guard let image_url = (array_of_abilities_moves_id_sprites_types[index]?.sprites.front_default) else{return}
        NetworkManager.shared.fetch_single_image(url: image_url) { [weak table_controller_reference] (image) in
            guard let table_controller_reference = table_controller_reference else {return}

            sprite_images[index] = image ?? UIImage()
            let index_path = IndexPath(row: index, section: 0)
            let row_to_reload: [IndexPath] = [index_path]
            DispatchQueue.main.async {
                print("reloading row: ", index)
                table_controller_reference.tableView.reloadRows(at: row_to_reload, with: .none)
            }
        }
    }
}


