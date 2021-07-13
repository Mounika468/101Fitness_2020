//
//  FreeYogaViewController.swift
//  1o1 Fitness
//
//  Created by Mounika Reddy on 19/05/21.
//  Copyright © 2021 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class FreeYogaViewController: UIViewController {

    @IBOutlet weak var mySessionBtn: UIButton!
    @IBOutlet weak var freeSessionBtn: UIButton!
    @IBOutlet weak var scheduleCallView: ScheduleCallView!
    @IBOutlet weak var mySessionLbl: UIButton!
    @IBOutlet weak var freeSessionLbl: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        let xBarHeight = navigationController?.navigationBar.frame.maxY
        let navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight!))
               navigationView.titleLbl.text = "Free Access"
        navigationView.backgroundColor = AppColours.topBarGreen
               navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
               self.view.addSubview(navigationView)
        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
        self.freeSessionBtnTapped(self.freeSessionBtn as Any)
    }
    @objc func backBtnTapped(sender : UIButton){
           self.navigationController?.popViewController(animated: true)
          }
    @IBAction func freeSessionBtnTapped(_ sender: Any) {
        if freeSessionBtn.isSelected {
            freeSessionBtn.isSelected = false
            mySessionLbl.isHidden = false
            freeSessionLbl.isHidden = true
        }else {
            freeSessionBtn.isSelected = true
            freeSessionLbl.isHidden = false
            mySessionLbl.isHidden = true
        }
    }
    
    @IBAction func mySessionBtnTapped(_ sender: Any) {
        if mySessionBtn.isSelected {
            mySessionBtn.isSelected = false
            mySessionLbl.isHidden = true
            freeSessionLbl.isHidden = false
        }else {
            mySessionBtn.isSelected = true
            freeSessionLbl.isHidden = true
            mySessionLbl.isHidden = false
        }
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
