//
//  HabitChoiceViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 06/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
protocol HabitsDelegate {
    func alcoholSelected(alcohol:String)
    func smokeSelected(smoke:String)
}
enum HabitsSelection {
     case aEveryday
     case a3times
     case aWeekends
     case aOccasional
     case aNever
     case sEveryday
    case s3times
    case sWeekends
    case sOccasional
    case sNever
   
}
class HabitChoiceViewController: UIViewController {
    
    @IBOutlet weak var bgView: CardView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var never2Btn: UIButton!
    @IBOutlet weak var occsional2Btn: UIButton!
    @IBOutlet weak var weekends2Btn: UIButton!
    @IBOutlet weak var neverBtn: UIButton!
    @IBOutlet weak var occasionalBtn: UIButton!
    @IBOutlet weak var weekendsBtn: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var everyDay1Btn: UIButton!
    @IBOutlet weak var everyday2Btn: UIButton!
    @IBOutlet weak var btn32: UIButton!
    var habitsDelegate : HabitsDelegate?
    var alcoholChoice = ""
    var smokeChoice = ""
    var navigationType : NavigationType = .profileNormal
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMeatView()
        // Do any additional setup after loading the view.
         self.okBtn.setTitleColor(AppColours.appGreen, for: .normal)
        self.everyDay1Btn.layer.cornerRadius = 10
        self.everyDay1Btn.layer.borderWidth = 1
        self.everyDay1Btn.layer.borderColor = AppColours.appGreen.cgColor
        self.everyday2Btn.layer.cornerRadius = 10
        self.everyday2Btn.layer.borderWidth = 1
        self.everyday2Btn.layer.borderColor = AppColours.appGreen.cgColor
        self.btn3.layer.cornerRadius = 10
        self.btn3.layer.borderWidth = 1
        self.btn3.layer.borderColor = AppColours.appGreen.cgColor
        self.btn32.layer.cornerRadius = 10
        self.btn32.layer.borderWidth = 1
        self.btn32.layer.borderColor = AppColours.appGreen.cgColor
        self.weekends2Btn.layer.cornerRadius = 10
        self.weekends2Btn.layer.borderWidth = 1
        self.weekends2Btn.layer.borderColor = AppColours.appGreen.cgColor
        self.weekendsBtn.layer.cornerRadius = 10
        self.weekendsBtn.layer.borderWidth = 1
        self.weekendsBtn.layer.borderColor = AppColours.appGreen.cgColor
        self.occsional2Btn.layer.cornerRadius = 10
        self.occsional2Btn.layer.borderWidth = 1
        self.occsional2Btn.layer.borderColor = AppColours.appGreen.cgColor
        self.occasionalBtn.layer.cornerRadius = 10
        self.occasionalBtn.layer.borderWidth = 1
        self.occasionalBtn.layer.borderColor = AppColours.appGreen.cgColor
        bgView.layer.cornerRadius = 20
        bgView.layer.borderWidth = 0.5
        bgView.layer.borderColor = UIColor.lightGray.cgColor
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 6, options: .curveEaseIn, animations: {
            self.bgView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
            
        }, completion: nil)
        
    }
    
    func setUpMeatView() {
        view.addSubview(bgView)
        bgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bgView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height).isActive = true
        bgView.widthAnchor.constraint(equalToConstant: view.bounds.width*0.8).isActive = true
        if self.navigationType == .profileMenu {
            self.setUpHabits()
        }
        
    }
    
    @IBAction func okBtnTapped(_ sender: Any) {
        if  self.smokeChoice.count != 0 || self.alcoholChoice.count != 0 || (self.neverBtn.isSelected  || self.never2Btn.isSelected) {
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 4, options: .curveEaseIn, animations: {
            self.bgView.transform = CGAffineTransform.identity
            self.view.backgroundColor = UIColor(white: 0, alpha: 0.0)
        }) { (completed) in
           
            self.habitsDelegate?.alcoholSelected(alcohol: self.alcoholChoice)
            self.habitsDelegate?.smokeSelected(smoke: self.smokeChoice)
            self.dismiss(animated: false, completion: nil)
            }
        }
    }
    @IBAction func neverBtnTapped(_ sender: Any) {
        if self.neverBtn.isSelected {
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
            // self.alcoholChoice = ""
        }else {
            self.neverBtn.isSelected = true
            self.neverBtn.setImage(UIImage(named: "scheck"), for: .normal)
            self.never2Btn.isSelected = false
            self.never2Btn.setImage(UIImage(named: "ucheck"), for: .normal)
             self.alcoholChoice = ""
             self.occasionalBtn.isSelected = false
                       self.occasionalBtn.backgroundColor = UIColor.clear
                       self.occasionalBtn.setTitleColor(UIColor.white, for: .normal)
            self.everyDay1Btn.isSelected = false
            self.everyDay1Btn.backgroundColor = UIColor.clear
            self.everyDay1Btn.setTitleColor(UIColor.white, for: .normal)
            self.btn3.isSelected = false
            self.btn3.backgroundColor = UIColor.clear
            self.btn3.setTitleColor(UIColor.white, for: .normal)
            self.weekendsBtn.isSelected = false
                       self.weekendsBtn.backgroundColor = UIColor.clear
                       self.weekendsBtn.setTitleColor(UIColor.white, for: .normal)
        }
    }
    @IBAction func occasionalBtnTapped(_ sender: Any) {
        if self.occasionalBtn.isSelected {
            self.occasionalBtn.isSelected = false
            self.occasionalBtn.backgroundColor = UIColor.clear
            self.occasionalBtn.setTitleColor(UIColor.white, for: .normal)
            self.alcoholChoice = ""
        }else {
            self.occasionalBtn.isSelected = true
            self.occasionalBtn.backgroundColor = AppColours.appGreen
            self.occasionalBtn.setTitleColor(UIColor.black, for: .normal)
            self.everyDay1Btn.isSelected = false
            self.everyDay1Btn.backgroundColor = UIColor.clear
            self.everyDay1Btn.setTitleColor(UIColor.white, for: .normal)
            self.weekendsBtn.isSelected = false
            self.weekendsBtn.backgroundColor = UIColor.clear
            self.weekendsBtn.setTitleColor(UIColor.white, for: .normal)
            self.btn3.isSelected = false
            self.btn3.backgroundColor = UIColor.clear
            self.btn3.setTitleColor(UIColor.white, for: .normal)
            self.alcoholChoice = "occasionally"
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        }
    }
    @IBAction func weekendsBtnTapped(_ sender: Any) {
        
        if self.weekendsBtn.isSelected {
            self.weekendsBtn.isSelected = false
            self.weekendsBtn.backgroundColor = UIColor.clear
            self.weekendsBtn.setTitleColor(UIColor.white, for: .normal)
            self.alcoholChoice = ""
        }else {
            self.weekendsBtn.isSelected = true
            self.weekendsBtn.backgroundColor = AppColours.appGreen
            self.weekendsBtn.setTitleColor(UIColor.black, for: .normal)
            self.everyDay1Btn.isSelected = false
            self.everyDay1Btn.backgroundColor = UIColor.clear
            self.everyDay1Btn.setTitleColor(UIColor.white, for: .normal)
            self.occasionalBtn.isSelected = false
            self.occasionalBtn.backgroundColor = UIColor.clear
            self.occasionalBtn.setTitleColor(UIColor.white, for: .normal)
            self.btn3.isSelected = false
            self.btn3.backgroundColor = UIColor.clear
            self.btn3.setTitleColor(UIColor.white, for: .normal)
            self.alcoholChoice = "weekends"
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        }
    }
    @IBAction func btn3Tapped(_ sender: Any) {
        if self.btn3.isSelected {
            self.btn3.isSelected = false
            self.btn3.backgroundColor = UIColor.clear
            self.btn3.setTitleColor(UIColor.white, for: .normal)
            self.alcoholChoice = ""
        }else {
            self.btn3.isSelected = true
            self.btn3.backgroundColor = AppColours.appGreen
            self.btn3.setTitleColor(UIColor.black, for: .normal)
            self.everyDay1Btn.isSelected = false
            self.everyDay1Btn.backgroundColor = UIColor.clear
            self.everyDay1Btn.setTitleColor(UIColor.white, for: .normal)
            self.weekendsBtn.isSelected = false
            self.weekendsBtn.backgroundColor = UIColor.clear
            self.weekendsBtn.setTitleColor(UIColor.white, for: .normal)
            self.occasionalBtn.isSelected = false
            self.occasionalBtn.backgroundColor = UIColor.clear
            self.occasionalBtn.setTitleColor(UIColor.white, for: .normal)
            self.alcoholChoice = "3-5 times a week"
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        }
    }
    
    @IBAction func everyDayBtnTapped(_ sender: Any) {
        if self.everyDay1Btn.isSelected {
            self.everyDay1Btn.isSelected = false
            self.everyDay1Btn.backgroundColor = UIColor.clear
            self.everyDay1Btn.setTitleColor(UIColor.white, for: .normal)
            self.alcoholChoice = ""
        }else {
            self.everyDay1Btn.isSelected = true
            self.everyDay1Btn.backgroundColor = AppColours.appGreen
            self.everyDay1Btn.setTitleColor(UIColor.black, for: .normal)
            self.btn3.isSelected = false
            self.btn3.backgroundColor = UIColor.clear
            self.btn3.setTitleColor(UIColor.white, for: .normal)
            self.weekendsBtn.isSelected = false
            self.weekendsBtn.backgroundColor = UIColor.clear
            self.weekendsBtn.setTitleColor(UIColor.white, for: .normal)
            self.occasionalBtn.isSelected = false
            self.occasionalBtn.backgroundColor = UIColor.clear
            self.occasionalBtn.setTitleColor(UIColor.white, for: .normal)
            self.alcoholChoice = "everyday"
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        }
    }
    @IBAction func never2BtnTapped(_ sender: Any) {
        if self.never2Btn.isSelected {
            self.never2Btn.isSelected = false
            self.never2Btn.setImage(UIImage(named: "ucheck"), for: .normal)
           // self.smokeChoice = ""
        }else {
            self.never2Btn.isSelected = true
            self.never2Btn.setImage(UIImage(named: "scheck"), for: .normal)
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
            self.smokeChoice = ""
            self.occsional2Btn.isSelected = false
            self.occsional2Btn.backgroundColor = UIColor.clear
            self.occsional2Btn.setTitleColor(UIColor.white, for: .normal)
            self.everyday2Btn.isSelected = false
            self.everyday2Btn.backgroundColor = UIColor.clear
            self.everyday2Btn.setTitleColor(UIColor.white, for: .normal)
            self.weekends2Btn.isSelected = false
            self.weekends2Btn.backgroundColor = UIColor.clear
            self.weekends2Btn.setTitleColor(UIColor.white, for: .normal)
            self.btn32.isSelected = false
            self.btn32.backgroundColor = UIColor.clear
            self.btn32.setTitleColor(UIColor.white, for: .normal)
        }
    }
    @IBAction func occasional2BtnTapped(_ sender: Any) {
        if self.occsional2Btn.isSelected {
            self.occsional2Btn.isSelected = false
            self.occsional2Btn.backgroundColor = UIColor.clear
            self.occsional2Btn.setTitleColor(UIColor.white, for: .normal)
            self.smokeChoice = ""
        }else {
            self.occsional2Btn.isSelected = true
            self.occsional2Btn.backgroundColor = AppColours.appGreen
            self.occsional2Btn.setTitleColor(UIColor.black, for: .normal)
            self.everyday2Btn.isSelected = false
            self.everyday2Btn.backgroundColor = UIColor.clear
            self.everyday2Btn.setTitleColor(UIColor.white, for: .normal)
            self.weekends2Btn.isSelected = false
            self.weekends2Btn.backgroundColor = UIColor.clear
            self.weekends2Btn.setTitleColor(UIColor.white, for: .normal)
            self.btn32.isSelected = false
            self.btn32.backgroundColor = UIColor.clear
            self.btn32.setTitleColor(UIColor.white, for: .normal)
            self.smokeChoice = "occasionally"
            self.never2Btn.isSelected = false
            self.never2Btn.setImage(UIImage(named: "ucheck"), for: .normal)
        }
    }
    
    @IBAction func btn32Tapped(_ sender: Any) {
        if self.btn32.isSelected {
            self.btn32.isSelected = false
            self.btn32.backgroundColor = UIColor.clear
            self.btn32.setTitleColor(UIColor.white, for: .normal)
            self.smokeChoice = ""
        }else {
            self.btn32.isSelected = true
            self.btn32.backgroundColor = AppColours.appGreen
            self.btn32.setTitleColor(UIColor.black, for: .normal)
            self.everyday2Btn.isSelected = false
            self.everyday2Btn.backgroundColor = UIColor.clear
            self.everyday2Btn.setTitleColor(UIColor.white, for: .normal)
            self.weekends2Btn.isSelected = false
            self.weekends2Btn.backgroundColor = UIColor.clear
            self.weekends2Btn.setTitleColor(UIColor.white, for: .normal)
            self.occsional2Btn.isSelected = false
            self.occsional2Btn.backgroundColor = UIColor.clear
            self.occsional2Btn.setTitleColor(UIColor.white, for: .normal)
            self.smokeChoice = "3-5 times a week"
            self.never2Btn.isSelected = false
            self.never2Btn.setImage(UIImage(named: "ucheck"), for: .normal)
        }
    }
    @IBAction func weekends2BtnTapped(_ sender: Any) {
        if self.weekends2Btn.isSelected {
            self.weekends2Btn.isSelected = false
            self.weekends2Btn.backgroundColor = UIColor.clear
            self.weekends2Btn.setTitleColor(UIColor.white, for: .normal)
            self.smokeChoice = ""
        }else {
            self.weekends2Btn.isSelected = true
            self.weekends2Btn.backgroundColor = AppColours.appGreen
            self.weekends2Btn.setTitleColor(UIColor.black, for: .normal)
            self.everyday2Btn.isSelected = false
            self.everyday2Btn.backgroundColor = UIColor.clear
            self.everyday2Btn.setTitleColor(UIColor.white, for: .normal)
            self.btn32.isSelected = false
            self.btn32.backgroundColor = UIColor.clear
            self.btn32.setTitleColor(UIColor.white, for: .normal)
            self.occsional2Btn.isSelected = false
            self.occsional2Btn.backgroundColor = UIColor.clear
            self.occsional2Btn.setTitleColor(UIColor.white, for: .normal)
            self.smokeChoice = "weekends"
            self.never2Btn.isSelected = false
            self.never2Btn.setImage(UIImage(named: "ucheck"), for: .normal)
        }
    }
    @IBAction func everyDay2BtnTapped(_ sender: Any) {
        if self.everyday2Btn.isSelected {
            self.everyday2Btn.isSelected = false
            self.everyday2Btn.backgroundColor = UIColor.clear
            self.everyday2Btn.setTitleColor(UIColor.white, for: .normal)
            self.smokeChoice = ""
        }else {
            self.everyday2Btn.isSelected = true
            self.everyday2Btn.backgroundColor = AppColours.appGreen
            self.everyday2Btn.setTitleColor(UIColor.black, for: .normal)
            self.btn32.isSelected = false
            self.btn32.backgroundColor = UIColor.clear
            self.btn32.setTitleColor(UIColor.white, for: .normal)
            self.weekends2Btn.isSelected = false
            self.weekends2Btn.backgroundColor = UIColor.clear
            self.weekends2Btn.setTitleColor(UIColor.white, for: .normal)
            self.occsional2Btn.isSelected = false
            self.occsional2Btn.backgroundColor = UIColor.clear
            self.occsional2Btn.setTitleColor(UIColor.white, for: .normal)
            self.smokeChoice = "everyday"
            self.never2Btn.isSelected = false
            self.never2Btn.setImage(UIImage(named: "ucheck"), for: .normal)
        }
    }
    func processHabits(selection: HabitsSelection) {
        
        switch selection {
        case .aEveryday:
            self.alcoholChoice = "everyday"
        case .a3times:
            self.alcoholChoice = "3-5 times a week"
        case .aWeekends:
            self.alcoholChoice = "weekends"
        case .aOccasional:
            self.alcoholChoice = "occasionally"
        case .aNever:
            self.alcoholChoice = ""
        case .sEveryday:
            self.smokeChoice = "everyday"
        case .s3times:
            self.smokeChoice = "3-5 times a week"
        case .sWeekends:
            self.smokeChoice = "weekends"
        case .sOccasional:
            self.smokeChoice = "occasionally"
        case .sNever:
            self.smokeChoice = ""
        default:
            print("")
        }
    }
    
    func setUpHabits() {
        
        switch self.alcoholChoice.lowercased() {
        case "everyday":
            self.alcoholChoice = "everyday"
            self.everyDay1Btn.isSelected = true
            self.everyDay1Btn.backgroundColor = AppColours.appGreen
            self.everyDay1Btn.setTitleColor(UIColor.black, for: .normal)
            self.btn3.isSelected = false
            self.btn3.backgroundColor = UIColor.clear
            self.btn3.setTitleColor(UIColor.white, for: .normal)
            self.weekendsBtn.isSelected = false
            self.weekendsBtn.backgroundColor = UIColor.clear
            self.weekendsBtn.setTitleColor(UIColor.white, for: .normal)
            self.occasionalBtn.isSelected = false
            self.occasionalBtn.backgroundColor = UIColor.clear
            self.occasionalBtn.setTitleColor(UIColor.white, for: .normal)
            self.alcoholChoice = "everyday"
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        case "3-5 times a week":
            self.alcoholChoice = "3-5 times a week"
            self.btn3.isSelected = true
            self.btn3.backgroundColor = AppColours.appGreen
            self.btn3.setTitleColor(UIColor.black, for: .normal)
            self.everyDay1Btn.isSelected = false
            self.everyDay1Btn.backgroundColor = UIColor.clear
            self.everyDay1Btn.setTitleColor(UIColor.white, for: .normal)
            self.weekendsBtn.isSelected = false
            self.weekendsBtn.backgroundColor = UIColor.clear
            self.weekendsBtn.setTitleColor(UIColor.white, for: .normal)
            self.occasionalBtn.isSelected = false
            self.occasionalBtn.backgroundColor = UIColor.clear
            self.occasionalBtn.setTitleColor(UIColor.white, for: .normal)
            self.alcoholChoice = "3-5 times a week"
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        case "weekends":
            self.alcoholChoice = "weekends"
            self.weekendsBtn.isSelected = true
            self.weekendsBtn.backgroundColor = AppColours.appGreen
            self.weekendsBtn.setTitleColor(UIColor.black, for: .normal)
            self.everyDay1Btn.isSelected = false
            self.everyDay1Btn.backgroundColor = UIColor.clear
            self.everyDay1Btn.setTitleColor(UIColor.white, for: .normal)
            self.occasionalBtn.isSelected = false
            self.occasionalBtn.backgroundColor = UIColor.clear
            self.occasionalBtn.setTitleColor(UIColor.white, for: .normal)
            self.btn3.isSelected = false
            self.btn3.backgroundColor = UIColor.clear
            self.btn3.setTitleColor(UIColor.white, for: .normal)
            self.alcoholChoice = "weekends"
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        case "occasionally":
            self.alcoholChoice = "occasionally"
            self.occasionalBtn.isSelected = true
            self.occasionalBtn.backgroundColor = AppColours.appGreen
            self.occasionalBtn.setTitleColor(UIColor.black, for: .normal)
            self.everyDay1Btn.isSelected = false
            self.everyDay1Btn.backgroundColor = UIColor.clear
            self.everyDay1Btn.setTitleColor(UIColor.white, for: .normal)
            self.weekendsBtn.isSelected = false
            self.weekendsBtn.backgroundColor = UIColor.clear
            self.weekendsBtn.setTitleColor(UIColor.white, for: .normal)
            self.btn3.isSelected = false
            self.btn3.backgroundColor = UIColor.clear
            self.btn3.setTitleColor(UIColor.white, for: .normal)
            self.alcoholChoice = "occasionally"
            self.neverBtn.isSelected = false
            self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        case "":
            self.alcoholChoice = ""
                self.neverBtn.isSelected = true
                self.neverBtn.setImage(UIImage(named: "scheck"), for: .normal)
                self.never2Btn.isSelected = false
                self.never2Btn.setImage(UIImage(named: "ucheck"), for: .normal)
                 self.alcoholChoice = ""
                 self.occasionalBtn.isSelected = false
                           self.occasionalBtn.backgroundColor = UIColor.clear
                           self.occasionalBtn.setTitleColor(UIColor.white, for: .normal)
                self.everyDay1Btn.isSelected = false
                self.everyDay1Btn.backgroundColor = UIColor.clear
                self.everyDay1Btn.setTitleColor(UIColor.white, for: .normal)
                self.btn3.isSelected = false
                self.btn3.backgroundColor = UIColor.clear
                self.btn3.setTitleColor(UIColor.white, for: .normal)
                self.weekendsBtn.isSelected = false
                           self.weekendsBtn.backgroundColor = UIColor.clear
                           self.weekendsBtn.setTitleColor(UIColor.white, for: .normal)
        default:
            print("")
        }
        switch self.smokeChoice.lowercased() {
        case "everyday":
            self.smokeChoice = "everyday"
            self.everyday2Btn.isSelected = true
                       self.everyday2Btn.backgroundColor = AppColours.appGreen
                       self.everyday2Btn.setTitleColor(UIColor.black, for: .normal)
                       self.btn32.isSelected = false
                       self.btn32.backgroundColor = UIColor.clear
                       self.btn32.setTitleColor(UIColor.white, for: .normal)
                       self.weekends2Btn.isSelected = false
                       self.weekends2Btn.backgroundColor = UIColor.clear
                       self.weekends2Btn.setTitleColor(UIColor.white, for: .normal)
                       self.occsional2Btn.isSelected = false
                       self.occsional2Btn.backgroundColor = UIColor.clear
                       self.occsional2Btn.setTitleColor(UIColor.white, for: .normal)
                       self.smokeChoice = "everyday"
                       self.never2Btn.isSelected = false
                       self.never2Btn.setImage(UIImage(named: "ucheck"), for: .normal)
        case "3-5 times a week":
            self.smokeChoice = "3-5 times a week"
            self.btn32.isSelected = true
            self.btn32.backgroundColor = AppColours.appGreen
            self.btn32.setTitleColor(UIColor.black, for: .normal)
            self.everyday2Btn.isSelected = false
            self.everyday2Btn.backgroundColor = UIColor.clear
            self.everyday2Btn.setTitleColor(UIColor.white, for: .normal)
            self.weekends2Btn.isSelected = false
            self.weekends2Btn.backgroundColor = UIColor.clear
            self.weekends2Btn.setTitleColor(UIColor.white, for: .normal)
            self.occsional2Btn.isSelected = false
            self.occsional2Btn.backgroundColor = UIColor.clear
            self.occsional2Btn.setTitleColor(UIColor.white, for: .normal)
            self.smokeChoice = "3-5 times a week"
            self.never2Btn.isSelected = false
            self.never2Btn.setImage(UIImage(named: "ucheck"), for: .normal)
        case "weekends":
            self.smokeChoice = "weekends"
            self.weekends2Btn.isSelected = true
            self.weekends2Btn.backgroundColor = AppColours.appGreen
            self.weekends2Btn.setTitleColor(UIColor.black, for: .normal)
            self.everyday2Btn.isSelected = false
            self.everyday2Btn.backgroundColor = UIColor.clear
            self.everyday2Btn.setTitleColor(UIColor.white, for: .normal)
            self.btn32.isSelected = false
            self.btn32.backgroundColor = UIColor.clear
            self.btn32.setTitleColor(UIColor.white, for: .normal)
            self.occsional2Btn.isSelected = false
            self.occsional2Btn.backgroundColor = UIColor.clear
            self.occsional2Btn.setTitleColor(UIColor.white, for: .normal)
            self.smokeChoice = "weekends"
            self.never2Btn.isSelected = false
            self.never2Btn.setImage(UIImage(named: "ucheck"), for: .normal)
        case "occasionally":
            self.smokeChoice = "occasionally"
            self.occsional2Btn.isSelected = true
                       self.occsional2Btn.backgroundColor = AppColours.appGreen
                       self.occsional2Btn.setTitleColor(UIColor.black, for: .normal)
                       self.everyday2Btn.isSelected = false
                       self.everyday2Btn.backgroundColor = UIColor.clear
                       self.everyday2Btn.setTitleColor(UIColor.white, for: .normal)
                       self.weekends2Btn.isSelected = false
                       self.weekends2Btn.backgroundColor = UIColor.clear
                       self.weekends2Btn.setTitleColor(UIColor.white, for: .normal)
                       self.btn32.isSelected = false
                       self.btn32.backgroundColor = UIColor.clear
                       self.btn32.setTitleColor(UIColor.white, for: .normal)
                       self.smokeChoice = "occasionally"
                       self.never2Btn.isSelected = false
                       self.never2Btn.setImage(UIImage(named: "ucheck"), for: .normal)
        case "":
            self.smokeChoice = ""
            self.never2Btn.isSelected = true
                       self.never2Btn.setImage(UIImage(named: "scheck"), for: .normal)
                       self.neverBtn.isSelected = false
                       self.neverBtn.setImage(UIImage(named: "ucheck"), for: .normal)
                       self.smokeChoice = ""
                       self.occsional2Btn.isSelected = false
                       self.occsional2Btn.backgroundColor = UIColor.clear
                       self.occsional2Btn.setTitleColor(UIColor.white, for: .normal)
                       self.everyday2Btn.isSelected = false
                       self.everyday2Btn.backgroundColor = UIColor.clear
                       self.everyday2Btn.setTitleColor(UIColor.white, for: .normal)
                       self.weekends2Btn.isSelected = false
                       self.weekends2Btn.backgroundColor = UIColor.clear
                       self.weekends2Btn.setTitleColor(UIColor.white, for: .normal)
                       self.btn32.isSelected = false
                       self.btn32.backgroundColor = UIColor.clear
                       self.btn32.setTitleColor(UIColor.white, for: .normal)
        default:
            print("")
        }
    }
    
}
