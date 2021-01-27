//
//  NotificationTableViewCell.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 30/11/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        nameLbl.textColor = AppColours.textGreen
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
