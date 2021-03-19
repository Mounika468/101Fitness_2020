//
//  SexualActivityVC.swift
//  1o1 Fitness
//
//  Created by Mounika Reddy on 17/03/21.
//  Copyright © 2021 Mounika.x.muduganti. All rights reserved.
//

import UIKit
enum SexualActivitySelection {
     case aEveryday
     case a3times
     case aWeekends
     case aOccasional
     case aNever
     
   
}
class SexualActivityVC: UIViewController {

    @IBOutlet weak var neverBtn: UIButton!
    @IBOutlet weak var occasionalBtn: UIButton!
    @IBOutlet weak var weekendsBtn: UIButton!
    @IBOutlet weak var weekTimesBtn: UIButton!
    @IBOutlet weak var everyDayBtn: UIButton!
    @IBOutlet weak var headerView: ProfileHeaderView!
    @IBOutlet weak var bottomView: ProfileBottomView!
    var delegate : SexualActivityVC?
    var sActivityChoice = ""
    var navigationType : NavigationType = .profileNormal
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.occasionalBtn.layer.cornerRadius = 10
        self.occasionalBtn.layer.borderWidth = 1
        self.occasionalBtn.layer.borderColor = AppColours.appGreen.cgColor
        self.weekendsBtn.layer.cornerRadius = 10
        self.weekendsBtn.layer.borderWidth = 1
        self.weekendsBtn.layer.borderColor = AppColours.appGreen.cgColor
        self.weekTimesBtn.layer.cornerRadius = 10
        self.weekTimesBtn.layer.borderWidth = 1
        self.weekTimesBtn.layer.borderColor = AppColours.appGreen.cgColor
        self.everyDayBtn.layer.cornerRadius = 10
        self.everyDayBtn.layer.borderWidth = 1
        self.everyDayBtn.layer.borderColor = AppColours.appGreen.cgColor
        bottomView.bottonDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.navigationType == .profileMenu {
            self.setUpSexualActivity()
        }
    }
    func setUpSexualActivity() {
        
        switch self.sActivityChoice.lowercased() {
        case "everyday":
            self.sActivityChoice = "everyday"
            self.everyDayBtn.isSelected = true
            self.everyDayBtn.backgroundColor = AppColours.appGreen
            self.everyDayBtn.setTitleColor(UIColor.black, for: .normal)
            self.weekTimesBtn.isSelected = false
            self.weekTimesBtn.backgroundColor = UIColor.clear
            self.weekTimesBtn.setTitleColor(UIColor.white, for: .normal)
            self.weekendsBtn.isSelected = false
            self.weekendsBtn.backgroundColor = UIColor.clear
            self.weekendsBtn.setTitleColor(UIColor.white, for: .normal)
            self.occasionalBtn.isSelected = false
            self.occasionalBtn.backgroundColor = UIColor.clear
            self.occasionalBtn.setTitleColor(UIColor.white, for: .normal)
            self.sActivityChoice = "everyday"
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        case "3-5 times a week":
            self.sActivityChoice = "3-5 times a week"
            self.weekTimesBtn.isSelected = true
            self.weekTimesBtn.backgroundColor = AppColours.appGreen
            self.weekTimesBtn.setTitleColor(UIColor.black, for: .normal)
            self.everyDayBtn.isSelected = false
            self.everyDayBtn.backgroundColor = UIColor.clear
            self.everyDayBtn.setTitleColor(UIColor.white, for: .normal)
            self.weekendsBtn.isSelected = false
            self.weekendsBtn.backgroundColor = UIColor.clear
            self.weekendsBtn.setTitleColor(UIColor.white, for: .normal)
            self.occasionalBtn.isSelected = false
            self.occasionalBtn.backgroundColor = UIColor.clear
            self.occasionalBtn.setTitleColor(UIColor.white, for: .normal)
            self.sActivityChoice = "3-5 times a week"
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        case "weekends":
            self.sActivityChoice = "weekends"
            self.weekendsBtn.isSelected = true
            self.weekendsBtn.backgroundColor = AppColours.appGreen
            self.weekendsBtn.setTitleColor(UIColor.black, for: .normal)
            self.everyDayBtn.isSelected = false
            self.everyDayBtn.backgroundColor = UIColor.clear
            self.everyDayBtn.setTitleColor(UIColor.white, for: .normal)
            self.occasionalBtn.isSelected = false
            self.occasionalBtn.backgroundColor = UIColor.clear
            self.occasionalBtn.setTitleColor(UIColor.white, for: .normal)
            self.weekTimesBtn.isSelected = false
            self.weekTimesBtn.backgroundColor = UIColor.clear
            self.weekTimesBtn.setTitleColor(UIColor.white, for: .normal)
            self.sActivityChoice = "weekends"
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        case "occasionally":
            self.sActivityChoice = "occasionally"
            self.occasionalBtn.isSelected = true
            self.occasionalBtn.backgroundColor = AppColours.appGreen
            self.occasionalBtn.setTitleColor(UIColor.black, for: .normal)
            self.everyDayBtn.isSelected = false
            self.everyDayBtn.backgroundColor = UIColor.clear
            self.everyDayBtn.setTitleColor(UIColor.white, for: .normal)
            self.weekendsBtn.isSelected = false
            self.weekendsBtn.backgroundColor = UIColor.clear
            self.weekendsBtn.setTitleColor(UIColor.white, for: .normal)
            self.weekTimesBtn.isSelected = false
            self.weekTimesBtn.backgroundColor = UIColor.clear
            self.weekTimesBtn.setTitleColor(UIColor.white, for: .normal)
            self.sActivityChoice = "occasionally"
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        case "":
            self.sActivityChoice = ""
                self.neverBtn.isSelected = true
                self.neverBtn.setImage(UIImage(named: "scheck"), for: .normal)
                 self.sActivityChoice = ""
                 self.occasionalBtn.isSelected = false
                           self.occasionalBtn.backgroundColor = UIColor.clear
                           self.occasionalBtn.setTitleColor(UIColor.white, for: .normal)
                self.everyDayBtn.isSelected = false
                self.everyDayBtn.backgroundColor = UIColor.clear
                self.everyDayBtn.setTitleColor(UIColor.white, for: .normal)
                self.weekTimesBtn.isSelected = false
                self.weekTimesBtn.backgroundColor = UIColor.clear
                self.weekTimesBtn.setTitleColor(UIColor.white, for: .normal)
                self.weekendsBtn.isSelected = false
                           self.weekendsBtn.backgroundColor = UIColor.clear
                           self.weekendsBtn.setTitleColor(UIColor.white, for: .normal)
        default:
            print("")
        }
       
    }
    @IBAction func weekdayBtnTapped(_ sender: Any) {
        if self.weekTimesBtn.isSelected {
            self.weekTimesBtn.isSelected = false
            self.weekTimesBtn.backgroundColor = UIColor.clear
            self.weekTimesBtn.setTitleColor(UIColor.white, for: .normal)
            self.sActivityChoice = ""
        }else {
            self.weekTimesBtn.isSelected = true
            self.weekTimesBtn.backgroundColor = AppColours.appGreen
            self.weekTimesBtn.setTitleColor(UIColor.black, for: .normal)
            self.everyDayBtn.isSelected = false
            self.everyDayBtn.backgroundColor = UIColor.clear
            self.everyDayBtn.setTitleColor(UIColor.white, for: .normal)
            self.weekendsBtn.isSelected = false
            self.weekendsBtn.backgroundColor = UIColor.clear
            self.weekendsBtn.setTitleColor(UIColor.white, for: .normal)
            self.occasionalBtn.isSelected = false
            self.occasionalBtn.backgroundColor = UIColor.clear
            self.occasionalBtn.setTitleColor(UIColor.white, for: .normal)
            self.sActivityChoice = "3-5 times a week"
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        }
    }
    
    @IBAction func neverBtnTapped(_ sender: Any) {
        if self.neverBtn.isSelected {
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
            // self.sActivityChoice = ""
        }else {
            self.neverBtn.isSelected = true
            self.neverBtn.setImage(UIImage(named: "scheck"), for: .normal)
             self.sActivityChoice = "never"
             self.occasionalBtn.isSelected = false
                       self.occasionalBtn.backgroundColor = UIColor.clear
                       self.occasionalBtn.setTitleColor(UIColor.white, for: .normal)
            self.everyDayBtn.isSelected = false
            self.everyDayBtn.backgroundColor = UIColor.clear
            self.everyDayBtn.setTitleColor(UIColor.white, for: .normal)
            self.weekTimesBtn.isSelected = false
            self.weekTimesBtn.backgroundColor = UIColor.clear
            self.weekTimesBtn.setTitleColor(UIColor.white, for: .normal)
            self.weekendsBtn.isSelected = false
                       self.weekendsBtn.backgroundColor = UIColor.clear
                       self.weekendsBtn.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    @IBAction func everyDayBtnTapped(_ sender: Any) {
        if self.everyDayBtn.isSelected {
            self.everyDayBtn.isSelected = false
            self.everyDayBtn.backgroundColor = UIColor.clear
            self.everyDayBtn.setTitleColor(UIColor.white, for: .normal)
            self.sActivityChoice = ""
        }else {
            self.everyDayBtn.isSelected = true
            self.everyDayBtn.backgroundColor = AppColours.appGreen
            self.everyDayBtn.setTitleColor(UIColor.black, for: .normal)
            self.weekTimesBtn.isSelected = false
            self.weekTimesBtn.backgroundColor = UIColor.clear
            self.weekTimesBtn.setTitleColor(UIColor.white, for: .normal)
            self.weekendsBtn.isSelected = false
            self.weekendsBtn.backgroundColor = UIColor.clear
            self.weekendsBtn.setTitleColor(UIColor.white, for: .normal)
            self.occasionalBtn.isSelected = false
            self.occasionalBtn.backgroundColor = UIColor.clear
            self.occasionalBtn.setTitleColor(UIColor.white, for: .normal)
            self.sActivityChoice = "everyday"
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        }
    }
    
    @IBAction func weekendsBtnTapped(_ sender: Any) {
        
        if self.weekendsBtn.isSelected {
            self.weekendsBtn.isSelected = false
            self.weekendsBtn.backgroundColor = UIColor.clear
            self.weekendsBtn.setTitleColor(UIColor.white, for: .normal)
            self.sActivityChoice = ""
        }else {
            self.weekendsBtn.isSelected = true
            self.weekendsBtn.backgroundColor = AppColours.appGreen
            self.weekendsBtn.setTitleColor(UIColor.black, for: .normal)
            self.everyDayBtn.isSelected = false
            self.everyDayBtn.backgroundColor = UIColor.clear
            self.everyDayBtn.setTitleColor(UIColor.white, for: .normal)
            self.occasionalBtn.isSelected = false
            self.occasionalBtn.backgroundColor = UIColor.clear
            self.occasionalBtn.setTitleColor(UIColor.white, for: .normal)
            self.weekTimesBtn.isSelected = false
            self.weekTimesBtn.backgroundColor = UIColor.clear
            self.weekTimesBtn.setTitleColor(UIColor.white, for: .normal)
            self.sActivityChoice = "weekends"
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        }
    }
    @IBAction func occasionalBtnTapped(_ sender: Any) {
        if self.occasionalBtn.isSelected {
            self.occasionalBtn.isSelected = false
            self.occasionalBtn.backgroundColor = UIColor.clear
            self.occasionalBtn.setTitleColor(UIColor.white, for: .normal)
            self.sActivityChoice = ""
        }else {
            self.occasionalBtn.isSelected = true
            self.occasionalBtn.backgroundColor = AppColours.appGreen
            self.occasionalBtn.setTitleColor(UIColor.black, for: .normal)
            self.everyDayBtn.isSelected = false
            self.everyDayBtn.backgroundColor = UIColor.clear
            self.everyDayBtn.setTitleColor(UIColor.white, for: .normal)
            self.weekendsBtn.isSelected = false
            self.weekendsBtn.backgroundColor = UIColor.clear
            self.weekendsBtn.setTitleColor(UIColor.white, for: .normal)
            self.weekTimesBtn.isSelected = false
            self.weekTimesBtn.backgroundColor = UIColor.clear
            self.weekTimesBtn.setTitleColor(UIColor.white, for: .normal)
            self.sActivityChoice = "occasionally"
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        }
    }
}
extension SexualActivityVC : BottomViewDelegate {
    func leftBtnTapped() {
        self.navigationController?.popViewController(animated: true)
        
    }
    func rightBtnTapped() {
        if self.sActivityChoice.count != 0 {
            TraineeInfo.details.sexualActivity = self.sActivityChoice
            let storyboard = UIStoryboard(name: "MedicalVC", bundle: nil)
                   let controller = storyboard.instantiateViewController(withIdentifier: "medicalVC")
                   self.navigationController?.pushViewController(controller, animated: true)
        } else {
            presentAlertWithTitle(title: "", message: "Please select your preferences", options: "OK") { (option) in
                                        }
                       }
    }
}
