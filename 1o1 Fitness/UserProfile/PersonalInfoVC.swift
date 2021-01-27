//
//  PersonalInfoVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 07/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class PersonalInfoVC: UIViewController {

    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var lastView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var bottomView: ProfileBottomView!
    @IBOutlet weak var headerView: ProfileHeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        headerView.countLbl.text = "1 / 11"
        bottomView.bottonDelegate = self
         self.firstView.layer.cornerRadius = 20.0
               self.firstView.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
               
               self.lastView.layer.cornerRadius = 20.0
               self.lastView.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
       
        self.phoneView.layer.cornerRadius = 20.0
                      self.phoneView.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
       
        
        self.phoneTxtField.attributedPlaceholder = NSAttributedString(string: "Phone",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.firstNameTxtField.attributedPlaceholder = NSAttributedString(string: "First Name",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.lastNameTxtField.attributedPlaceholder = NSAttributedString(string: "Last Name",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

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
extension PersonalInfoVC : BottomViewDelegate {
    func leftBtnTapped() {
        self.navigationController?.popViewController(animated: true)
        
    }
    func rightBtnTapped() {
        let firstname = self.firstNameTxtField.text
        let lastname = self.lastNameTxtField.text
        let mobile = self.phoneTxtField.text
        if firstname?.count ?? 0 > 0 && lastname?.count ?? 0 > 0 && mobile?.count ?? 0 > 0 {
            if self.phoneTxtField.text?.isPhoneNumber == false {
                
                presentAlertWithTitle(title: "", message: "Please enter valid phone number", options: "OK") { (option) in

                }
                return
            }
            TraineeInfo.details.first_name = firstname!
            TraineeInfo.details.last_name = lastname!
            TraineeInfo.details.mobile_no = mobile!
            let storyboard = UIStoryboard(name: "GenderVC", bundle: nil)
               let controller = storyboard.instantiateViewController(withIdentifier: "genderVC") as! GenderViewController
            self.navigationController?.pushViewController(controller, animated: true)
        }else {
            presentAlertWithTitle(title: "", message: "Please enter all the fields", options: "OK") { (option) in

            }
        }
        
    }
}
extension PersonalInfoVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField != phoneTxtField {
            let allowedCharacters = CharacterSet(charactersIn:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvxyz").inverted
                let components = string.components(separatedBy: allowedCharacters)
                let filtered = components.joined(separator: "")
                
                if string == filtered {
                    
                    return true

                } else {
                    
                    return false
                }
            }else {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789").inverted
                let components = string.components(separatedBy: allowedCharacters)
                let filtered = components.joined(separator: "")
                
                if string == filtered {
                    
                    return true

                } else {
                    
                    return false
                }
            }
    }
}
extension String {
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    func isValidPassword() -> Bool {
        let passwordRegex = "^^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
        // here, `try!` will always succeed because the pattern is valid
//        let regex = try! NSRegularExpression(pattern: "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$", options: .caseInsensitive)
//        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

