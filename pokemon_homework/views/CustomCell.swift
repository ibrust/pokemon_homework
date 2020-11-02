//
//  CustomCellTableViewCell.swift
//  pokemon_homework
//
//  Created by Field Employee on 10/29/20.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var id_label_outlet: UILabel!
    @IBOutlet weak var sprite_image_outlet: UIImageView!
    @IBOutlet weak var name_label_outlet: UILabel!
    @IBOutlet weak var type_label_outlet: UILabel!
    @IBOutlet weak var top_border_outlet: UIView!
    @IBOutlet weak var bottom_border_outlet: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 3, left: 0, bottom: 3, right: 0))
        self.backgroundColor = UIColor.black
    }
}
