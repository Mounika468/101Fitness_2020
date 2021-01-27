//
//  SearchResTableViewCell.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 28/07/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class SearchResTableViewCell: UITableViewCell {

    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var servingLbl: UILabel!
    @IBOutlet weak var foodComName: UILabel!
    @IBOutlet weak var foodName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
