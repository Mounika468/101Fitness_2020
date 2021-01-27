//
//  ScheduleTableViewCell.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 12/08/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var deleteTapped: UIButton!
    @IBOutlet weak var startLbl: UILabel!
    @IBOutlet weak var durationValLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var unavailableLbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgView.layer.cornerRadius = 10
//               self.imgView.clipsToBounds = true
//               self.imgView.layer.borderColor = UIColor.white.cgColor
//               self.imgView.layer.borderWidth = 1.0
       
        self.contentView.backgroundColor = UIColor.black
        self.startLbl.textColor = AppColours.appYellow
        self.durationLbl.textColor = AppColours.appYellow
        self.nameLbl.textColor = AppColours.textGreen
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
