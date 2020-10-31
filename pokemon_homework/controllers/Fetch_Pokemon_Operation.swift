//
//  Fetch_Pokemon_Operation.swift
//  pokemon_homework
//
//  Created by Field Employee on 10/30/20.
//

import Foundation


class Fetch_Pokemon_Operation: Operation {
    
    var operation_index: Int
    
    init(_ index: Int){
        super.init()
        operation_index = index
    }
    
    override func main(){
        let data_url = pokemon_previous_next_and_results.results[operation_index].url!
        NetworkManager.shared.fetch_single_pokemons_data(url: data_url, index: index) { [weak self] in ()
            guard let self = self else {return}
            self.request_single_image(index)
        }
    }
    
}


