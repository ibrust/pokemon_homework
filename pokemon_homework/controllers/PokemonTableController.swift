//
//  PokemonTableControllerTableViewController.swift
//  pokemon_homework
//
//  Created by Field Employee on 10/29/20.
//

import UIKit

class PokemonTableController: UITableViewController, UITableViewDataSourcePrefetching {
    
    let extra_prefetch_space = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.prefetchDataSource = self
        var count = 0
        while count < max_pokemon {
            list_fetching_operations.append(Fetch_List_Operation(count, self))
            count = count + page_size
        }
        operations_queue.addOperation(list_fetching_operations[0]!)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if page_offset + page_size <= max_pokemon {
            return page_offset + page_size
        } else {
            return max_pokemon
        }
    }
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        var highest_row = 0
        for path in indexPaths {
            if path.row > highest_row{
                highest_row = path.row
            }
        }
        for single_fetched_operation in list_fetching_operations {
            if (single_fetched_operation?.starting_row ?? -1) >= page_offset {
                let unwrapped_operation = single_fetched_operation!
                if highest_row + extra_prefetch_space >= unwrapped_operation.starting_row {
                    if unwrapped_operation.isExecuting == false && unwrapped_operation.isFinished == false {
                        operations_queue.addOperation(unwrapped_operation)
                        break
                    }
                }
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue_to_detail", sender: indexPath.row)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom_cell_id", for: indexPath) as? CustomCell ?? CustomCell()
        for single_fetched_operation in list_fetching_operations {
            if (single_fetched_operation?.starting_row ?? -1) >= page_offset {
                let unwrapped_operation = single_fetched_operation!
                if indexPath.row >= unwrapped_operation.starting_row {
                    if unwrapped_operation.isExecuting == false && unwrapped_operation.isFinished == false {
                        operations_queue.addOperation(unwrapped_operation)
                    }
                }
                break
            }
        }
        
        style_cell(cell: cell, row: indexPath.row)
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sent_row = sender as? Int ?? 0
        let detail_controller = segue.destination as? DetailController ?? DetailController()

        style_detail(detail_controller, sent_row)
    }
    
    
    private func style_detail(_ detail_controller: DetailController, _ row: Int){
        let data_array = array_of_abilities_moves_id_sprites_types[row]!
        
        var temp_name = (pokemon_previous_next_and_results.results[row].name) ?? ""
        temp_name = temp_name.prefix(1).uppercased() + temp_name.lowercased().dropFirst()
        
        guard var temp_type = data_array.types[0].type.name else {return}
        let first_color = Type_Colors(rawValue: temp_type) ?? .normal
        var second_color: Type_Colors = first_color
        
        for index in 1..<data_array.types.count {
            guard let one_type = data_array.types[index].type.name else {return}
            temp_type += ", " + one_type
            second_color = Type_Colors(rawValue: ((data_array.types[index].type.name) ?? "-")) ?? first_color
        }
        
        guard let temp_id = data_array.id else {return}
    
        var temp_ability_list = "ABILITIES:\n"
        for index in 0..<data_array.abilities.count {
            temp_ability_list += ((data_array.abilities[index].ability?.name) ?? "-")
            if index != data_array.abilities.count - 1 {
                temp_ability_list += "\n"
            }
        }
    
        var temp_move_list = "MOVES:\n"
        for index in 0..<data_array.moves.count {
            temp_move_list += ((data_array.moves[index].move?.name) ?? "-") + "\n"
        }
        
        detail_controller.temp_abilities = temp_ability_list
        detail_controller.temp_name = temp_name
        detail_controller.temp_id_and_type = temp_type
        detail_controller.temp_new_id = String(temp_id)
        detail_controller.temp_image = sprite_images[row] ?? UIImage()
        detail_controller.temp_moves = temp_move_list
        
        detail_controller.first_color = first_color.get_color()
        detail_controller.second_color = second_color.get_color()
    }
    
    
    private func style_cell(cell: CustomCell, row: Int){
        let data_array = array_of_abilities_moves_id_sprites_types[row]
        guard let temp_id = data_array?.id else {return}
        
        var temp_name = (pokemon_previous_next_and_results.results[row].name) ?? ""
        temp_name = temp_name.prefix(1).uppercased() + temp_name.lowercased().dropFirst()
        
        guard var temp_type = data_array?.types[0].type.name ?? "" else {return}
        
        let first_color = Type_Colors(rawValue: temp_type) ?? .normal
        var second_color: Type_Colors = first_color
        
        for index in 1..<(data_array?.types.count)! {
            temp_type += "\n" + ((data_array?.types[index].type.name) ?? "-")
            second_color = Type_Colors(rawValue: (data_array?.types[index].type.name) ?? "-") ?? first_color
        }
        
        cell.id_label_outlet.text = String(temp_id)
        cell.sprite_image_outlet.image = sprite_images[row] ?? UIImage()
        cell.name_label_outlet.text = temp_name
        cell.type_label_outlet.text = temp_type

        cell.sprite_image_outlet.backgroundColor = first_color.get_color()
        cell.name_label_outlet.backgroundColor = first_color.get_color()
        cell.type_label_outlet.backgroundColor = first_color.get_color()
        cell.id_label_outlet.backgroundColor = first_color.get_color()
        
        cell.sprite_image_outlet.isHidden = false
        cell.id_label_outlet.isHidden = false
        cell.name_label_outlet.isHidden = false
        cell.type_label_outlet.isHidden = false
        
        cell.top_border_outlet.backgroundColor = second_color.get_color()
        cell.bottom_border_outlet.backgroundColor = second_color.get_color()
    }
}


