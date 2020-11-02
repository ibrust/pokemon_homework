//
//  DetailController.swift
//  pokemon_homework
//
//  Created by Field Employee on 10/30/20.
//

import UIKit

class DetailController: UIViewController {
    
    var temp_name: String = ""
    var temp_id_and_type: String = ""
    var temp_image: UIImage? = nil
    var temp_abilities: String = ""
    var temp_moves: String = ""
    var temp_new_id: String = ""
    
    @IBOutlet weak var name_outlet: UILabel!
    @IBOutlet weak var id_and_type_outlet: UILabel!
    @IBOutlet weak var image_outlet: UIImageView!
    @IBOutlet weak var abilities_outlet: UILabel!
    @IBOutlet weak var moves_outlet: UILabel!
    @IBOutlet weak var new_id_outlet: UILabel!
    
    var first_color: UIColor? = nil
    var second_color: UIColor? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name_outlet.text = self.temp_name
        self.id_and_type_outlet.text = self.temp_id_and_type
        self.image_outlet.image = self.temp_image
        self.abilities_outlet.text = self.temp_abilities
        self.moves_outlet.text = self.temp_moves
        self.new_id_outlet.text = self.temp_new_id
        
        self.name_outlet.backgroundColor = second_color ?? UIColor.white
        self.image_outlet.backgroundColor = first_color ?? UIColor.white
        self.abilities_outlet.backgroundColor = first_color ?? UIColor.white
        self.moves_outlet.backgroundColor = first_color ?? UIColor.white
        self.id_and_type_outlet.backgroundColor = second_color ?? UIColor.white
        self.new_id_outlet.backgroundColor = second_color ?? UIColor.white
    }
}
