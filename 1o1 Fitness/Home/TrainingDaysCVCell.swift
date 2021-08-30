//
//  TrainingDaysCVCell.swift
//  1o1 Fitness
//
//  Created by Mounika Reddy on 02/08/21.
//  Copyright © 2021 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class TrainingDaysCVCell: UICollectionViewCell {

    @IBOutlet weak var datBtn: UIButton!
    @IBOutlet weak var dayName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dayName.textColor = AppColours.textGreen
//        datBtn.layer.cornerRadius = datBtn.frame.size.width/2
//        datBtn.layer.borderWidth = 1
//        datBtn.layer.borderColor = AppColours.textGreen.cgColor
    }

    @IBAction func datBtnTapped(_ sender: Any) {
        
    }
//    override var isSelected: Bool {
//        didSet {
//            super.isSelected = isSelected
//            if isSelected {
//                datBtn.backgroundColor = AppColours.textGreen
//            } else {
//                datBtn.backgroundColor = .clear
//            }
//        }
//    }
}
