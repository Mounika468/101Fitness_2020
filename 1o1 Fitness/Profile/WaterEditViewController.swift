//
//  WaterEditViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 09/12/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class WaterEditViewController: UIViewController {

    @IBOutlet weak var toBtn: UIButton!
    @IBOutlet weak var fromBtn: UIButton!
    @IBOutlet weak var headerLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.headerLbl.textColor = AppColours.textGreen
        self.toBtn.setTitleColor(AppColours.textGreen, for: .normal)
        self.fromBtn.setTitleColor(AppColours.textGreen, for: .normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func toBtnTapped(_ sender: Any) {
    }
    
    @IBAction func fromBtnTapped(_ sender: Any) {
    }
    @IBAction func waterRemSwitchChanged(_ sender: Any) {
    }
    @IBAction func mainSwitchValueChanged(_ sender: Any) {
    }
    @IBAction func saveBtnTapped(_ sender: Any) {
    }
}
