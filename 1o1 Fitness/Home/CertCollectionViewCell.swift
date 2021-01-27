//
//  CertCollectionViewCell.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 27/04/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class CertCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var certLbl: UILabel!
    @IBOutlet weak var certBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cardView.layer.cornerRadius = 10.0
        self.cardView.backgroundColor = AppColours.alertBgColour
    }

}
