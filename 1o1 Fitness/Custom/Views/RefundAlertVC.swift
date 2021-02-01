//
//  RefundAlertVC.swift
//  1o1 Fitness
//
//  Created by Mounika Reddy on 27/01/21.
//  Copyright © 2021 Mounika.x.muduganti. All rights reserved.
//

import UIKit

protocol RefundAlertViewDelegate: class {
    func yesButtonTapped()
    func noButtonTapped()
}


class RefundAlertVC: UIViewController {

    @IBOutlet weak var alertView: CardView!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    var delegate: RefundAlertViewDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.noBtn.layer.borderColor = AppColours.textGreen.cgColor
        self.noBtn.layer.borderWidth = 1.0
        self.noBtn.layer.cornerRadius = 8
        self.yesBtn.layer.borderColor = UIColor.systemRed.cgColor
        self.yesBtn.layer.borderWidth = 1.0
        self.yesBtn.layer.cornerRadius = 8
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
       
    }
    
    func setupView() {
       // alertView.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
       
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
   

    @IBAction func noBtnTapped(_ sender: Any) {
        delegate?.noButtonTapped()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func yesBtnTapped(_ sender: Any) {
        delegate?.yesButtonTapped()
        self.dismiss(animated: true, completion: nil)
    }
}
