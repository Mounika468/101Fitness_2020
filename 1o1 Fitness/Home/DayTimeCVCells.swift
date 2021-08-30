//
//  DayTimeCVCells.swift
//  1o1 Fitness
//
//  Created by Mounika Reddy on 02/08/21.
//  Copyright © 2021 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class DayTimeCVCells: UICollectionViewCell {

    @IBOutlet weak var timeBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.timeBtn.setTitleColor(AppColours.textGreen, for: .normal)
        self.timeBtn.layer.cornerRadius = 10
        self.timeBtn.layer.borderWidth = 0.6
        self.timeBtn.layer.borderColor = AppColours.textGreen.cgColor
    }

    
    
    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
            if isSelected {
                timeBtn.backgroundColor = .lightGray
            } else {
                timeBtn.backgroundColor = .clear
            }
        }
    }
}
