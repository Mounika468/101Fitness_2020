//
//  CardView.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 27/04/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CardView: UIView {
    var cornnerRadius : CGFloat = 20
    var shadowOfSetWidth : CGFloat = 0
    var shadowOfSetHeight : CGFloat = 0
    
    var shadowColour : UIColor = UIColor.lightText
    var shadowOpacity : CGFloat = 0.5
    
    override func layoutSubviews() {
        self.backgroundColor = UIColor.black
        layer.cornerRadius = cornnerRadius
        layer.shadowColor = shadowColour.cgColor
        layer.shadowRadius = 6
        layer.shadowOffset = CGSize(width: shadowOfSetWidth, height: shadowOfSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornnerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
}
