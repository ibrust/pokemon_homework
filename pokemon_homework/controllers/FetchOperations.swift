//
//  Fetch_Pokemon_Operation.swift
//  pokemon_homework
//
//  Created by Field Employee on 10/30/20.
//

import UIKit

var fetch_pokemon_operations = [Fetch_Pokemon_Operation?](repeating: nil, count: max_pokemon)
var list_fetching_operations: [Fetch_List_Operation?] = []
var operations_queue = OperationQueue()


class Fetch_List_Operation: Operation {
    var operation_URL: String
    var starting_row: Int
    var table_controller_reference: PokemonTableController?
    
    init(_ starting_row: Int, _ passed_table_controller: PokemonTableController?){
        self.starting_row = starting_row
        self.operation_URL = "https://pokeapi.co/api/v2/pokemon?offset=\(starting_row)&limit=\(starting_row + page_size)"
        super.init()
        table_controller_reference = passed_table_controller
    }
    
    override func main(){
        NetworkManager.shared.fetch_list_of_pokemon(operation_URL, offset:  starting_row) { [weak self] in ()
            guard let self = self else {return}
            DispatchQueue.main.async {
                page_offset = page_offset + page_size
                self.table_controller_reference?.tableView.reloadData()
                
                for index in self.starting_row..<(self.starting_row + page_size) {
                    if index < max_pokemon {
                        fetch_pokemon_operations[index] = Fetch_Pokemon_Operation(index, self.table_controller_reference)
                        operations_queue.addOperation(fetch_pokemon_operations[index]!)
                    }
                }
            }
        }
    }
}

class Fetch_Pokemon_Operation: Operation {
    var saved_index: Int
    var table_controller_reference: PokemonTableController?
    
    init(_ index: Int, _ passed_table_controller: PokemonTableController?){
        saved_index = index
        super.init()
        table_controller_reference = passed_table_controller
    }
    
    override func main(){
        let data_url = pokemon_previous_next_and_results.results[saved_index].url!
        NetworkManager.shared.fetch_single_pokemons_data(url: data_url, index: saved_index) { [weak self] in ()
            guard let self = self else {return}
            self.request_single_image(self.saved_index)
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
                table_controller_reference.tableView.reloadRows(at: row_to_reload, with: .none)
            }
        }
    }
}


