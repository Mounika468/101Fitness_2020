//
//  DietListTableViewCell.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 06/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class DietListTableViewCell: UITableViewCell {

    @IBOutlet weak var calLbl: UILabel!
    
    @IBOutlet weak var timeBtn: UILabel!
    @IBOutlet weak var dietCompletImgView: UIImageView!
    @IBOutlet weak var nxtBtn: UIButton!
    
   // @IBOutlet weak var timeBtn: UIButton!
    @IBOutlet weak var qtyLbl: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        timeBtn.layer.cornerRadius = 10.0
        timeBtn.layer.borderColor = AppColours.textGreen.cgColor
        timeBtn.layer.borderWidth = 0.8
        self.contentView.backgroundColor = UIColor.black
        self.imgView.layer.cornerRadius = 10.0
        imgView.layer.borderColor = AppColours.textGreen.cgColor
        imgView.layer.borderWidth = 0.8
        
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
       // self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 30, right: 10))
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
}
