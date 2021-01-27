//
//  MeatCollectionViewCell.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 13/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//

import UIKit
protocol FoodChoiceDelegate {
    func changeImage(indexPath: IndexPath?)
}
class MeatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: CardView!
    var delegate: FoodChoiceDelegate?
    var selectedAtIndex: IndexPath?
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //  self.imgView.isUserInteractionEnabled = true
        self.imgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeImage)))
//        self.contentView.layer.borderWidth = 0.5
//        self.contentView.layer.borderColor = AppColours.appGreen.cgColor
//        self.contentView.layer.cornerRadius = 8
//        self.contentView.clipsToBounds = true
        
    }
    @objc func changeImage(){
        delegate?.changeImage(indexPath: selectedAtIndex)
    }
}
