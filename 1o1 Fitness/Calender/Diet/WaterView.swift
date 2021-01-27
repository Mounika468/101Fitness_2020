//
//  WaterView.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 19/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class WaterView: UIView {

    @IBOutlet weak var glass3Btn: UIButton!
    @IBOutlet weak var glass2Btn: UIButton!
    @IBOutlet weak var glass1Btn: UIButton!
    @IBOutlet weak var glassView: UIView!
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var lastUpdateLbl: UILabel!
    @IBOutlet weak var glassImgView: UIImageView!
    @IBOutlet weak var jugImgView: UIImageView!
    @IBOutlet weak var qtyLbl: UILabel!
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
        Bundle.main.loadNibNamed("WaterView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        glassImgView.isUserInteractionEnabled = true
        glassImgView.addGestureRecognizer(tapGestureRecognizer)
       
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView

        // Your action
        
        self.glassView.isHidden = false
    }
    @IBAction func glass1Tapped(_ sender: Any) {
        
    }
    @IBAction func glass2Tapped(_ sender: Any) {
        
    }
    @IBAction func glass3Tapped(_ sender: Any) {
        
    }
}
