//
//  RegistrationViewController.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 23/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//


import UIKit
import AWSMobileClient
import AWSCognitoIdentityProvider
import AWSAuthCore
import AWSCore
import Alamofire
class ConfirmSignUpViewController: UIViewController {
    
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var verificationCodeTextField: UITextField! 
    var username: String?
    var password: String?
    init(username: String,password: String, nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        self.username = username
        self.password = password
        super.init(nibName:nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        self.bgView.layer.cornerRadius = 20.0
        self.bgView.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
        
//        self.verificationCodeTextField.layer.cornerRadius = 25.0
//        self.verificationCodeTextField.backgroundColor = UIColor.init(red: 41/255, green: 37/255, blue: 37/255, alpha: 1.0)
        self.verificationCodeTextField.textColor = UIColor.white
        
//        self.verifyBtn.layer.cornerRadius = 8.0
//        self.verifyBtn.backgroundColor = AppColours.Btngreen
        
        self.verificationCodeTextField.attributedPlaceholder = NSAttributedString(string: "Confirmation Code",
                                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
         self.hideKeyboardWhenTappedAround()
    }
    
    func resendSignUpHandler(result: SignUpResult?, error: Error?) {
        if let error = error {
            print("\(error)")
            return
        }
        
        guard let signUpResult = result else {
            return
        }
        
        let message = "A verification code has been sent via \(signUpResult.codeDeliveryDetails!.deliveryMedium) at \(signUpResult.codeDeliveryDetails!.destination!)"
        let alert = UIAlertController(title: "Code Sent",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { _ in
            //Cancel Action
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func resendCode(_ sender: Any) {
        guard let username = self.username , !username.isEmpty else {
            print("No username")
            return
        }
        
        AWSMobileClient.sharedInstance().resendSignUpCode(username: username,
                                                          completionHandler: resendSignUpHandler)
    }
    
    func handleConfirmation(signUpResult: SignUpResult?, error: Error?) {
        
        DispatchQueue.main.async {
            LoadingOverlay.shared.hideOverlayView()
        }
        if let error = error {
             DispatchQueue.main.async {
                
                self.presentAlertWithTitle(title: "Error", message: "Please enter valid confirmation code", options: "OK") {_ in
            }
            }
            return
        }
        
        guard let signUpResult = signUpResult else {
            return
        }
        
        switch(signUpResult.signUpConfirmationState) {
        case .confirmed:
            print("User is signed up and confirmed.")
            self.loginUser(username: username!, password: password!)
          
        case .unconfirmed:
            print("User is not confirmed and needs verification via \(signUpResult.codeDeliveryDetails!.deliveryMedium) sent at \(signUpResult.codeDeliveryDetails!.destination!)")
        case .unknown:
            print("Unexpected case")
        }
    }
    func loginUser(username:String, password: String) {
        
        DispatchQueue.main.async {
                   LoadingOverlay.shared.showOverlay(view: UIApplication.shared.keyWindow!)
               }
        AWSMobileClient.sharedInstance().signIn(username: username, password: password) {
            (signInResult, error) in
            if let error = error  {
                 DispatchQueue.main.async {
                     LoadingOverlay.shared.hideOverlayView()
                self.presentAlertWithTitle(title: "Error", message: "\(error.localizedDescription)", options: "OK") {_ in
                }
                }
                return
            }
            
            guard let signInResult = signInResult else {
                DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                }
                return
            }
            
            switch (signInResult.signInState) {
            case .signedIn:
                print("User is signed in.")
                 DispatchQueue.main.async {
                    self.getUserAttributes() }
            case .newPasswordRequired:
                print("User needs a new password.")
            default:
                print("Sign In needs info which is not et supported.")
            }
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
        }
    }
    func getUserAttributes() {
        
        AWSMobileClient.sharedInstance().getTokens { (tokens, error) in
            if let error = error {
                print("Error getting token \(error.localizedDescription)")
            } else if let tokens = tokens {
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
                self.postBasicTraineeDetails()
            }
        }
    }
    func postBasicTraineeDetails() {
        //        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        //        var authenticatedHeaders: [String: String] {
        //            [
        //                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
        //                HeadersKeys.contentType: HeaderValues.json
        //            ]
        //        }
        //        let traineeId = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!
        //        let postBody : [String: Any] = ["first_name": TraineeInfo.details.first_name,"trainee_id":traineeId,"email": TraineeInfo.details.email,"trainee_profile_staus": "registered","username": TraineeInfo.details.username,"address_submission": false, "profile_submission":false, "user_type":"trial", "created_on": Date.getCurrentDate() ,"updated_on":Date.getCurrentDate(),"last_name": TraineeInfo.details.last_name,"mobile_no": TraineeInfo.details.mobile_no]
        //
        //        let urlString = postTraineeDetails
        //        guard let url = URL(string: urlString) else {return}
        //        var request        = URLRequest(url: url)
        //        request.httpMethod = "POST"
        //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.setValue("\(HeaderValues.token) \(token!) ", forHTTPHeaderField: "Authorization")
        //        do {
        //            request.httpBody   = try JSONSerialization.data(withJSONObject: postBody)
        //        } catch let error {
        //            print("Error : \(error.localizedDescription)")
        //        }
        //        Alamofire.request(request).responseJSON{ (response) in
        //
        //            print("response is \(response)")
        //            DispatchQueue.main.async {
        //                LoadingOverlay.shared.hideOverlayView()
        //            }
        //
        //            if let status = response.response?.statusCode {
        //                switch(status){
        //                case 200:
        //                    DispatchQueue.main.async {
        //                         self.navigateToProfile()
        //                    }
        //                default:
        //                    DispatchQueue.main.async {
        //                        self.presentAlertWithTitle(title: "User registration failure", message: "Please try again after sometime", options: "OK") { (option) in
        //                        }
        //                    }
        //                }
        //            }
        //        }
        TraineeRegister.postBasicTraieeDetails(userType: "", successHandler: { (message) in
             DispatchQueue.main.async {
                           if message.count > 0 {
                               self.presentAlertWithTitle(title: "", message: message, options: "OK") { (option) in
                                DispatchQueue.main.async {
                                let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
                                let controller = storyboard.instantiateViewController(withIdentifier: "loginVC")
                                self.navigationController?.pushViewController(controller, animated: true)
                                }
                               }
                           }else {
                            DispatchQueue.main.async {
                               self.navigateToProfile(isNormalLogin: true)
                            }
                               
                           }
                       }
        }) { (error) in
            DispatchQueue.main.async {
                self.presentAlertWithTitle(title: "User registration failure", message: "Please try again after sometime", options: "OK") { (option) in
                }
            }
        }
        
//        TraineeRegister.postBasicTraieeDetails(userType: "registered") { (message) in
//            DispatchQueue.main.async {
//                if message.count > 0 {
//                    self.presentAlertWithTitle(title: "", message: message, options: "OK") { (option) in
//                    }
//                }else {
//                    self.navigateToProfile()
//
//                }
//            }
//
//        }, errorHandler: { (error) in
//            DispatchQueue.main.async {
//                self.presentAlertWithTitle(title: "User registration failure", message: "Please try again after sometime", options: "OK") { (option) in
//                }
//            }
//        }

//        TraineeRegister.postBasicTraieeDetails { (message) in
//            DispatchQueue.main.async {
//                if message.count > 0 {
//                    self.presentAlertWithTitle(title: "", message: message, options: "OK") { (option) in
//                    }
//                }else {
//                    self.navigateToProfile()
//
//                }
//            }
//
//        } errorHandler: { (error) in
//            DispatchQueue.main.async {
//                self.presentAlertWithTitle(title: "User registration failure", message: "Please try again after sometime", options: "OK") { (option) in
//                }
//            }
//        }
 
    }
    func navigateToProfile(isNormalLogin:Bool) {
        
        if isNormalLogin == true {
            let userdefaults = UserDefaults.standard
               if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin){
                userdefaults.removeObject(forKey: UserDefaultsKeys.guestLogin)
            }
            userdefaults.set(UserDefaultsKeys.authUser, forKey:UserDefaultsKeys.guestLogin)
            userdefaults.set(self.username, forKey:UserDefaultsKeys.userName)
            userdefaults.set(self.password, forKey:UserDefaultsKeys.password)
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
    //Mark -----  Adding user to user group after confirmation is success
    private func addUserToUserGroup()
    {
        let staticCredentialProvider = AWSStaticCredentialsProvider.init(accessKey: UserPoolCredentials.accessKey, secretKey: UserPoolCredentials.secretKey)
        let configuration = AWSServiceConfiguration.init(region: .USEast2, credentialsProvider: staticCredentialProvider)
        AWSServiceManager.default()?.defaultServiceConfiguration = configuration
        let request = AWSCognitoIdentityProviderAdminAddUserToGroupRequest()
        request?.groupName = UserPoolCredentials.groupName
        request?.userPoolId = UserPoolCredentials.userPoolId
        request?.username = self.username!
        
        AWSCognitoIdentityProvider.default().adminAddUser(toGroup: request!).continueWith { (task) -> Any? in
            DispatchQueue.main.async(execute: {
                if let error = task.error {
                    print("\(error.localizedDescription)")
                }
                else
                {
                    print("user is added \(task)")
                    AWSUserSingleton.shared.getUserattributes() // To get user attribute values
                     let storyboard = UIStoryboard(name: "StartVC", bundle: nil)
                           let controller = storyboard.instantiateViewController(withIdentifier: "startVC") as! StartViewController
                           self.navigationController?.pushViewController(controller, animated: true)
                }
            })
        }
        
    }
    @IBAction func confirmSignUp(_ sender: Any) {
        
       
        
        guard let verificationCode = verificationCodeTextField.text, !verificationCode.isEmpty,
            let username = self.username, !username.isEmpty else {
                self.presentAlertWithTitle(title: "", message: "Please enter verification code", options: "OK") {_ in
                                                             }
                return
        }
        DispatchQueue.main.async {
            LoadingOverlay.shared.showOverlay(view: UIApplication.shared.keyWindow!)
        }
        AWSMobileClient.sharedInstance().confirmSignUp(username: username,
                                                       confirmationCode: verificationCode,
                                                       completionHandler: handleConfirmation)
    }
    
    @IBAction func dismissModal(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension ConfirmSignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
