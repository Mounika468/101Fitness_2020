//
//  RestTableViewCell.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 13/02/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class RestTableViewCell: UITableViewCell {

    @IBOutlet weak var restVal: UILabel!
    @IBOutlet weak var restLbl: UILabel!
    @IBOutlet weak var restImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
