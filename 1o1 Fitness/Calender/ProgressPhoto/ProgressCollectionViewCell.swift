//
//  ProgressCollectionViewCell.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 24/08/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView.layer.cornerRadius = 10
        imgView.layer.borderColor = AppColours.lineColor.cgColor
        imgView.layer.borderWidth = 0.6
    }

}
