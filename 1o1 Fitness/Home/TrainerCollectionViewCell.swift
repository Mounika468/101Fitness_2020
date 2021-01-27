//
//  TrainerCollectionViewCell.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 22/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class TrainerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: CardView!
    @IBOutlet weak var ratingBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    
    var cornnerRadius : CGFloat = 5
    var shadowOfSetWidth : CGFloat = 0
    var shadowOfSetHeight : CGFloat = 5
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profileImgView.layer.cornerRadius = 0.5 * profileImgView.bounds.size.width
        self.profileImgView.clipsToBounds = true
        self.profileImgView.layer.borderColor = UIColor.white.cgColor
        self.profileImgView.layer.borderWidth = 1.0
//        self.contentView.layer.cornerRadius = cornnerRadius
//        self.contentView.layer.borderColor = UIColor.gray.cgColor
//        self.contentView.layer.borderWidth = 0.2
//        self.contentView.layer.shadowColor = UIColor.black.cgColor
//        self.contentView.layer.shadowOffset = CGSize(width: shadowOfSetWidth, height: shadowOfSetHeight)
//        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornnerRadius)
//        self.contentView.layer.shadowPath = shadowPath.cgPath
//       // self.contentView.layer.shadowRadius = 12.0
//        self.contentView.layer.shadowOpacity = Float(0.7)
//    }
//    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
//        self.contentView.layer.cornerRadius = cornnerRadius
//        self.contentView.layer.borderColor = AppColours.appGreen.cgColor
//        self.contentView.layer.borderWidth = 0.2
//      self.contentView.layer.masksToBounds = false
//      self.contentView.layer.shadowColor = UIColor.black.cgColor
//      self.contentView.layer.shadowOpacity = Float(0.7)
//      self.contentView.layer.shadowOffset = CGSize(width: shadowOfSetWidth, height: shadowOfSetHeight)
//      self.contentView.layer.shadowRadius = 5
//
//      self.contentView.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//      self.contentView.layer.shouldRasterize = true
        //self.contentView.layer.rasterizationScale = 0.5
    }
    
}

