//
//  PokemonTableControllerTableViewController.swift
//  pokemon_homework
//
//  Created by Field Employee on 10/29/20.
//

import UIKit

class PokemonTableController: UITableViewController, UITableViewDataSourcePrefetching {
    
    let operations_list = [Fetch_Pokemon_Operation?](repeating: nil, count: max_pokemon)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.prefetchDataSource = self
        request_list_of_pokemon()
    }
    
    func request_list_of_pokemon(){
        NetworkManager.shared.fetch_list_of_pokemon(global_URL) { [weak self] in ()
            guard let self = self else {return}
            for index in page_offset..<page_size{
                self.request_single_pokemons_data(index)
            }
        }
    }
    
    private func request_single_pokemons_data(_ index: Int){
        /*let data_url = pokemon_previous_next_and_results.results[index].url!
        NetworkManager.shared.fetch_single_pokemons_data(url: data_url, index: index) { [weak self] in ()
            guard let self = self else {return}
            self.request_single_image(index)
        }*/
    }
    
    private func request_single_image(_ index: Int){
        guard let image_url = (array_of_abilities_moves_id_sprites_types[index]?.sprites.front_default) else{return}
        NetworkManager.shared.fetch_single_image(url: image_url) { [weak self] (image) in
            guard let self = self else {return}
            sprite_images[index] = image ?? UIImage()
            let index_path = IndexPath(row: index, section: 0)
            let row_to_reload: [IndexPath] = [index_path]
            DispatchQueue.main.async {
                print("reloading row: ", index)
                self.tableView.reloadRows(at: row_to_reload, with: .none)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("rows at: ", indexPaths)
        
        if let last_path = indexPaths.last?.row {
            if last_path >= page_size { // indicates you need to fetch another list of pokemon
                
            }
        }
        
    }

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension PokemonTableController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return page_size
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom_cell_id", for: indexPath) as? CustomCell

        cell?.sprite_image_outlet.image = sprite_images[indexPath.row] ?? UIImage()
        
        guard let temp_id = array_of_abilities_moves_id_sprites_types[indexPath.row]?.id else {return cell!}
        
        cell?.name_label_outlet.text = String(temp_id)  + ": " +  ((pokemon_previous_next_and_results.results[indexPath.row].name) ?? "")
        
        cell?.type_label_outlet.text = array_of_abilities_moves_id_sprites_types[indexPath.row]?.types[0].type.name ?? ""

        return cell ?? CustomCell()
    }
    
}


