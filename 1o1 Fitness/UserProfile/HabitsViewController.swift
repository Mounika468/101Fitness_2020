//
//  HabitsViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 06/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class HabitsViewController: UIViewController {
    
    @IBOutlet weak var averageBtn: UIButton!
    @IBOutlet weak var badBtn: UIButton!
    @IBOutlet weak var goodBtn: UIButton!
    @IBOutlet weak var hr10Btn: UIButton!
    @IBOutlet weak var hr8Btn: UIButton!
    @IBOutlet weak var hr5Btn: UIButton!
    @IBOutlet weak var hr1Btn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var bottomView: ProfileBottomView!
    @IBOutlet weak var headerView: ProfileHeaderView!
    var sleepQuality = ""
    var sleepDuration = ""
    var alcoholChoice = ""
       var smokeChoice = ""
    var NoSelected : Bool  = true
   // var habitsDict : [String :String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.averageBtn.layer.cornerRadius = 10
        self.averageBtn.layer.borderWidth = 1
        self.averageBtn.layer.borderColor = AppColours.appGreen.cgColor
        self.badBtn.layer.cornerRadius = 10
        self.badBtn.layer.borderWidth = 1
        self.badBtn.layer.borderColor = AppColours.appGreen.cgColor
        self.goodBtn.layer.cornerRadius = 10
        self.goodBtn.layer.borderWidth = 1
        self.goodBtn.layer.borderColor = AppColours.appGreen.cgColor
        self.hr10Btn.layer.cornerRadius = 10
        self.hr10Btn.layer.borderWidth = 1
        self.hr10Btn.layer.borderColor = AppColours.appGreen.cgColor
        self.hr8Btn.layer.cornerRadius = 10
        self.hr8Btn.layer.borderWidth = 1
        self.hr8Btn.layer.borderColor = AppColours.appGreen.cgColor
        self.hr5Btn.layer.cornerRadius = 10
        self.hr5Btn.layer.borderWidth = 1
        self.hr5Btn.layer.borderColor = AppColours.appGreen.cgColor
        self.hr1Btn.layer.cornerRadius = 10
        self.hr1Btn.layer.borderWidth = 1
        self.hr1Btn.layer.borderColor = AppColours.appGreen.cgColor
        self.noBtn.layer.cornerRadius = 10
        self.noBtn.layer.borderWidth = 1
        self.noBtn.layer.borderColor = AppColours.appGreen.cgColor
        self.yesBtn.layer.cornerRadius = 10
        self.yesBtn.layer.borderWidth = 1
        self.yesBtn.layer.borderColor = AppColours.appGreen.cgColor
        headerView.countLbl.text = "10 / 11"
        bottomView.bottonDelegate = self
    }
    @IBAction func averageBtnTapped(_ sender: Any) {
        if self.averageBtn.isSelected {
            self.averageBtn.isSelected = false
            self.averageBtn.backgroundColor = UIColor.clear
            self.averageBtn.setTitleColor(UIColor.white, for: .normal)
            self.sleepQuality = ""
        }else {
            self.averageBtn.isSelected = true
            self.averageBtn.backgroundColor = AppColours.appGreen
            self.averageBtn.setTitleColor(UIColor.black, for: .normal)
            self.badBtn.isSelected = false
            self.badBtn.backgroundColor = UIColor.clear
            self.badBtn.setTitleColor(UIColor.white, for: .normal)
            self.goodBtn.isSelected = false
            self.goodBtn.backgroundColor = UIColor.clear
            self.goodBtn.setTitleColor(UIColor.white, for: .normal)
             self.sleepQuality = "average"
        }
    }
    @IBAction func badBtnTapped(_ sender: Any) {
        if self.badBtn.isSelected {
            self.badBtn.isSelected = false
            self.badBtn.backgroundColor = UIColor.clear
            self.badBtn.setTitleColor(UIColor.white, for: .normal)
            self.sleepQuality = ""
        }else {
            self.badBtn.isSelected = true
            self.badBtn.backgroundColor = AppColours.appGreen
            self.badBtn.setTitleColor(UIColor.black, for: .normal)
            self.averageBtn.isSelected = false
            self.averageBtn.backgroundColor = UIColor.clear
            self.averageBtn.setTitleColor(UIColor.white, for: .normal)
            self.goodBtn.isSelected = false
                       self.goodBtn.backgroundColor = UIColor.clear
                       self.goodBtn.setTitleColor(UIColor.white, for: .normal)
            self.sleepQuality = "bad"
        }
    }
    @IBAction func goodBtnTapped(_ sender: Any) {
        if self.goodBtn.isSelected {
            self.goodBtn.isSelected = false
            self.goodBtn.backgroundColor = UIColor.clear
            self.goodBtn.setTitleColor(UIColor.white, for: .normal)
            self.sleepQuality = ""
        }else {
            self.goodBtn.isSelected = true
            self.goodBtn.backgroundColor = AppColours.appGreen
            self.goodBtn.setTitleColor(UIColor.black, for: .normal)
          self.averageBtn.isSelected = false
            self.averageBtn.backgroundColor = UIColor.clear
            self.averageBtn.setTitleColor(UIColor.white, for: .normal)
            self.badBtn.isSelected = false
            self.badBtn.backgroundColor = UIColor.clear
            self.badBtn.setTitleColor(UIColor.white, for: .normal)
            self.sleepQuality = "good"
        }
    }
    @IBAction func hr10BtnTapped(_ sender: Any) {
        if self.hr10Btn.isSelected {
            self.hr10Btn.isSelected = false
            self.hr10Btn.backgroundColor = UIColor.clear
            self.hr10Btn.setTitleColor(UIColor.white, for: .normal)
            self.sleepDuration = ""
        }else {
            self.sleepDuration = "10+ hours"
            self.hr10Btn.isSelected = true
            self.hr10Btn.backgroundColor = AppColours.appGreen
            self.hr10Btn.setTitleColor(UIColor.black, for: .normal)
            self.hr8Btn.isSelected = false
            self.hr8Btn.backgroundColor = UIColor.clear
            self.hr8Btn.setTitleColor(UIColor.white, for: .normal)
            self.hr5Btn.isSelected = false
            self.hr5Btn.backgroundColor = UIColor.clear
            self.hr5Btn.setTitleColor(UIColor.white, for: .normal)
            self.hr1Btn.isSelected = false
                       self.hr1Btn.backgroundColor = UIColor.clear
                       self.hr1Btn.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    @IBAction func hr8BtnTapped(_ sender: Any) {
        if self.hr8Btn.isSelected {
            self.hr8Btn.isSelected = false
            self.hr8Btn.backgroundColor = UIColor.clear
            self.hr8Btn.setTitleColor(UIColor.white, for: .normal)
            self.sleepDuration = ""
        }else {
            self.sleepDuration = "8hrs to 10hrs"
            self.hr8Btn.isSelected = true
            self.hr8Btn.backgroundColor = AppColours.appGreen
            self.hr8Btn.setTitleColor(UIColor.black, for: .normal)
            self.hr5Btn.isSelected = false
            self.hr5Btn.backgroundColor = UIColor.clear
            self.hr5Btn.setTitleColor(UIColor.white, for: .normal)
            self.hr1Btn.isSelected = false
                       self.hr1Btn.backgroundColor = UIColor.clear
                       self.hr1Btn.setTitleColor(UIColor.white, for: .normal)
            self.hr10Btn.isSelected = false
            self.hr10Btn.backgroundColor = UIColor.clear
            self.hr10Btn.setTitleColor(UIColor.white, for: .normal)
        }
    }
    @IBAction func hr5BtnTapped(_ sender: Any) {
        if self.hr5Btn.isSelected {
            self.hr5Btn.isSelected = false
            self.hr5Btn.backgroundColor = UIColor.clear
            self.hr5Btn.setTitleColor(UIColor.white, for: .normal)
            self.sleepDuration = ""
        }else {
            self.sleepDuration = "4hrs to 8hrs"
            self.hr5Btn.isSelected = true
            self.hr5Btn.backgroundColor = AppColours.appGreen
            self.hr5Btn.setTitleColor(UIColor.black, for: .normal)
           self.hr8Btn.isSelected = false
            self.hr8Btn.backgroundColor = UIColor.clear
            self.hr8Btn.setTitleColor(UIColor.white, for: .normal)
                     self.hr1Btn.isSelected = false
                                self.hr1Btn.backgroundColor = UIColor.clear
                                self.hr1Btn.setTitleColor(UIColor.white, for: .normal)
                     self.hr10Btn.isSelected = false
                     self.hr10Btn.backgroundColor = UIColor.clear
                     self.hr10Btn.setTitleColor(UIColor.white, for: .normal)
        }
    }
    @IBAction func hr1BtnTapped(_ sender: Any) {
        if self.hr1Btn.isSelected {
            self.hr1Btn.isSelected = false
            self.hr1Btn.backgroundColor = UIColor.clear
            self.hr1Btn.setTitleColor(UIColor.white, for: .normal)
            self.sleepDuration = ""
        }else {
            self.sleepDuration = "1hr to 4hrs"
            self.hr1Btn.isSelected = true
            self.hr1Btn.backgroundColor = AppColours.appGreen
            self.hr1Btn.setTitleColor(UIColor.black, for: .normal)
            self.hr5Btn.isSelected = false
            self.hr5Btn.backgroundColor = UIColor.clear
            self.hr5Btn.setTitleColor(UIColor.white, for: .normal)
                      self.hr8Btn.isSelected = false
                       self.hr8Btn.backgroundColor = UIColor.clear
                       self.hr8Btn.setTitleColor(UIColor.white, for: .normal)
            self.hr10Btn.isSelected = false
                                self.hr10Btn.backgroundColor = UIColor.clear
                                self.hr10Btn.setTitleColor(UIColor.white, for: .normal)
        }
    }
    @IBAction func yesBtnTapped(_ sender: Any) {
        
        if self.yesBtn.isSelected {
            self.yesBtn.isSelected = false
            self.yesBtn.backgroundColor = UIColor.clear
            self.yesBtn.setTitleColor(UIColor.white, for: .normal)
            self.NoSelected = true
        }else {
            self.yesBtn.isSelected = true
            self.yesBtn.backgroundColor = AppColours.appGreen
            self.yesBtn.setTitleColor(UIColor.black, for: .normal)
            self.noBtn.isSelected = false
            self.noBtn.backgroundColor = UIColor.clear
            self.noBtn.setTitleColor(UIColor.white, for: .normal)
            self.NoSelected = false
            self.showHabitsChoice()
        }
    }
    @IBAction func noBtnTapped(_ sender: Any) {
        if self.noBtn.isSelected {
            self.noBtn.isSelected = false
            self.noBtn.backgroundColor = UIColor.clear
            self.noBtn.setTitleColor(UIColor.white, for: .normal)
            self.NoSelected = false
        }else {
            self.noBtn.isSelected = true
            self.NoSelected = true
            self.noBtn.backgroundColor = AppColours.appGreen
            self.noBtn.setTitleColor(UIColor.black, for: .normal)
            self.yesBtn.isSelected = false
            self.yesBtn.backgroundColor = UIColor.clear
            self.yesBtn.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    func showHabitsChoice() {
        let storyboard = UIStoryboard(name: "HabitChoiceVC", bundle: nil)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "habitChoiceVC") as! HabitChoiceViewController
        alertVC.habitsDelegate = self
        alertVC.modalPresentationStyle = .custom
        present(alertVC, animated: false, completion: nil)
    }
    
}

extension HabitsViewController : BottomViewDelegate {
    func leftBtnTapped() {
        self.navigationController?.popViewController(animated: true)
        
    }
    func rightBtnTapped() {
        if self.sleepDuration.count > 0 && self.sleepQuality.count > 0 {
            TraineeInfo.details.sleep_quality = self.sleepQuality
                 TraineeInfo.details.sleep_duration = self.sleepDuration
            var selection = "no"
            if self.yesBtn.isSelected == true {
                selection = "yes"
            }
                TraineeInfo.details.smoke_alcohol_consumption = ["status":selection,"alcohol_consumption":self.alcoholChoice,"smoking_consumption":self.smokeChoice]
            let storyboard = UIStoryboard(name: "MedicalVC", bundle: nil)
                   let controller = storyboard.instantiateViewController(withIdentifier: "medicalVC")
                   self.navigationController?.pushViewController(controller, animated: true)
            
        }else {
            presentAlertWithTitle(title: "", message: "Please select your preferences", options: "OK") { (option) in
                                        }
               }
    }
}
extension HabitsViewController: HabitsDelegate {
    func smokeSelected(smoke: String) {
        self.smokeChoice = smoke
    }
    func alcoholSelected(alcohol: String) {
        self.alcoholChoice = alcohol
    }
}
//"smoke_alcohol_consumption": {
//   "status": "test",
//   "alcohol_consumption": "test",
//   "smoking_consumption": "test"
// }
//"sleep_duration": "5 hours",
//"sleep_quality": "good",
