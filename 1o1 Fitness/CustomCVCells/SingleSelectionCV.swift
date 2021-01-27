//
//  SingleSelectionCV.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 06/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
protocol SingleSelectionCVDelegate {
    func buttonSelected(btn:UIButton)
}
class SingleSelectionCV: UICollectionViewCell {

    @IBOutlet weak var singleBtn: UILabel!
 //   @IBOutlet weak var singleBtn: UIButton!
    var singleSelectionCVDelegate : SingleSelectionCVDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.singleBtn.layer.cornerRadius = 15
        self.singleBtn.layer.borderColor = AppColours.appGreen.cgColor
        self.singleBtn.layer.borderWidth = 1.0
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        self.singleSelectionCVDelegate?.buttonSelected(btn: sender)
    }
}
