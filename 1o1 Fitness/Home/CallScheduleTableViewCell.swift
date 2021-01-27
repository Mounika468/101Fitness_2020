//
//  CallScheduleTableViewCell.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 28/08/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class CallScheduleTableViewCell: UITableViewCell {
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
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
