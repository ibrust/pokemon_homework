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
    
    @IBOutlet weak var name_outlet: UILabel!
    @IBOutlet weak var id_and_type_outlet: UILabel!
    @IBOutlet weak var image_outlet: UIImageView!
    @IBOutlet weak var abilities_outlet: UILabel!
    @IBOutlet weak var moves_outlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name_outlet.text = self.temp_name
        self.id_and_type_outlet.text = self.temp_id_and_type
        self.image_outlet.image = self.temp_image
        self.abilities_outlet.text = self.temp_abilities
        self.moves_outlet.text = self.temp_moves
    }
}
