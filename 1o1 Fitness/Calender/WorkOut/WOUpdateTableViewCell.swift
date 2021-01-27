//
//  WOUpdateTableViewCell.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 28/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class WOUpdateTableViewCell: UITableViewCell {

    @IBOutlet weak var woUpdateView: WOUpdateView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.woUpdateView.reloadTable()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
