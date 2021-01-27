//
//  GenderViewController.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 10/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class GenderViewController: UIViewController {
    
    @IBOutlet weak var bottomView: ProfileBottomView!
    @IBOutlet weak var headerView: ProfileHeaderView!
    
    @IBOutlet weak var mixBtn: UIButton!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    var genderSel : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomView.bottonDelegate = self

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func mixBtnTapped(_ sender: Any) {
        if self.mixBtn.isSelected == true {
            self.mixBtn.isSelected = false
            self.mixBtn.setImage(UIImage(named: "gmixGen"), for: .normal)
            
        }else {
            self.genderSel = "other"
          self.mixBtn.isSelected = true
            self.mixBtn.setImage(UIImage(named: "cmixGen"), for: .normal)
            self.femaleBtn.isSelected = false
            self.femaleBtn.setImage(UIImage(named: "gfemale"), for: .normal)
            self.maleBtn.isSelected = false
            self.maleBtn.setImage(UIImage(named: "gmale"), for: .normal)
            
        }
    }
    @IBAction func femaleBtnTapped(_ sender: Any) {
         if self.femaleBtn.isSelected == true {
           self.femaleBtn.isSelected = false
            self.femaleBtn.setImage(UIImage(named: "gfemale"), for: .normal)
         }else {
            self.genderSel = "female"
           self.femaleBtn.isSelected = true
            self.femaleBtn.setImage(UIImage(named: "cfemale"), for: .normal)
            self.maleBtn.isSelected = false
            self.maleBtn.setImage(UIImage(named: "gmale"), for: .normal)
            self.mixBtn.isSelected = false
            self.mixBtn.setImage(UIImage(named: "gmixGen"), for: .normal)
         }
    }
    @IBAction func maleBtnTapped(_ sender: Any) {
        
        if self.maleBtn.isSelected == true {
            self.maleBtn.isSelected = false
            self.maleBtn.setImage(UIImage(named: "gmale"), for: .normal)
            
        }else {
            self.genderSel = "male"
          self.maleBtn.isSelected = true
            self.maleBtn.setImage(UIImage(named: "cmale"), for: .normal)
            self.femaleBtn.isSelected = false
            self.femaleBtn.setImage(UIImage(named: "gfemale"), for: .normal)
            self.mixBtn.isSelected = false
            self.mixBtn.setImage(UIImage(named: "gmixGen"), for: .normal)
            
        }
    }
    
    
    @IBAction func leftBtntTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func rightBtnTapped(_ sender: Any) {
        if self.femaleBtn.isSelected || self.maleBtn.isSelected {
            TraineeInfo.details.gender = self.genderSel
          //  activityVC
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "dateVC")
            self.navigationController?.pushViewController(controller, animated: true)
            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let controller = storyboard.instantiateViewController(withIdentifier: "activityVC")
//            self.navigationController?.pushViewController(controller, animated: true)
        }
        else
        {
            // Display alert to select
           
           presentAlertWithTitle(title: "", message: "Please select gender", options: "OK") { (option) in

           }
            
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
extension UIViewController {

    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
extension GenderViewController: BottomViewDelegate {
    func leftBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    func rightBtnTapped() {
        
        if self.femaleBtn.isSelected || self.maleBtn.isSelected || self.mixBtn.isSelected{
            TraineeInfo.details.gender = self.genderSel
            let storyboard = UIStoryboard(name: "DatePickerVC", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "dateVC") as! DatePickerViewController
             controller.navigationType = .profileNormal
            self.navigationController?.pushViewController(controller, animated: true)
        }else {
            presentAlertWithTitle(title: "", message: "Please select the gender", options: "OK") { (option) in
            }
        }
    }
}
