//
//  MealEditViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 09/12/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
enum TimeSelectionType {
    case breakfast
    case mSnack
    case lunch
    case eSnack
    case dinner
}
class MealEditViewController: UIViewController {
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var checkmarkBtn: UIButton!
    @IBOutlet weak var bfBtn: UIButton!
    @IBOutlet weak var msBtn: UIButton!
    @IBOutlet weak var lunchBtn: UIButton!
    @IBOutlet weak var esBtn: UIButton!
    @IBOutlet weak var dinnerBtn: UIButton!
    var navigationView = NavigationView()
    var timeSelection : TimeSelectionType = .breakfast
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        xBarHeight = 80
        navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight))
        navigationView.titleLbl.text = "Meal"
        navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.leftArrow.isHidden = true
        navigationView.rightArrow.isHidden = true
        navigationView.backBtn.isHidden = false
        navigationView.backBtn.addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(navigationView)
        self.navigationController?.isNavigationBarHidden = true
        self.headerLbl.textColor = AppColours.textGreen
        self.bfBtn.setTitleColor( AppColours.textGreen, for: .normal)
        self.bfBtn.setTitle("9:15 AM", for: .normal)
        self.msBtn.setTitleColor( AppColours.textGreen, for: .normal)
        self.msBtn.setTitle("11:15 AM", for: .normal)
        self.lunchBtn.setTitleColor( AppColours.textGreen, for: .normal)
        self.lunchBtn.setTitle("1:15 PM", for: .normal)
        self.esBtn.setTitleColor( AppColours.textGreen, for: .normal)
        self.esBtn.setTitle("4:15 PM", for: .normal)
        self.dinnerBtn.setTitleColor( AppColours.textGreen, for: .normal)
        self.dinnerBtn.setTitle("7:15 PM", for: .normal)
        
    }
    
    @objc func backBtnTapped(sender : UIButton){
     self.navigationController?.popViewController(animated: true)
    }

    @IBAction func mainSwitchChanged(_ sender: Any) {
    }
    @IBAction func breakFastBtnTapped(_ sender: Any) {
        self.timeSelection = .breakfast
        let storyboard = UIStoryboard(name: "TimePickerVC", bundle: nil)
                      let controller = storyboard.instantiateViewController(withIdentifier: "TimePickerVC") as! TimePickerVC
                        controller.modalPresentationStyle = .custom
        controller.timePickerDelegate = self
                         controller.transitioningDelegate = self
                             self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func bfSwitchChanged(_ sender: Any) {
    }
    
    @IBAction func mSnackBtnTapped(_ sender: Any) {
        self.timeSelection = .mSnack
        let storyboard = UIStoryboard(name: "TimePickerVC", bundle: nil)
                      let controller = storyboard.instantiateViewController(withIdentifier: "TimePickerVC") as! TimePickerVC
                        controller.modalPresentationStyle = .custom
        controller.timePickerDelegate = self
                         controller.transitioningDelegate = self
                             self.present(controller, animated: true, completion: nil)
    }
    @IBAction func mSnackSwitchChanged(_ sender: Any) {
    }
    
    @IBAction func lunchBtnTapped(_ sender: Any) {
        self.timeSelection = .lunch
        let storyboard = UIStoryboard(name: "TimePickerVC", bundle: nil)
                      let controller = storyboard.instantiateViewController(withIdentifier: "TimePickerVC") as! TimePickerVC
                        controller.modalPresentationStyle = .custom
        controller.timePickerDelegate = self
                         controller.transitioningDelegate = self
                             self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func lunchSwitchChanged(_ sender: Any) {
    }
    @IBAction func eSnackBtnTapped(_ sender: Any) {
        self.timeSelection = .eSnack
        let storyboard = UIStoryboard(name: "TimePickerVC", bundle: nil)
                      let controller = storyboard.instantiateViewController(withIdentifier: "TimePickerVC") as! TimePickerVC
                        controller.modalPresentationStyle = .custom
        controller.timePickerDelegate = self
                         controller.transitioningDelegate = self
                             self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func eSnackSwitchChanged(_ sender: Any) {
    }
    
    @IBAction func dinnerBtnTapped(_ sender: Any) {
        self.timeSelection = .dinner
        let storyboard = UIStoryboard(name: "TimePickerVC", bundle: nil)
                      let controller = storyboard.instantiateViewController(withIdentifier: "TimePickerVC") as! TimePickerVC
                        controller.modalPresentationStyle = .custom
        controller.timePickerDelegate = self
                         controller.transitioningDelegate = self
                             self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func dinnerSwitchChanged(_ sender: Any) {
    }
    @IBAction func saveBtnTapped(_ sender: Any) {
    }
    @IBAction func checkMarckTapped(_ sender: Any) {
        let btn = sender as! UIButton
        if btn.isSelected {
            self.checkmarkBtn.setImage(UIImage(named: "checkmark"), for: .normal)
            btn.isSelected = false
        }else {
            self.checkmarkBtn.setImage(UIImage(named: "checkmarkSel"), for: .normal)
            btn.isSelected = true
        }
    }
}
extension MealEditViewController :UIViewControllerTransitioningDelegate, TimePickerDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController:presented, presenting: presenting)
    }
    func timeSelected(time:String) {
        let dateAsString = time
           let df = DateFormatter()
           df.dateFormat = "HH:mm"

           let date = df.date(from: dateAsString)
           df.dateFormat = "hh:mm a"

           let time12 = df.string(from: date!)
        DispatchQueue.main.async {
            switch self.timeSelection {
            case .breakfast :
                self.bfBtn.setTitle(time12, for: .normal)
            case .mSnack :
                self.msBtn.setTitle(time12, for: .normal)
            case .lunch :
                self.lunchBtn.setTitle(time12, for: .normal)
            case .eSnack :
                self.esBtn.setTitle(time12, for: .normal)
            case .dinner :
                self.dinnerBtn.setTitle(time12, for: .normal)
            default:
                break
            }
        }
          

    }
}
 
