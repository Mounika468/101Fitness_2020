//
//  TrainerProfileView.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 07/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
//protocol CustomAlertViewDelegate {
//    func keepBrowsingBtnTapped()
//    func singUpBtnTapped()
//}
class CustomAlertView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var keepBrowsingBtn: UIButton!
    
    @IBOutlet weak var singupBtn: UIButton!
    @IBOutlet weak var descLbl: UILabel!
   // var customAlertDelegate : CustomAlertViewDelegate?
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
        Bundle.main.loadNibNamed("CustomAlertView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .black
        self.headerLbl.textColor = AppColours.textGreen
        self.descLbl.textColor = AppColours.textGreen
        self.singupBtn.setTitleColor(AppColours.appGreen, for: .normal)
        self.keepBrowsingBtn.setTitleColor(AppColours.appGreen, for: .normal)
        self.keepBrowsingBtn.drawBorder(edges: [.top,.bottom], borderWidth: 0.3, color: UIColor.lightGray, margin: 0)
        self.singupBtn.drawBorder(edges: [.top,.bottom,.right], borderWidth: 0.3, color: UIColor.lightGray, margin: 0)
      //  self.singupBtn.alpha = 0.5
       // self.keepBrowsingBtn.alpha = 0.5
        
    }

//    @IBAction func keepBrowsingBtnTapped(_ sender: Any) {
//        customAlertDelegate?.keepBrowsingBtnTapped()
//    }
//    @IBAction func singUpBtnTapped(_ sender: Any) {
//        customAlertDelegate?.singUpBtnTapped()
//    }
//
}

