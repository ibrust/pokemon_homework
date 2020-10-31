//
//  PokemonTableControllerTableViewController.swift
//  pokemon_homework
//
//  Created by Field Employee on 10/29/20.
//

import UIKit

class PokemonTableController: UITableViewController, UITableViewDataSourcePrefetching {
    
    var operations_list = [Fetch_Pokemon_Operation?](repeating: nil, count: max_pokemon)
    var operations_queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.prefetchDataSource = self
        request_list_of_pokemon()
    }
    
    
    // you really want to move this into the operation class and then call these in prefetch
    // and in cellforrowat ....
    func request_list_of_pokemon(){
        NetworkManager.shared.fetch_list_of_pokemon(global_URL) { [weak self] in ()
            guard let self = self else {return}
            for index in page_offset..<page_size{
                self.operations_list[index] = Fetch_Pokemon_Operation(index, self)
                self.operations_queue.addOperation(self.operations_list[index]!)
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


