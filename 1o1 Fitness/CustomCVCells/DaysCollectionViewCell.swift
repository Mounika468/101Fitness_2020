//
//  DaysCollectionViewCell.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 12/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class DaysCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dayBtn: UIButton!
    @IBOutlet weak var dayLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.dayBtn.layer.borderWidth = 0.5
        self.dayBtn.layer.borderColor = AppColours.appGreen.cgColor
    }

}
