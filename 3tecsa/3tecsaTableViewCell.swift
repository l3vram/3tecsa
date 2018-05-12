//
//  3tecsaTableViewCell.swift
//  3tecsa
//
//  Created by Marvel Alvarez on 12/23/16.
//  Copyright (c) 2016 Marvel Alvarez. All rights reserved.
//

import UIKit

class _tecsaTableViewCell: UITableViewCell {

   
    
    @IBOutlet weak var labNombre: UILabel!
    
    @IBOutlet weak var labNumero: UILabel!
       
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
        // Configure the view for the selected state
    }

}
