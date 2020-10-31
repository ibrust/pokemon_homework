//
//  CustomCellTableViewCell.swift
//  pokemon_homework
//
//  Created by Field Employee on 10/29/20.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var sprite_image_outlet: UIImageView!
    @IBOutlet weak var name_label_outlet: UILabel!
    @IBOutlet weak var type_label_outlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
