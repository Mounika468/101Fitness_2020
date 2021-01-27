//
//  RegistrationViewController.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 23/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//


import UIKit
import AWSMobileClient

class SignUpViewController: UIViewController {

    @IBOutlet weak var countryCode2Btn: UIButton!
    @IBOutlet weak var countryCode1Btn: UIButton!
    @IBOutlet weak var pwImg: UIImageView!
    @IBOutlet weak var usImg: UIImageView!
    @IBOutlet weak var emImg: UIImageView!
    @IBOutlet weak var phImg: UIImageView!
    @IBOutlet weak var lnImg: UIImageView!
    @IBOutlet weak var fnImg: UIImageView!
    @IBOutlet weak var userErrLbl: UILabel!
    @IBOutlet weak var fnErrLbl: UILabel!
    @IBOutlet weak var lnErrLbl: UILabel!
    @IBOutlet weak var pwdErrLbl: UILabel!
    @IBOutlet weak var emailErrLbl: UILabel!
    @IBOutlet weak var phoneErrLbl: UILabel!
    @IBOutlet weak var lsErrorLbl: UILabel!
    @IBOutlet weak var fsErrLbl: UILabel!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var pwdTxtField: UITextField!
    @IBOutlet weak var pwdView: UIView!
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var lnTxtField: UITextField!
    @IBOutlet weak var fsTxtField: UITextField!
    @IBOutlet weak var lsView: UIView!
    @IBOutlet weak var fnView: UIView!
    @IBOutlet weak var fNameTxtField: UITextField!
    
    var isLoading : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.pwdView.layer.cornerRadius = 20.0
        self.pwdView.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
        
        self.userNameView.layer.cornerRadius = 20.0
        self.userNameView.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
        
        self.emailView.layer.cornerRadius = 20.0
        self.emailView.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
        
        self.fnView.layer.cornerRadius = 20.0
        self.fnView.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
        
        self.lsView.layer.cornerRadius = 20.0
        self.lsView.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
        
        self.phoneView.layer.cornerRadius = 20.0
               self.phoneView.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
        
//        self.signUpBtn.layer.cornerRadius = 8.0
//        self.signUpBtn.backgroundColor = AppColours.Btngreen
        self.signUpBtn.isEnabled = false
        self.fsTxtField.attributedPlaceholder = NSAttributedString(string: "First name",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.phoneTxtField.attributedPlaceholder = NSAttributedString(string: "Phone",
               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.lnTxtField.attributedPlaceholder = NSAttributedString(string: "Last name",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.emailTxtField.attributedPlaceholder = NSAttributedString(string: "Email",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.userNameTxtField.attributedPlaceholder = NSAttributedString(string: "Username",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.pwdTxtField.attributedPlaceholder = NSAttributedString(string: "Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        googleBtn.layer.cornerRadius = 15.0
               googleBtn.layer.borderColor = AppColours.greenBorder.cgColor
               googleBtn.layer.borderWidth = 1.0
         self.hideKeyboardWhenTappedAround()
        AWSMobileClient.sharedInstance().signOut() { error in
            if let error = error {
                print(error)
                return
            }else {
                
            }
            
        }
        
        self.countryCode2Btn.layer.cornerRadius = 2.0
        self.countryCode2Btn.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
        self.emailTxtField.autocorrectionType = .yes
        self.fsTxtField.autocorrectionType = .yes
        self.lnTxtField.autocorrectionType = .yes
        self.userNameTxtField.autocorrectionType = .yes
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
    @IBAction func googleBtnTapped(_ sender: Any) {
        
        //  GIDSignIn.sharedInstance()?.signIn()
          
        AWSMobileClient.sharedInstance().signOut(options: SignOutOptions(signOutGlobally: true)) { (error) in
            print("Error: \(error.debugDescription)")
            
        }
          
          let hostedUIOptions = HostedUIOptions(scopes: ["openid","email","profile","aws.cognito.signin.user.admin"], identityProvider: "Google")
          
          // Present the Hosted UI sign in.
          AWSMobileClient.sharedInstance().showSignIn(navigationController: self.navigationController!, hostedUIOptions: hostedUIOptions) { (userState, error) in
              if let error = error as? AWSMobileClientError {
                  print(error.localizedDescription)
              }
              if let userState = userState {
                  print("Status: \(userState.rawValue)")
              }
            if self.isLoading == true {
                return
            }
              self.getGoogleUserAttributes(complete: { () -> () in
                
                TraineeRegister.postBasicTraieeDetails(userType: "google", successHandler: { (message) in
                    DispatchQueue.main.async {
                        if self.isLoading == true {
                            return
                        }
                                                self.navigateToProfile(isNormalLogin: false)
                        self.isLoading = true
                                        }
                }) { (error) in
                                    DispatchQueue.main.async {
                                        self.presentAlertWithTitle(title: "User registration failure", message: "Please try again after sometime", options: "OK") { (option) in
                                            self.isLoading = false
                                        }
                                    }
                                }
                  
              })

          }
      }
    func getGoogleUserAttributes(complete:@escaping ()->()) {
        AWSMobileClient.sharedInstance().getTokens { (tokens, error) in
            if let error = error {
                print("Error getting token \(error.localizedDescription)")
                self.isLoading = false
                //complete()
            } else if let tokens = tokens {
                
                TraineeInfo.details.first_name = tokens.idToken?.claims?["name"] as? String ?? ""
                TraineeInfo.details.username = tokens.idToken?.claims?["email"] as? String ?? ""
                TraineeInfo.details.email = tokens.idToken?.claims?["email"] as? String ?? ""
                TraineeInfo.details.last_name = tokens.idToken?.claims?["family_name"] as? String ?? ""
                TraineeInfo.details.mobile_no = tokens.idToken?.claims?["mobile"] as? String ?? ""
                TraineeInfo.details.country_code = ""
                let userdefaults = UserDefaults.standard
                if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.accessToken){
                    userdefaults.removeObject(forKey: UserDefaultsKeys.accessToken)
                }
                userdefaults.set(tokens.accessToken!.tokenString!, forKey:UserDefaultsKeys.accessToken)
                
                if userdefaults.string(forKey: UserDefaultsKeys.subId) != nil{
                    userdefaults.removeObject(forKey: UserDefaultsKeys.subId)
                }
                userdefaults.set(tokens.idToken?.claims?["sub"] as? String ?? "", forKey:UserDefaultsKeys.subId)
                if userdefaults.string(forKey: UserDefaultsKeys.name) != nil{
                    userdefaults.removeObject(forKey: UserDefaultsKeys.name)
                }
                userdefaults.set(tokens.idToken?.claims?["name"] as? String ?? "", forKey:UserDefaultsKeys.name)
                if userdefaults.string(forKey: UserDefaultsKeys.email) != nil{
                    userdefaults.removeObject(forKey: UserDefaultsKeys.email)
                }
                userdefaults.set(tokens.idToken?.claims?["email"] as? String ?? "", forKey:UserDefaultsKeys.email)
                complete()
            }
        }
    }
    func navigateToProfile(isNormalLogin:Bool) {
        
        if isNormalLogin == true {
            let userdefaults = UserDefaults.standard
               if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin){
                userdefaults.removeObject(forKey: UserDefaultsKeys.guestLogin)
            }
            userdefaults.set(UserDefaultsKeys.authUser, forKey:UserDefaultsKeys.guestLogin)
//           userdefaults.set(userName, forKey:UserDefaultsKeys.userName)
//           userdefaults.set(password, forKey:UserDefaultsKeys.password)
        }else {
            let userdefaults = UserDefaults.standard
               if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin){
                userdefaults.removeObject(forKey: UserDefaultsKeys.guestLogin)
            }
            
            userdefaults.set(UserDefaultsKeys.googleUser, forKey:UserDefaultsKeys.guestLogin)
        }
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "TabbarController", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "tabbarController")
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    @IBAction func loginBtnTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "loginVC")
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    func signUpHandler(signUpResult: SignUpResult?, error: Error?) {
        
        DispatchQueue.main.async {
               LoadingOverlay.shared.hideOverlayView()
               }
        if let error = error as? AWSMobileClientError {
            switch(error) {
            case .usernameExists(let message):
                DispatchQueue.main.async {
                    self.presentAlertWithTitle(title: "Error", message: "\(message)", options: "OK") {_ in
                    }
                }
                
            default:
                DispatchQueue.main.async {
                    self.presentAlertWithTitle(title: "Error", message: "\(error)", options: "OK") {_ in
                    }
                }
                break
            }

        }
        
        guard let signUpResult = signUpResult else {
            return
        }
        
        switch(signUpResult.signUpConfirmationState) {
        case .confirmed:
            print("User is signed up and confirmed.")
            // Navigating to Home screen
            DispatchQueue.main.async {
                
                
            
                let storyboard = UIStoryboard(name: "TabbarController", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "tabbarController")
                self.navigationController?.pushViewController(controller, animated: true)
                
            }

            
        case .unconfirmed:
            let alert = UIAlertController(title: "Code sent",
                                          message: "Confirmation code sent via \(signUpResult.codeDeliveryDetails!.deliveryMedium) to: \(signUpResult.codeDeliveryDetails!.destination!)",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel) { _ in
                guard let username = self.userNameTxtField.text else {
                    return
                }
                let confirmSignupViewController = ConfirmSignUpViewController(username: username, password: self.pwdTxtField.text!)
                self.navigationController?.pushViewController(confirmSignupViewController, animated: true)
            })
            
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
            
        case .unknown:
            print("Unexpected case")
        }
    }
    
    @IBAction func createAccount(_ sender: Any) {
        
        
//        let email = emailTxtField.text, !email.isEmpty,
//        let username = userNameTxtField.text, !username.isEmpty,
//        let password = pwdTxtField.text, !password.isEmpty
        
        guard let fullName = fsTxtField.text, !fullName.isEmpty else {
                
            self.fnErrLbl.isHidden = false
            self.fnImg.isHidden = false
            return
        }
        if fullName.count < 4  {
            self.presentAlertWithTitle(title: "", message: "First name should contain min 4 letters", options: "OK") {_ in
                           }
            return
        }
        guard let lsName = lnTxtField.text, !lsName.isEmpty else {
                       
                   self.lnErrLbl.isHidden = false
             self.lnImg.isHidden = false
                   return
               }
        
        guard let email = emailTxtField.text, !email.isEmpty else {
                              
                          self.emailErrLbl.isHidden = false
             self.emImg.isHidden = false
                          return
                      }
        guard let userName = userNameTxtField.text, !userName.isEmpty else {
                                     
                                 self.userErrLbl.isHidden = false
             self.usImg.isHidden = false
                                 return
                             }
        if userName.count < 4  {
            self.presentAlertWithTitle(title: "", message: "Username should contain min 4 letters", options: "OK") {_ in
                           }
            return
        }
        guard let pwd = pwdTxtField.text, !pwd.isEmpty else {
                
            self.pwdTxtField.isHidden = false
             self.pwImg.isHidden = false
            return
        }
        guard let mobile = phoneTxtField.text, !mobile.isEmpty else {
                       
                   self.phoneErrLbl.isHidden = false
             self.phImg.isHidden = false
                   return
               }
        if emailTxtField.text!.isValidEmail() == false {
            self.emailErrLbl.isHidden = false
             self.emImg.isHidden = false
            return
        }
        if pwdTxtField.text!.isValidEmail() == false {
            self.pwdErrLbl.isHidden = false
             self.pwImg.isHidden = false
            return
        }
        TraineeInfo.details.first_name = fsTxtField.text!
        TraineeInfo.details.username = userNameTxtField.text!
        TraineeInfo.details.email = emailTxtField.text!
         TraineeInfo.details.last_name = lnTxtField.text!
         TraineeInfo.details.mobile_no = phoneTxtField.text!
        TraineeInfo.details.country_code = self.countryCode1Btn.titleLabel?.text ?? ""
        DispatchQueue.main.async {
               LoadingOverlay.shared.showOverlay(view: UIApplication.shared.keyWindow!)
               }
        AWSMobileClient.sharedInstance().signUp(username: userName,
                                                password: pwd,
                                                userAttributes: ["email" : email, "name": fullName],
                                                completionHandler: signUpHandler);
    }
    
    @IBAction func dismissModal(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == fsTxtField ||  textField == lnTxtField {
            let allowedCharacters = CharacterSet(charactersIn:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz").inverted
                let components = string.components(separatedBy: allowedCharacters)
                let filtered = components.joined(separator: "")
                
                if string == filtered {
                    
                   let maxLength = 20
                    let currentString: NSString = textField.text! as NSString
                    let newString: NSString =
                        currentString.replacingCharacters(in: range, with: string) as NSString
                   
                    return newString.length <= maxLength

                } else {
                    
                    return false
                }
            }
        
        if textField == userNameTxtField || textField == pwdTxtField  {
            
            let maxLength = 20
             let currentString: NSString = textField.text! as NSString
             let newString: NSString =
                 currentString.replacingCharacters(in: range, with: string) as NSString
            
             return newString.length <= maxLength
        }
        
        if textField == phoneTxtField {
        let allowedCharacters = CharacterSet(charactersIn:"0123456789+").inverted
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
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == phoneTxtField {
          guard  let phone = phoneTxtField.text, !phone.isEmpty else {
            self.phoneErrLbl.isHidden = false
             self.phImg.isHidden = false
            self.phoneErrLbl.text = "Please enter phone number"
                return
            }
            if phone.count != 10  {
                 self.phoneErrLbl.isHidden = false
                 self.phImg.isHidden = false
                 self.phoneErrLbl.text = "Please enter 10 digit phone number"
            }else {
                self.phoneErrLbl.isHidden = true
                 self.phImg.isHidden = true
            }
        }
        if textField == emailTxtField {
          guard  let email = emailTxtField.text, !email.isEmpty else {
            self.emailErrLbl.isHidden = false
             self.emImg.isHidden = false
            self.emailErrLbl.text = "Please enter valid email"
                return
            }
            if email.isValidEmail() == false  {
                 self.emailErrLbl.isHidden = false
                 self.emImg.isHidden = false
                 self.emailErrLbl.text = "Please enter valid email"
            }else {
                self.emailErrLbl.isHidden = true
                 self.emImg.isHidden = true
            }
        }
        if textField == pwdTxtField {
          guard  let pwd = pwdTxtField.text, !pwd.isEmpty else {
            self.pwdErrLbl.isHidden = false
             self.pwImg.isHidden = false
            //self.emailErrLbl.text = "Please enter valid email"
                return
            }
            if pwd.isValidPassword() == false  {
                 self.pwdErrLbl.isHidden = false
                 self.pwImg.isHidden = false
                // self.emailErrLbl.text = "Please enter valid email"
                self.signUpBtn.isEnabled = false
            }else {
                self.pwdErrLbl.isHidden = true
                 self.pwImg.isHidden = true
                self.signUpBtn.isEnabled = true
            }
        }
        if textField == fsTxtField {
          guard  let name = fsTxtField.text, !name.isEmpty else {
            self.fnErrLbl.isHidden = false
             self.fnImg.isHidden = false
           // self.emailErrLbl.text = "Please enter valid email"
               return
            }
            
             self.fnErrLbl.isHidden = true
             self.fnImg.isHidden = true
        }
        if textField == lnTxtField {
          guard  let name = lnTxtField.text, !name.isEmpty else {
            self.lnErrLbl.isHidden = false
             self.lnImg.isHidden = false
           // self.emailErrLbl.text = "Please enter valid email"
                return
            }
            self.lnErrLbl.isHidden = true
             self.lnImg.isHidden = true
        }
        if textField == userNameTxtField {
            guard  let name = userNameTxtField.text, !name.isEmpty else {
                self.userErrLbl.isHidden = false
                 self.usImg.isHidden = false
                // self.emailErrLbl.text = "Please enter valid email"
                return
            }
            self.userErrLbl.isHidden = true
             self.usImg.isHidden = true
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
         if textField == phoneTxtField {
             self.phoneErrLbl.isHidden = true
            self.phImg.isHidden = true
        }
        if textField == emailTxtField {
             self.emailErrLbl.isHidden = true
             self.emImg.isHidden = true
        }
        if textField == pwdTxtField {
                    self.pwdErrLbl.isHidden = true
             self.pwImg.isHidden = true
               }
        if textField == fsTxtField {
                           self.fnErrLbl.isHidden = true
             self.fnImg.isHidden = true
                      }
        if textField == lnTxtField {
                                  self.lnErrLbl.isHidden = true
             self.lnImg.isHidden = true
                             }
        if textField == userNameTxtField {
                                         self.userErrLbl.isHidden = true
             self.usImg.isHidden = true
                                    }
    }
}
