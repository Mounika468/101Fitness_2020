//
//  PhoneNumberPopupVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 06/11/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class PhoneNumberPopupVC: UIViewController {

    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var otpTxtField: UITextField!
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var countryCode2Btn: UIButton!
    @IBOutlet weak var countryCode1Btn: UIButton!
    var isFromPaymentScreen : Bool = false
    var currentVerificationId: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if self.navigationController?.isNavigationBarHidden == false {
            self.navigationController?.isNavigationBarHidden = true
        }
        let navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100))
        navigationView.titleLbl.text = "OTP Verification"
        navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.backBtn.isHidden = true
       // navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        navigationView.saveBtn.isHidden = false
        navigationView.saveBtn.setTitle("Cancel", for: .normal)
        navigationView.saveBtn .addTarget(self, action: #selector(saveBtnTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(navigationView)
        
        self.countryCode2Btn.isHidden = true
        self.phoneTxtField.attributedPlaceholder = NSAttributedString(string: "Phone",
               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.otpTxtField.attributedPlaceholder = NSAttributedString(string: "OTP",
               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        self.phoneView.layer.cornerRadius = 15.0
               self.phoneView.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
        
        self.otpView.layer.cornerRadius = 15.0
               self.otpView.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
        self.countryCode2Btn.layer.cornerRadius = 2.0
        self.countryCode2Btn.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
        self.resendBtn.setTitleColor(AppColours.textGreen, for: .normal)
//        bgView.layer.cornerRadius = 20
//        bgView.layer.borderWidth = 0.5
//        bgView.layer.borderColor = UIColor.lightGray.cgColor
      //  self.setUpPhoneView()
        self.hideKeyboardWhenTappedAround()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 6, options: .curveEaseIn, animations: {
//            self.bgView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
//            self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
//
//
//        }, completion: nil)
        if self.isFromPaymentScreen == false {
            let phoneAlertDisplayed = UserDefaults.standard.bool(forKey:"PhoneAlertDisplayed")
            if phoneAlertDisplayed == false {
                UserDefaults.standard.setValue(true, forKey:"PhoneAlertDisplayed")
            }
        }
        
    }
    @objc func saveBtnTapped(sender : UIButton){
        if self.isFromPaymentScreen == true {
            self.navigationController?.popViewController(animated: true)
        }else {
            self.dismiss(animated: true, completion: {
            })
        }
       
    }
    func savePhoneNumber()
    {
        
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
            if self.phoneTxtField.text?.count == 0 {
                self.presentAlertWithTitle(title: "", message: "Please enter phone number", options: "OK") {_ in
                }
            }else {
                let window = UIApplication.shared.windows.first!
               DispatchQueue.main.async {
                   LoadingOverlay.shared.showOverlay(view: window)
                      }
                
                TraineeInfo.details.country_code = countryCode1Btn.titleLabel?.text ?? ""
                TraineeInfo.details.mobile_no = self.phoneTxtField.text!
                
                    let postBody : [String: Any] = ["mobile_no": self.phoneTxtField.text!,"trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"country_code":TraineeInfo.details.country_code]
                        
                        let jsonData = try! JSONSerialization.data(withJSONObject: postBody)
                   
                        
                        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
                        if token == nil {
                            AWSUserSingleton.shared.getUserattributes()
                        }
                        var authenticatedHeaders: [String: String] {
                            [
                                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) "
                                
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
                                    if let json = response.result.value as? [String: Any] {
                                        print("JSON: \(json)") // serialized json response
                                        do {
                                            if json[ResponseKeys.data.rawValue] != nil
                                            {
                                                if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                                    if jsonDict != nil {
                                                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                                  options: .prettyPrinted)
                                                        TraineeDetails.traineeDetails = try JSONDecoder().decode(TraineeDetails.self, from: jsonData)
                                                        TraineeInfo.details.country_code = TraineeDetails.traineeDetails?.country_code ?? ""
                                                        DispatchQueue.main.async {
                                                            if self.isFromPaymentScreen == true {
                                                                self.navigationController?.popViewController(animated: true)
                                                            }else {
                                                                self.dismiss(animated: true, completion: {
                                                                })
                                                            }
                                                        }
                                                    }else {
                                                        DispatchQueue.main.async {
                                                            if self.isFromPaymentScreen == true {
                                                                self.navigationController?.popViewController(animated: true)
                                                            }else {
                                                                self.dismiss(animated: true, completion: {
                                                                })
                                                            }
                                                        }
                                                    }
                                                    
                                                } else {
                                                     DispatchQueue.main.async {
                                                    self.presentAlertWithTitle(title: "", message: "Phone number Update failed", options: "OK") {_ in
                                                    }
                                                    }
                                                }
                                            } }catch let error {
                                                DispatchQueue.main.async {
                                                                   LoadingOverlay.shared.hideOverlayView()
                                                    self.presentAlertWithTitle(title: "", message: "Phone number Update failed", options: "OK") {_ in
                                                                                       }
                                                               }
                                               
                                        }
                                    }
                                    
                                default:
                                    DispatchQueue.main.async {
                                        LoadingOverlay.shared.hideOverlayView()
                                    }
                                }
                            }
                        }
            }
       
    }
    func setUpPhoneView() {
        view.addSubview(bgView)
        bgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bgView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height).isActive = true
        bgView.widthAnchor.constraint(equalToConstant: view.bounds.width*0.8).isActive = true
    }
    @IBAction func updateBtnTapped(_ sender: Any) {
        if self.phoneTxtField.text?.count != 0 {
            
            Auth.auth().languageCode = "en"
            let window = UIApplication.shared.windows.first!
            DispatchQueue.main.async {
                LoadingOverlay.shared.showOverlay(view: window)
            }
            //  let phoneNumber = self.phoneTxtField.text ?? ""
            let phoneNumber = String(format: "%@%@", self.countryCode1Btn.titleLabel?.text ?? "", self.phoneTxtField.text ?? "")
            
            // Step 4: Request SMS
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        LoadingOverlay.shared.hideOverlayView()
                        self.presentAlertWithTitle(title: "", message: error.localizedDescription, options: "OK") {_ in
                        }
                    }
                    print(error.localizedDescription)
                    return
                }
                
                // Either received APNs or user has passed the reCAPTCHA
                // Step 5: Verification ID is saved for later use for verifying OTP with phone number
                self.currentVerificationId = verificationID!
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                    self.presentAlertWithTitle(title: "", message: "Please enter verification code sent to phone number", options: "OK") {_ in
                    }
                }
            }
        }else {
            self.presentAlertWithTitle(title: "", message: "Please enter phone number", options: "OK") { (_) in
                
            }
        }
    }
    @IBAction func resendBtnTapped(_ sender: Any) {
    }
    
    @IBAction func verifyBtnTapped(_ sender: Any) {
       // self.savePhoneNumber()
        if self.phoneTxtField.text?.count == 0 {
            self.presentAlertWithTitle(title: "", message: "Please enter phone number", options: "OK") { (_) in
                
            }
            return
        }
        if self.otpTxtField.text?.count == 0 {
            self.presentAlertWithTitle(title: "", message: "Please enter OTP number", options: "OK") { (_) in
                
            }
            return
        }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: currentVerificationId, verificationCode: self.otpTxtField.text ?? "")

        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
           // let authError = error as NSError
            //print(authError.description)
            self.presentAlertWithTitle(title: "", message: error.localizedDescription, options: "OK") {_ in
            }
            return
          }
            self.savePhoneNumber()

          // User has signed in successfully and currentUser object is valid
         // let currentUserInstance = Auth.auth().currentUser
        }
    }
    @IBAction func countryCode2BtnTapped(_ sender: Any) {
        //        if countryCode2Btn.isSelected {
        //            countryCode2Btn.isSelected = false
        //        }else {
                    countryCode2Btn.isSelected = true
                    if countryCode1Btn.titleLabel?.text ?? "" == "+91"{
                        countryCode1Btn.setTitle("+1", for: .normal)
                    }else {
                        countryCode1Btn.setTitle("+91", for: .normal)
                    }
                    countryCode2Btn.isHidden = true
               // }
                
            }
    @IBAction func countryCode1BtnTapped(_ sender: Any) {
        //        if countryCode1Btn.isSelected {
        //            countryCode1Btn.isSelected = false
        //            countryCode2Btn.isHidden = true
        //        }else {
                    countryCode1Btn.isSelected = true
                    countryCode2Btn.isHidden = false
                    if countryCode1Btn.titleLabel?.text ?? "" == "+91"{
                        countryCode2Btn.setTitle("+1", for: .normal)
                    }else {
                        countryCode2Btn.setTitle("+91", for: .normal)
                    }
                //}
                
            }
}
extension PhoneNumberPopupVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
}
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == phoneTxtField {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789").inverted
                let components = string.components(separatedBy: allowedCharacters)
                let filtered = components.joined(separator: "")
                
                if string == filtered {
                    
                   let maxLength = 10
                    let currentString: NSString = textField.text! as NSString
                    let newString: NSString =
                        currentString.replacingCharacters(in: range, with: string) as NSString
                   
                    return newString.length <= maxLength

                } else {
                    
                    return false
                }
            }
        if textField == phoneTxtField {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789").inverted
                //let telefonRegex = "^[0-9]{8}$"
                let components = string.components(separatedBy: allowedCharacters)
                let filtered = components.joined(separator: "")
                
                if string == filtered {
                    print("string \(string)")
                    
                    return true

                } else {
                    
                    return false
                }
            }
        
        return true
    }
}
