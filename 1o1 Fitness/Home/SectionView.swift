//
//  SectionView.swift
//  ExpandCollapseSections
//
//  Created by Mounika.x.muduganti on 29/04/20.
//  Copyright © 2020 ProgrammingWithSwift. All rights reserved.
//

import UIKit

class SectionView: UIView {

    @IBOutlet weak var middleTxtImgView: UIImageView!
    @IBOutlet weak var txtImgView: UIImageView!
    @IBOutlet weak var middleImgView: UIImageView!
    @IBOutlet weak var imgView: UIImageView!
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
        Bundle.main.loadNibNamed("SectionView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.middleTxtImgView.isHidden = true
        self.middleImgView.isHidden = true
        
    }
}
