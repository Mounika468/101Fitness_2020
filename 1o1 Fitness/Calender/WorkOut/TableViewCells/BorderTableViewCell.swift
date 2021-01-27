//
//  BorderTableViewCell.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 06/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class BorderTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: CardView!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.bgView.layer.borderWidth = 0.5
//        self.bgView.layer.borderColor = AppColours.appGreen.cgColor
//        self.bgView.layer.cornerRadius = 8
//        self.bgView.clipsToBounds = true
        self.headerLbl.textColor = UIColor.white
         self.detailLbl.textColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.bgView.backgroundColor = UIColor.clear
        // Configure the view for the selected state
        if selected {
             self.bgView.backgroundColor = AppColours.appGreen
        } else {
            self.bgView.backgroundColor = UIColor.black
        }
    }
    
}
