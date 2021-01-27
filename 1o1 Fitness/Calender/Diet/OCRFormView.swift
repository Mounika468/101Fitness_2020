//
//  OCRFormView.swift
//  1o1 Fitness
//
//  Created by Hareen.Pulivarthi on 16/09/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class OCRFormView: UIView {

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
           Bundle.main.loadNibNamed("OCRFormView", owner: self, options: nil)
           addSubview(contentView)
           contentView.frame = self.bounds
           contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
