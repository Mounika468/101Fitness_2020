//
//  BorderCellTableViewCell.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 16/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class BorderCellTableViewCell: UITableViewCell {
   // @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var bgView: CardView!
    @IBOutlet weak var headerLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.bgView.layer.borderWidth = 0.5
//        self.bgView.layer.borderColor = AppColours.textGreen.cgColor
//        self.bgView.layer.cornerRadius = 10
//        self.bgView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

        if selected {
            bgView.backgroundColor = AppColours.appGreen
        } else {
            bgView.backgroundColor = UIColor.black
        }
    }
    
}
