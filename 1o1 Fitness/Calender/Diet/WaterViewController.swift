//
//  WaterViewController.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 27/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class WaterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64))
               navigationView.titleLbl.text = "Calender"
               navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
               self.view.addSubview(navigationView)
        
    }
    
    @objc func backBtnTapped(sender : UIButton){
     self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
