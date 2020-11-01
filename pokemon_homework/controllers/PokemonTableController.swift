//
//  PokemonTableControllerTableViewController.swift
//  pokemon_homework
//
//  Created by Field Employee on 10/29/20.
//

import UIKit

class PokemonTableController: UITableViewController, UITableViewDataSourcePrefetching {
    
    let extra_space = 30
    
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
        cell?.id_label_outlet.text = String(temp_id)
        
        var temp_name = (pokemon_previous_next_and_results.results[indexPath.row].name) ?? ""
        temp_name = temp_name.prefix(1).uppercased() + temp_name.lowercased().dropFirst()
        cell?.name_label_outlet.text = temp_name
        
        guard var temp_type = array_of_abilities_moves_id_sprites_types[indexPath.row]?.types[0].type.name ?? "" else {return cell ?? CustomCell()}
        
        let first_color = Type_Colors(rawValue: temp_type)
        var second_color: Type_Colors = first_color!
        
        for index in 1..<(array_of_abilities_moves_id_sprites_types[indexPath.row]?.types.count)! {
            temp_type += "\n" + (array_of_abilities_moves_id_sprites_types[indexPath.row]?.types[index].type.name)!
            second_color = Type_Colors(rawValue: (array_of_abilities_moves_id_sprites_types[indexPath.row]?.types[index].type.name)!) ?? first_color!
        }
        cell?.type_label_outlet.text = temp_type

        cell?.sprite_image_outlet.backgroundColor = first_color?.get_color()
        cell?.name_label_outlet.backgroundColor = first_color?.get_color()
        cell?.type_label_outlet.backgroundColor = first_color?.get_color()
        cell?.id_label_outlet.backgroundColor = first_color?.get_color()
        
        cell?.sprite_image_outlet.isHidden = false
        cell?.id_label_outlet.isHidden = false
        cell?.name_label_outlet.isHidden = false
        cell?.type_label_outlet.isHidden = false
        
        cell?.top_border_outlet.backgroundColor = second_color.get_color()
        cell?.bottom_border_outlet.backgroundColor = second_color.get_color()
        
        
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
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue_to_detail", sender: indexPath.row)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sent_row = sender as? Int ?? 0
        let detail_controller = segue.destination as? DetailController ?? DetailController()

        var temp_name = (pokemon_previous_next_and_results.results[sent_row].name) ?? ""
        temp_name = temp_name.prefix(1).uppercased() + temp_name.lowercased().dropFirst()
        detail_controller.temp_name = temp_name
        
        guard var temp_type = array_of_abilities_moves_id_sprites_types[sent_row]?.types[0].type.name ?? "" else {return}
        
        let first_color = Type_Colors(rawValue: temp_type)
        var second_color: Type_Colors = first_color!
        
        for index in 1..<(array_of_abilities_moves_id_sprites_types[sent_row]?.types.count)! {
            temp_type += ", " + (array_of_abilities_moves_id_sprites_types[sent_row]?.types[index].type.name)!
            second_color = Type_Colors(rawValue: (array_of_abilities_moves_id_sprites_types[sent_row]?.types[index].type.name)!) ?? first_color!
        }
        detail_controller.temp_id_and_type = temp_type
        
        guard let temp_id = array_of_abilities_moves_id_sprites_types[sent_row]?.id else {return}
        
        detail_controller.temp_new_id = String(temp_id)
        
        detail_controller.temp_image = sprite_images[sent_row] ?? UIImage()
        
        var temp_ability_list = "ABILITIES:\n"
        for index in 0..<(array_of_abilities_moves_id_sprites_types[sent_row]?.abilities.count)! {
            temp_ability_list += (array_of_abilities_moves_id_sprites_types[sent_row]?.abilities[index].ability?.name)!
            if index != (array_of_abilities_moves_id_sprites_types[sent_row]?.abilities.count)! - 1 {
                temp_ability_list += "\n"
            }
        }
        detail_controller.temp_abilities = temp_ability_list
        
        var temp_move_list = "MOVES:\n"
        for index in 0..<(array_of_abilities_moves_id_sprites_types[sent_row]?.moves.count)! {
            temp_move_list += (array_of_abilities_moves_id_sprites_types[sent_row]?.moves[index].move?.name)! + "\n"
        }
        detail_controller.temp_moves = temp_move_list
        
        detail_controller.first_color = first_color!.get_color()
        detail_controller.second_color = second_color.get_color()
        
    }
}


