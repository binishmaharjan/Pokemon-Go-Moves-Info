//
//  PokemonCell.swift
//  Pokemon Go Moves Info
//
//  Created by guest on 2017/08/28.
//  Copyright © 2017年 JEC. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {
    
   
    @IBOutlet var pokemon_image: UIImageView!
    @IBOutlet var pokemon_label: UILabel!
    @IBOutlet var type1_image: UIImageView!
    @IBOutlet var type1_label: UILabel!
    @IBOutlet var type2_image: UIImageView!
    @IBOutlet var type2_label: UILabel!
    
    var name : String!
    var type1 : String!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
