//
//  BorderCellTableViewCell.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 16/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class CardStyleTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: CardView!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.bgView.layer.borderWidth = 1
//        self.bgView.layer.borderColor = AppColours.appGreen.cgColor
//        self.bgView.backgroundColor = .black
//        self.bgView.clipsToBounds = true
//
//        //self.bgView.backgroundColor = UIColor(patternImage: UIImage(named: "cellBg")!)
//
//
//        self.bgView.layer.cornerRadius = 15
//
//               self.bgView.layer.shadowColor = AppColours.appGreen.cgColor
//               self.bgView.layer.shadowOffset = CGSize(width: 0, height: 0)
//               self.bgView.layer.shadowOpacity = 5
//               self.bgView.layer.shadowRadius = 5.0
        

    }


    
}
