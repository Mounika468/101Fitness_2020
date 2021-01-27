//
//  ExerciseInfoView.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 08/06/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class ExerciseInfoView: UIView {

    @IBOutlet weak var forceLbl: UILabel!
    @IBOutlet weak var woTypeLbl: UILabel!
    @IBOutlet weak var eqLbl: UILabel!
    @IBOutlet weak var mtTypeLbl: UILabel!
    @IBOutlet weak var otherMuImgView2: UIImageView!
    @IBOutlet weak var otherMuImgView1: UIImageView!
    @IBOutlet weak var mainMsImgView: UIImageView!
    @IBOutlet weak var prLevelLbl: UILabel!
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
          Bundle.main.loadNibNamed("ExerciseInfoView", owner: self, options: nil)
          addSubview(contentView)
          contentView.frame = self.bounds
          contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
         
      }

}
