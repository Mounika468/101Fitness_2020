//
//  ProfileBottomView.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 04/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
protocol BottomViewDelegate {
    func leftBtnTapped()
    func rightBtnTapped()
}
class ProfileBottomView: UIView {

    @IBOutlet var contentView: UIView!
    var bottonDelegate : BottomViewDelegate?
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
          Bundle.main.loadNibNamed("ProfileBottom", owner: self, options: nil)
          addSubview(contentView)
          contentView.frame = self.bounds
          contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
           self.contentView.backgroundColor = UIColor.black
       //   backBtn.addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
          
      }
    @IBAction func leftBtnTapped(_ sender: Any) {
        bottonDelegate?.leftBtnTapped()
    }
    
    @IBAction func rightBtnTapped(_ sender: Any) {
         bottonDelegate?.rightBtnTapped()
    }
}
