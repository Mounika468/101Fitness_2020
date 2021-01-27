//
//  DetailSectionHeader.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 08/06/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class DetailSectionHeader: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var sectionHeaderLbl: UILabel!
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
              Bundle.main.loadNibNamed("DetailSectionHeader", owner: self, options: nil)
              addSubview(contentView)
              contentView.frame = self.bounds
              contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
             
          }
    
}
