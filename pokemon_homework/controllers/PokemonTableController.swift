//
//  PokemonTableControllerTableViewController.swift
//  pokemon_homework
//
//  Created by Field Employee on 10/29/20.
//

import UIKit

class PokemonTableController: UITableViewController, UITableViewDataSourcePrefetching {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.prefetchDataSource = self
        var count = 0
        while count < max_pokemon {
            fetch_list_operations.append(Fetch_List_Operation(count, self))
            count = count + page_size
        }
        operations_queue.addOperation(fetch_list_operations[0]!)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return page_offset + page_size
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom_cell_id", for: indexPath) as? CustomCell
        
        /*
        for element in fetch_list_operations {
            if
        }*/

        cell?.sprite_image_outlet.image = sprite_images[indexPath.row] ?? UIImage()
        
        guard let temp_id = array_of_abilities_moves_id_sprites_types[indexPath.row]?.id else {return cell!}
        cell?.name_label_outlet.text = String(temp_id)  + ": " +  ((pokemon_previous_next_and_results.results[indexPath.row].name) ?? "")
        
        cell?.type_label_outlet.text = array_of_abilities_moves_id_sprites_types[indexPath.row]?.types[0].type.name ?? ""

        return cell ?? CustomCell()
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


