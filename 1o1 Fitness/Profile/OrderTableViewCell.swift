//
//  OrderTableViewCell.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 30/10/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var piBtn: UIButton!
    @IBOutlet weak var sdateValLbl: UILabel!
    @IBOutlet weak var sDateLbl: UILabel!
    @IBOutlet weak var priceValLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var prDetailValLbl: UILabel!
    @IBOutlet weak var prDetailsLbl: UILabel!
    @IBOutlet weak var trainerNameValLbl: UILabel!
    @IBOutlet weak var trainerNameLbl: UILabel!
    @IBOutlet weak var progName: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.bgView.layer.cornerRadius = 10
        self.bgView.layer.borderWidth = 0.5
        self.bgView.layer.borderColor = AppColours.topBarGreen.cgColor
        self.progName.textColor = AppColours.textGreen
        self.sDateLbl.textColor = AppColours.textGreen
        self.prDetailsLbl.textColor = AppColours.textGreen
        self.priceLbl.textColor = AppColours.textGreen
        self.trainerNameLbl.textColor = AppColours.textGreen
        self.piBtn.setTitleColor(AppColours.textGreen, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
