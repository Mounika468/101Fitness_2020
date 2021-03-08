//
//  RatingTableViewCell.swift
//  1o1 Fitness
//
//  Created by Mounika Reddy on 12/02/21.
//  Copyright © 2021 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import Cosmos
class RatingTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var ratingsView: CosmosView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.nameLbl.textColor = AppColours.topBarGreen
        self.dateLbl.textColor = AppColours.topBarGreen
        self.comments.textColor = .white
        self.imgView.layer.cornerRadius = 0.5 * imgView.bounds.size.width
        self.imgView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
