//
//  StartViewController.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 10/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var startBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      //  self.startBtn.backgroundColor = UIColor(red: 152/255, green: 255/255, blue: 84/255, alpha: 1.0)
               self.startBtn.layer.cornerRadius = 8.0
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    @IBAction func startBtnTapped(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "PersonalInfoVC", bundle: nil)
//           let controller = storyboard.instantiateViewController(withIdentifier: "personalInfoVC") as! PersonalInfoVC
//        self.navigationController?.pushViewController(controller, animated: true)
        let storyboard = UIStoryboard(name: "GenderVC", bundle: nil)
                      let controller = storyboard.instantiateViewController(withIdentifier: "genderVC") as! GenderViewController
                   self.navigationController?.pushViewController(controller, animated: true)
    }
    

}
