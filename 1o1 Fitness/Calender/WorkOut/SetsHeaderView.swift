//
//  SetsHeaderView.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 26/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class SetsHeaderView: UIView {

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
               Bundle.main.loadNibNamed("SetsHeaderView", owner: self, options: nil)
               addSubview(contentView)
               contentView.frame = self.bounds
               contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
               contentView.backgroundColor = UIColor.clear
       }

}
