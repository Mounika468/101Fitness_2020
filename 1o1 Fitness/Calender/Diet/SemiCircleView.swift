//
//  SemiCircleView.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 03/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class SemiCircleView: UIView {

    @IBOutlet weak var exploreBtn: UIButton!
    @IBOutlet weak var fatLbl: UILabel!
    @IBOutlet weak var proteinLbl: UILabel!
    @IBOutlet weak var carbLbl: UILabel!
    @IBOutlet weak var imgView3: UIImageView!
    @IBOutlet weak var imgView2: UIImageView!
    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var progress3: MBCircularProgressBarView!
    @IBOutlet weak var progress2: MBCircularProgressBarView!
    @IBOutlet weak var progress1: MBCircularProgressBarView!
    @IBOutlet var contentView: UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
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
        Bundle.main.loadNibNamed("SemiCircleView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
       
    }

}
