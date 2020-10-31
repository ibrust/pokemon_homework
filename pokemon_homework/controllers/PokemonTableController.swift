//
//  PokemonTableControllerTableViewController.swift
//  pokemon_homework
//
//  Created by Field Employee on 10/29/20.
//

import UIKit

class PokemonTableController: UITableViewController, UITableViewDataSourcePrefetching {
    
    var extra_space = 30
    
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
        
        if page_offset + page_size <= max_pokemon {
            return page_offset + page_size
        } else {
            return max_pokemon
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom_cell_id", for: indexPath) as? CustomCell
        
        for single_fetch in fetch_list_operations {
            if single_fetch!.starting_row >= page_offset {
                if indexPath.row >= single_fetch!.starting_row {
                    if single_fetch!.isExecuting == false && single_fetch!.isFinished == false {
                        operations_queue.addOperation(single_fetch!)
                    }
                }
                break
            }
        }
        
        cell?.sprite_image_outlet.image = sprite_images[indexPath.row] ?? UIImage()
        
        guard let temp_id = array_of_abilities_moves_id_sprites_types[indexPath.row]?.id else {return cell!}
        cell?.name_label_outlet.text = String(temp_id)  + ": " +  ((pokemon_previous_next_and_results.results[indexPath.row].name) ?? "")
        
        cell?.type_label_outlet.text = array_of_abilities_moves_id_sprites_types[indexPath.row]?.types[0].type.name ?? ""

        return cell ?? CustomCell()
    }
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        var highest_row = 0
        for path in indexPaths {
            if path.row > highest_row{
                highest_row = path.row
            }
        }
        
        for single_fetch in fetch_list_operations {
            if single_fetch!.starting_row >= page_offset {
                if highest_row + extra_space >= single_fetch!.starting_row {
                    if single_fetch!.isExecuting == false && single_fetch!.isFinished == false {
                        operations_queue.addOperation(single_fetch!)
                        break
                    }
                }
            }
        }
        /*
        for indexPath in indexPaths {
            let cell = tableView.dequeueReusableCell(withIdentifier: "custom_cell_id", for: indexPath) as? CustomCell
            
            cell?.sprite_image_outlet.image = sprite_images[indexPath.row] ?? UIImage()
            
            guard let temp_id = array_of_abilities_moves_id_sprites_types[indexPath.row]?.id else {return}
            cell?.name_label_outlet.text = String(temp_id)  + ": " +  ((pokemon_previous_next_and_results.results[indexPath.row].name) ?? "")
            
            cell?.type_label_outlet.text = array_of_abilities_moves_id_sprites_types[indexPath.row]?.types[0].type.name ?? ""
        }*/
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue_to_detail", sender: indexPath.row)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sent_row = sender as? Int ?? 0
        var detail_controller = segue.destination as? DetailController ?? DetailController()

        detail_controller.temp_name = (pokemon_previous_next_and_results.results[sent_row].name) ?? ""
        guard let temp_id = array_of_abilities_moves_id_sprites_types[sent_row]?.id else {return}
        detail_controller.temp_id_and_type = String(temp_id)  + ": " + (array_of_abilities_moves_id_sprites_types[sent_row]?.types[0].type.name)! ?? ""
        
        detail_controller.temp_image = sprite_images[sent_row] ?? UIImage()
    }
    /*
     var temp_abilities: String = ""
     var temp_moves: String = ""*/
    
}


