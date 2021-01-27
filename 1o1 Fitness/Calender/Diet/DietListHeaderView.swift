//
//  DietListHeaderView.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 27/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class DietListHeaderView: UIView {

   
    @IBOutlet weak var totalValLbl: UILabel!
    @IBOutlet weak var fatValLbl: UILabel!
    @IBOutlet weak var carboValLbl: UILabel!
    @IBOutlet weak var proValLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet var contentView: UIView!
   override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
         commonInit()
    }
    private func  commonInit()
    {
        Bundle.main.loadNibNamed("DietListHeader", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
