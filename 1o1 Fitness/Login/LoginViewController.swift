//
//  LoginViewController.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 10/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import AWSMobileClient
import GoogleSignIn
import AWSCognitoIdentityProvider
import AWSCognitoIdentityProviderASF

let clientId = "159288171675-jspj4r7mknq403n5h4iu9do07f8lfcrk.apps.googleusercontent.com"
class LoginViewController: UIViewController {
    
   
    @IBOutlet weak var pwImg: UIImageView!
    @IBOutlet weak var usImg: UIImageView!
    @IBOutlet weak var pwdErrLbl: UILabel!
    @IBOutlet weak var userErrLbl: UILabel!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var forgotPwdBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var pwdtxtField: UITextField!
    var password: String = ""
    var userName: String = ""
    var isLoading : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        self.emailView.layer.cornerRadius = 20.0
        self.emailView.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
        
        self.passwordView.layer.cornerRadius = 20.0
        self.passwordView.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
        
        setupButtonsBackgrounds()
         self.hideKeyboardWhenTappedAround()
        GIDSignIn.sharedInstance().clientID = clientId
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
//        
//        // Automatically sign in the user.
//        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        AWSMobileClient.sharedInstance().signOut() { error in
            if let error = error {
                print(error)
                return
            }else {
                
            }
            
        }
        
    }
    @IBAction func googleSignInTapped(_ sender: Any) {
        
        
        AWSMobileClient.sharedInstance().signOut(options: SignOutOptions(signOutGlobally: true)) { (error) in
            print("Error: \(error.debugDescription)")
            
        }
        let hostedUIOptions = HostedUIOptions(scopes: ["openid","email","profile","aws.cognito.signin.user.admin"], identityProvider: "Google")
        
        // Present the Hosted UI sign in.
        AWSMobileClient.sharedInstance().showSignIn(navigationController: self.navigationController!, hostedUIOptions: hostedUIOptions) { (userState, error) in
            if let error = error as? AWSMobileClientError {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                self.presentAlertWithTitle(title: "", message: "\(error.localizedDescription)", options: "OK") { (option) in
                    self.isLoading = false
                    return
                }
                }
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
    func navigateToProfile(isNormalLogin:Bool) {
        if isNormalLogin == true {
            let userdefaults = UserDefaults.standard
               if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin){
                userdefaults.removeObject(forKey: UserDefaultsKeys.guestLogin)
            }
            
            userdefaults.set(UserDefaultsKeys.authUser, forKey:UserDefaultsKeys.guestLogin)
           userdefaults.set(userName, forKey:UserDefaultsKeys.userName)
           userdefaults.set(password, forKey:UserDefaultsKeys.password)
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
    @IBAction func forgotBtnTapped(_ sender: Any) {
        
        guard let username = emailTxtField.text, !username.isEmpty else {
            
            self.presentAlertWithTitle(title: "", message: "Please enter username", options: "OK") {_ in
                
                           }
            return
        }
        LoadingOverlay.shared.showOverlay(view: UIApplication.shared.keyWindow!)
        
        AWSMobileClient.sharedInstance().forgotPassword(username: username) { (forgotPasswordResult, error) in
                        if let forgotPasswordResult = forgotPasswordResult {
                            switch(forgotPasswordResult.forgotPasswordState) {
                            case .confirmationCodeSent:
                                guard let codeDeliveryDetails = forgotPasswordResult.codeDeliveryDetails else {
                                    DispatchQueue.main.async {
                                        LoadingOverlay.shared.hideOverlayView()
                                    }
                                    return
                                }
                                                                
                                DispatchQueue.main.async {
                                    LoadingOverlay.shared.hideOverlayView()
                                    self.presentAlertWithTitle(title: "Code sent", message: "Confirmation code sent via \(codeDeliveryDetails.deliveryMedium) to: \(codeDeliveryDetails.destination!)", options: "OK") { (_) in
                                        let registration = ForgotPwdViewController(nibName:"ForgotPwdViewController", bundle:nil)
                                        registration.username = username
                                        self.navigationController?.pushViewController(registration, animated: true)
                                    }
                                }
                                
                            default:
                                print("Error: Invalid case.")
                                DispatchQueue.main.async {
                                    LoadingOverlay.shared.hideOverlayView()
                                self.presentAlertWithTitle(title: "Error", message: "Can't perform the operation. PLease try after sometime", options: "OK") { (_) in
                                    
                                }
                                }
                            }
                        } else if let error = error {
                            print("Error occurred: \(error.localizedDescription)")
                            DispatchQueue.main.async {
                                LoadingOverlay.shared.hideOverlayView()
                            self.presentAlertWithTitle(title: "Error", message: "\(error.localizedDescription)", options: "OK") { (_) in
                                
                            }
                            }
                        }
                    }
       
    }
 
    @IBAction func loginBtnTapped(_ sender: Any) {
//        self.emailTxtField.text = "trainee7"
//        self.pwdtxtField.text = "Test@123"

        guard let username = emailTxtField.text, !username.isEmpty else {
            
            self.userErrLbl.isHidden = false
             self.usImg.isHidden = false
            return
        }
        if username.count < 4  {
            self.presentAlertWithTitle(title: "", message: "Username should contain min 4 letters", options: "OK") {_ in
                           }
            return
        }
        guard  let password = pwdtxtField.text , !password.isEmpty else {
            
            self.pwdErrLbl.isHidden = false
             self.pwImg.isHidden = false
            return
        }
        if password.isValidPassword() == false {
            self.pwdErrLbl.isHidden = false
             self.pwImg.isHidden = false
                       return
        }
        DispatchQueue.main.async {
            LoadingOverlay.shared.showOverlay(view: UIApplication.shared.keyWindow!)
        }
        
        print("\(username) and \(password)")
        self.userName = username
        self.password = password
        AWSMobileClient.sharedInstance().signIn(username: username, password: password) {
            
            (signInResult, error) in
            if self.isLoading == true {
                return
            }
            if let error = error as? AWSMobileClientError {
                
                switch(error) {
                case .userNotConfirmed(let message):
                    DispatchQueue.main.async {
                        LoadingOverlay.shared.hideOverlayView()
                        self.presentAlertWithTitle(title: "User Not Confirmed", message: "\(message)", options: "OK") {_ in
                            self.isLoading = false
                            let confirmSignupViewController = ConfirmSignUpViewController(username: username, password: password)
                            self.navigationController?.pushViewController(confirmSignupViewController, animated: true)
                        }
                    }
                    
                default:
                    DispatchQueue.main.async {
                        LoadingOverlay.shared.hideOverlayView()
                        self.presentAlertWithTitle(title: "Error", message: "\(error.localizedDescription)", options: "OK") {_ in
                            self.isLoading = false
                        }
                    }
                    return
                    
                }
                
               
            }
            
            guard let signInResult = signInResult else {
                self.isLoading = false
                return
            }
            
            switch (signInResult.signInState) {
            case .signedIn:
                print("User is signed in.")
                 self.isLoading = true
                self.getUserAttributes()
               
            case .newPasswordRequired:
                print("User needs a new password.")
                   DispatchQueue.main.async {
                                     self.presentAlertWithTitle(title: "Error", message: "User needs a new password.", options: "OK") {_ in
                                                    }
                                     }
                 self.isLoading = true
            default:
                print("Sign In needs info which is not et supported.")
                 self.isLoading = true
            }
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
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
                TraineeInfo.details.country_code =  ""
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
    func getUserAttributes() {
        
        AWSMobileClient.sharedInstance().getTokens { (tokens, error) in
            if let error = error {
                print("Error getting token \(error.localizedDescription)")
            } else if let tokens = tokens {
                print(" getting email \(tokens.idToken?.claims?["email"])")
                
                print(tokens.accessToken!.tokenString!)
                let userdefaults = UserDefaults.standard
                if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.accessToken){
                    userdefaults.removeObject(forKey: UserDefaultsKeys.accessToken)
                }
                userdefaults.set(tokens.accessToken!.tokenString!, forKey:UserDefaultsKeys.accessToken)
            }
        }
       
        AWSMobileClient.sharedInstance().getUserAttributes { (attributes, error) in
            if(error != nil){
                print("ERROR: \(error?.localizedDescription)")
            }else{
                if let attributesDict = attributes{
                    print(attributesDict["sub"])
                    let userdefaults = UserDefaults.standard
                    if userdefaults.string(forKey: UserDefaultsKeys.subId) != nil{
                        userdefaults.removeObject(forKey: UserDefaultsKeys.subId)
                    }
                    userdefaults.set(attributesDict["sub"], forKey:UserDefaultsKeys.subId)
                    if userdefaults.string(forKey: UserDefaultsKeys.name) != nil{
                        userdefaults.removeObject(forKey: UserDefaultsKeys.name)
                    }
                    userdefaults.set(attributesDict["name"], forKey:UserDefaultsKeys.name)
                    if userdefaults.string(forKey: UserDefaultsKeys.email) != nil{
                        userdefaults.removeObject(forKey: UserDefaultsKeys.email)
                    }
                    userdefaults.set(attributesDict["email"], forKey:UserDefaultsKeys.email)
                }
                self.navigateToProfile(isNormalLogin: true)
            }
        }
    }
    @IBAction func registerBtnTapped(_ sender: Any) {
        
        let registration = SignUpViewController(nibName:"SignUpViewController", bundle:nil)
        self.navigationController?.pushViewController(registration, animated: true)
    }

    private func setupButtonsBackgrounds()
    {
        
//        self.loginBtn.backgroundColor = COLORCODES.green
//        self.loginBtn.layer.cornerRadius = 8.0
        
        self.emailTxtField.attributedPlaceholder = NSAttributedString(string: "Username",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.pwdtxtField.attributedPlaceholder = NSAttributedString(string: "Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        googleBtn.layer.cornerRadius = 15.0
        googleBtn.layer.borderColor = AppColours.greenBorder.cgColor
        googleBtn.layer.borderWidth = 1.0
        self.emailTxtField.autocorrectionType = .yes
       
    }
    
}

extension UITextField {
func setIcon(_ image: UIImage) {
   let iconView = UIImageView(frame:
                  CGRect(x: 5, y: 2, width: 20, height: 15))
   iconView.image = image
   let iconContainerView: UIView = UIView(frame:
                  CGRect(x: 10, y: 0, width: 30, height: 20))
   iconContainerView.addSubview(iconView)
   leftView = iconContainerView
   leftViewMode = .always
}
}


extension LoginViewController: UITextFieldDelegate,GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
               withError error: Error!) {
       if let error = error {
         if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
           print("The user has not signed in before or they have since signed out.")
         } else {
           print("\(error.localizedDescription)")
         }
         return
       }
       // Perform any operations on signed in user here.
       let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken! // Safe to send to the server
       let fullName = user.profile.name
       let givenName = user.profile.givenName
       let familyName = user.profile.familyName
       let email = user.profile.email
       // ...
        
        
        AWSMobileClient.sharedInstance().federatedSignIn(providerName: IdentityProvider.google.rawValue,
                                                  token: idToken) { userState, error in
            if let error = error {
                print("Error in federatedSignIn: \(error)")
                return
            }

            guard let userState = userState else {
                print("userState unexpectedly nil")
                return
            }

            print("federatedSignIn successful: \(userState)")
        }
     }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.loginBtnTapped(self.loginBtn as Any)
        return true
    }
     func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == pwdtxtField {
          guard  let pwd = pwdtxtField.text, !pwd.isEmpty else {
            self.pwdErrLbl.isHidden = false
             self.pwImg.isHidden = false
            //self.emailErrLbl.text = "Please enter valid email"
                return
            }
            if pwd.isValidPassword() == false  {
                 self.pwdErrLbl.isHidden = false
                 self.pwImg.isHidden = false
            }
        }
         if textField == emailTxtField {
             self.userErrLbl.isHidden = true
             self.usImg.isHidden = true
        }
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
            if textField == pwdtxtField {
                        self.pwdErrLbl.isHidden = true
                 self.pwImg.isHidden = true
                   }
        if textField == emailTxtField {
                               self.userErrLbl.isHidden = true
             self.usImg.isHidden = true
                          }
   
        }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == emailTxtField  {
            
            let maxLength = 20
             let currentString: NSString = textField.text! as NSString
             let newString: NSString =
                 currentString.replacingCharacters(in: range, with: string) as NSString
            
             return newString.length <= maxLength
        }
     
      return true
    }
}
