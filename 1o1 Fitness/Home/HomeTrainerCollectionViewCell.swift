//
//  HomeTrainerCollectionViewCell.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 27/04/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class HomeTrainerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var ratingBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.nameLbl.textColor = AppColours.appGreen
      //  self.nameLbl.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = AppColours.appGreen.cgColor
        self.contentView.layer.cornerRadius = 8
        self.contentView.clipsToBounds = true
        self.contentView.backgroundColor = UIColor.clear
        
        self.profileImgView.layer.borderWidth = 0.5
        self.profileImgView.layer.borderColor = AppColours.appGreen.cgColor
        self.profileImgView.layer.cornerRadius = 8
        self.profileImgView.layer.masksToBounds = true
        self.profileImgView.backgroundColor = UIColor.clear
    }

}
