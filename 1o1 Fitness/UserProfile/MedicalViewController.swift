//
//  MedicalViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 06/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import Alamofire

class MedicalViewController: UIViewController {

    @IBOutlet weak var surgeryTxtField: UITextView! {
        didSet {
            surgeryTxtField.text = "List any other medical issue(s)"
            surgeryTxtField.textColor = UIColor.lightGray
        }
    }
    @IBOutlet weak var allergyTxtField: UITextView! {
        didSet {
            allergyTxtField.text = "List any food item(s) you're allergic to"
            allergyTxtField.textColor = UIColor.lightGray
        }
    }
    @IBOutlet weak var disableTxtField: UITextView!
    {
        didSet {
            disableTxtField.text = "List any disabilities* you have"
            disableTxtField.textColor = UIColor.lightGray
        }
    }
    @IBOutlet weak var surgeryView: UIView!
    @IBOutlet weak var allergyView: UIView!
    @IBOutlet weak var disableView: UIView!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var bottomView: ProfileBottomView!
    @IBOutlet weak var headerView: ProfileHeaderView!
    var workOutDesc = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        headerView.countLbl.text = "11 / 11"
        bottomView.bottonDelegate = self
        self.surgeryView.layer.cornerRadius = 10
        self.surgeryView.layer.borderWidth = 0.5
        self.surgeryView.layer.borderColor = AppColours.textGreen.cgColor
         self.disableView.layer.cornerRadius = 10
        self.disableView.layer.borderWidth = 0.5
               self.disableView.layer.borderColor = AppColours.textGreen.cgColor
         self.allergyView.layer.cornerRadius = 10
        self.allergyView.layer.borderWidth = 0.5
               self.allergyView.layer.borderColor = AppColours.textGreen.cgColor
        
        self.yesBtn.layer.cornerRadius = 10
               self.yesBtn.layer.borderWidth = 1
               self.yesBtn.layer.borderColor = AppColours.textGreen.cgColor
               self.noBtn.layer.cornerRadius = 10
               self.noBtn.layer.borderWidth = 1
               self.noBtn.layer.borderColor = AppColours.textGreen.cgColor
        
//        self.disableTxtField.attributedPlaceholder = NSAttributedString(string: "List any disabilities*",
//               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
//               self.allergyTxtField.attributedPlaceholder = NSAttributedString(string: "List any food item(s) your allergic to",
//               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
//        self.surgeryTxtField.attributedPlaceholder = NSAttributedString(string: "List any surgeries or medical issue(s)",
//                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
         self.hideKeyboardWhenTappedAround()
              
    }
    
    @IBAction func yesBtnTapped(_ sender: Any) {
        if self.yesBtn.isSelected {
            self.yesBtn.isSelected = false
            self.yesBtn.backgroundColor = UIColor.clear
            self.yesBtn.setTitleColor(UIColor.white, for: .normal)
        }else {
            self.yesBtn.isSelected = true
            self.yesBtn.backgroundColor = AppColours.appGreen
            self.yesBtn.setTitleColor(UIColor.black, for: .normal)
            self.noBtn.isSelected = false
            self.noBtn.backgroundColor = UIColor.clear
            self.noBtn.setTitleColor(UIColor.white, for: .normal)
            self.showWorkOutHistory()
        }
    }
    
    @IBAction func noBtnTapped(_ sender: Any) {
        if self.noBtn.isSelected {
                   self.noBtn.isSelected = false
                   self.noBtn.backgroundColor = UIColor.clear
                   self.noBtn.setTitleColor(UIColor.white, for: .normal)
               }else {
                   self.noBtn.isSelected = true
                   self.noBtn.backgroundColor = AppColours.appGreen
                   self.noBtn.setTitleColor(UIColor.black, for: .normal)
                   self.yesBtn.isSelected = false
                   self.yesBtn.backgroundColor = UIColor.clear
                   self.yesBtn.setTitleColor(UIColor.white, for: .normal)
                   
               }
    }
    func showWorkOutHistory() {
        let storyboard = UIStoryboard(name: "WorkOutHistoryVC", bundle: nil)
                let alertVC = storyboard.instantiateViewController(withIdentifier: "wohVC") as! WorkOutHistoryVC
        alertVC.workOutDelegate = self
            alertVC.modalPresentationStyle = .custom
                present(alertVC, animated: false, completion: nil)
    }

}
extension MedicalViewController: workOutDelegate {
    func workoutHistroy(descr: String) {
        self.workOutDesc = descr
    }
}
extension MedicalViewController : BottomViewDelegate {
    func leftBtnTapped() {
        self.navigationController?.popViewController(animated: true)
        
    }
    func rightBtnTapped() {
        
       
        let surgery = self.surgeryTxtField.text
        let allergy = self.allergyTxtField.text
        let disability = self.disableTxtField.text
        let sur = surgery?.isEmpty ?? false
        let all = allergy?.isEmpty ?? false
        let dis = disability?.isEmpty ?? false
        TraineeInfo.details.medical_history = ["any_medical_surgerie_issues": sur ? "no" : surgery!,"any_food_allergies": all ? "no" : allergy!, "any_disability": dis ? "no" : disability!]
        if self.workOutDesc.count > 0 {
            TraineeInfo.details.previous_workout_history = ["status" : "yes","description":self.workOutDesc ]
        }else {
             TraineeInfo.details.previous_workout_history = [ "status" : "no","description":"" ]
        }
        if sur || all || dis {
            self.presentAlertWithTitle(title: "", message: "Please enter NA for all fields if not applicable", options: "OK") { (option) in
            }
        }
        else {
        self.registerUser()
        }
        
    }
    func registerUser(){
        let postBody : [String: Any] = ["first_name": TraineeInfo.details.first_name,"last_name": TraineeInfo.details.last_name,"mobile_no": TraineeInfo.details.mobile_no,"gender": TraineeInfo.details.gender,"date_of_birth": TraineeInfo.details.date_of_birth, "age":TraineeInfo.details.age, "currrent_weight":TraineeInfo.details.weight, "trainee_height":TraineeInfo.details.height, "activity_level":TraineeInfo.details.activityLevel, "primary_goal":TraineeInfo.details.primaryGoal, "best_workout_day": TraineeInfo.details.best_workout_day, "food_preference":TraineeInfo.details.food_preference, "smoke_alcohol_consumption":TraineeInfo.details.smoke_alcohol_consumption, "sleep_duration":TraineeInfo.details.sleep_duration, "sleep_quality":TraineeInfo.details.sleep_quality,"previous_workout_history":TraineeInfo.details.previous_workout_history,"trainee_timezone":"IST","created_on": Date.getCurrentDate() ,"updated_on":Date.getCurrentDate(),"profile_submission":true,"user_type":"registered","trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"address_submission":false,"username":TraineeInfo.details.username,"medical_history":TraineeInfo.details.medical_history]
        //           let jsonData = try! JSONSerialization.data(withJSONObject: postBody, options: [])
        //           let decoded = String(data: jsonData, encoding: .utf8)!
        let jsonData = try! JSONSerialization.data(withJSONObject: postBody)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
        print (jsonString)
        let window = UIApplication.shared.windows.first!
        DispatchQueue.main.async {
            LoadingOverlay.shared.showOverlay(view: window)
        }
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        if token == nil {
            AWSUserSingleton.shared.getUserattributes()
        }
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) "
                //  HeadersKeys.contentType: HeaderValues.json
            ]
        }
        
        let urlString = postTraineeDetails
        guard let url = URL(string: urlString) else {return}
        var request        = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(HeaderValues.token) \(token!) ", forHTTPHeaderField: "Authorization")
        do {
            request.httpBody   = try JSONSerialization.data(withJSONObject: postBody)
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        Alamofire.request(request).responseJSON{ (response) in
            
            print("response is \(response)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
            
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    print("example success")
                    DispatchQueue.main.async {

                        let storyboard = UIStoryboard(name: "CustomAlertVC", bundle: nil)
                        let alertVC = storyboard.instantiateViewController(withIdentifier: "CAVC") as! CustomAlertViewController
                         alertVC.responseType = .success
                         alertVC.alertType = .registration
                        // alertVC.displaySuccessView()
                        alertVC.customAlertDelegate = self
                        alertVC.modalPresentationStyle = .custom
                        self.present(alertVC, animated: false, completion: nil)
                    }
                default:
                    DispatchQueue.main.async {
//                        self.presentAlertWithTitle(title: "", message: "User registration failure", options: "OK") { (option) in
//                        }
                        let storyboard = UIStoryboard(name: "CustomAlertVC", bundle: nil)
                        let alertVC = storyboard.instantiateViewController(withIdentifier: "CAVC") as! CustomAlertViewController
                        alertVC.responseType = .fail
                        alertVC.alertType = .registration
                       // alertVC.displaySuccessView()
                        alertVC.customAlertDelegate = self
                        alertVC.modalPresentationStyle = .custom
                        self.present(alertVC, animated: false, completion: nil)
                    }
                }
            }
        }
    }
func navigateToHomeScreen(){
           TraineeInfo.details = TraineeInfo()
           let storyboard = UIStoryboard(name: "TabbarController", bundle: nil)
           let controller = storyboard.instantiateViewController(withIdentifier: "tabbarController")
           self.navigationController?.pushViewController(controller, animated: true)
       }
}
extension MedicalViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 100
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
extension MedicalViewController: CustomAlertViewDelegate {
    func singUpBtnTapped() {
        
    }
    func okBtnTapped() {
       self.navigateToHomeScreen()
    }
}
extension MedicalViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 300    // 10 Limit Value
    }
    func textViewDidBeginEditing(_ textView: UITextView) {

        if textView.textColor == UIColor.lightGray {
            switch textView {
            case self.disableTxtField:
                disableTxtField.text = ""
                disableTxtField.textColor = UIColor.white
            case self.allergyTxtField:
                allergyTxtField.text = ""
                allergyTxtField.textColor = UIColor.white
            case self.surgeryTxtField:
                surgeryTxtField.text = ""
                surgeryTxtField.textColor = UIColor.white
            default:
                textView.text = ""
                textView.textColor = UIColor.white
            }
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text == "" {
            
            if textView.textColor == UIColor.white {
                switch textView {
                case self.disableTxtField:
                    disableTxtField.text = "List any disabilities* you have"
                    disableTxtField.textColor = UIColor.lightGray
                case self.allergyTxtField:
                    allergyTxtField.text = "List any food item(s) you're allergic to"
                    allergyTxtField.textColor = UIColor.lightGray
                case self.surgeryTxtField:
                    surgeryTxtField.text = "List any other medical issue(s)"
                    surgeryTxtField.textColor = UIColor.lightGray
                default:
                    textView.text = ""
                    textView.textColor = UIColor.lightGray
                }
            }
        }
    }
}
