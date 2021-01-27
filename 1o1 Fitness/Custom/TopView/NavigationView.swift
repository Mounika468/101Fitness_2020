//
//  NavigationView.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 20/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class NavigationView: UIView {

    @IBOutlet weak var rightArrow: UIButton!
    @IBOutlet weak var leftArrow: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
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
        Bundle.main.loadNibNamed("Navigation", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.saveBtn.isHidden = true
        roundCorners(corners: [.bottomLeft], radius: 40.0)
       // contentView.backgroundColor = UIColor(patternImage: UIImage(named: "navBar")!)
     //   backBtn.addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        
    }
    
    
}
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
