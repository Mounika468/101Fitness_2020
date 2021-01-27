//
//  ProgramTableViewCell.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 29/10/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class ProgramTableViewCell: UITableViewCell {

    @IBOutlet weak var prStatusLbl: UILabel!
    @IBOutlet weak var detailsBtn: UIButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var prssView: UIProgressView!
    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var prNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        prNameLbl.textColor = AppColours.graphYello
        durationLbl.textColor = UIColor.white
        progressLbl.textColor = AppColours.graphBlue
        prssView.backgroundColor = UIColor.white
        detailsBtn.setTitleColor(AppColours.topBarGreen, for: .normal)
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
