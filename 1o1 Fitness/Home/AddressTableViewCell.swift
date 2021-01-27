//
//  AddressTableViewCell.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 11/06/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var phonrLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var streetLbl: UILabel!
    @IBOutlet weak var addressTypeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addressTypeLbl.layer.backgroundColor = AppColours.lineColor.cgColor
        self.addressTypeLbl.layer.cornerRadius = 10
        self.addressTypeLbl.layer.borderColor = AppColours.lineColor.cgColor
        self.addressTypeLbl.layer.borderWidth = 1
    }

    @IBAction func btnCheckTapped(_ sender: Any) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
