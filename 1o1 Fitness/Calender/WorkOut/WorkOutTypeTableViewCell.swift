//
//  WorkOutTypeTableViewCell.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 27/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class WorkOutTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var perExerLbl: UILabel!
    @IBOutlet weak var numOfExeLbl: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var perWOLbl: UILabel!
    @IBOutlet weak var workOutNameLbl: UILabel!
    @IBOutlet weak var workOutImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.startBtn.layer.cornerRadius = 10
        self.startBtn.clipsToBounds = true
        self.startBtn.layer.borderWidth = 1
        self.startBtn.layer.borderColor = AppColours.appGreen.cgColor
        self.numOfExeLbl.textColor = AppColours.graphBlue
        self.perExerLbl.textColor = AppColours.appYellow
      //  self.contentView.backgroundColor = UIColor(patternImage: UIImage(named: "cellBg")!)
        
        self.workOutImgView.layer.cornerRadius = 15
        self.contentView.layer.cornerRadius = 15
        
        self.contentView.layer.shadowColor = AppColours.textGreen.cgColor
        self.contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.contentView.layer.shadowOpacity = 0.3
        self.contentView.layer.shadowRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editBtnTapped(_ sender: UIButton) {
    }
}
