//
//  WorkOuttimeCollectionViewCell.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 12/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class WorkOuttimeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timeBtn: UIButton!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.bgView.layer.borderColor = AppColours.appGreen.cgColor
        self.bgView.layer.borderWidth = 0.5
               self.bgView.layer.cornerRadius = 8
               self.bgView.clipsToBounds = true
    }
//    override var isSelected: Bool{
//        willSet{
//            super.isSelected = newValue
//            if newValue
//            {
//                self.layer.borderWidth = 1.0
//                self.layer.cornerRadius = self.bounds.height / 2
//                self.layer.borderColor = UIColor.violetNeeoColor.cgColor
//                self.genreNameLabel.textColor = UIColor.violetNeeoColor
//            }
//            else
//            {
//                self.layer.borderWidth = 0.0
//                self.layer.cornerRadius = 0.0
//                self.genreNameLabel.textColor = UIColor.white
//            }
//        }
//    }
}
