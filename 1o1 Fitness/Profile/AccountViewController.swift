//
//  AccountViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 01/07/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import AWSMobileClient
import AWSCognitoIdentityProvider
import Alamofire
class AccountViewController: UIViewController {
    
    @IBOutlet weak var logOutView: CardView! {
        didSet {
            logOutView.layer.cornerRadius = 0.0
        }
    }
    @IBOutlet weak var deleteAccountView: CardView! {
        didSet {
            deleteAccountView.layer.cornerRadius = 0.0
        }
    }
    @IBOutlet weak var changePwdView: CardView! {
        didSet {
            changePwdView.layer.cornerRadius = 0.0
        }
    }
    @IBOutlet weak var addressView: CardView! {
        didSet {
            addressView.layer.cornerRadius = 0.0
        }
    }
    @IBOutlet weak var ordersView: CardView! {
        didSet {
            ordersView.layer.cornerRadius = 0.0
        }
    }
    @IBOutlet weak var deleteAccPriConstrain: NSLayoutConstraint!
    @IBOutlet weak var deleteAccSecConstrain: NSLayoutConstraint!
    @IBOutlet weak var logOutLbl: UILabel!
    @IBOutlet weak var deleteAccLbl: UILabel!
    @IBOutlet weak var changePwd: UILabel!
    @IBOutlet weak var bAddressLbl: UILabel!
    @IBOutlet weak var myOrdersLbl: UILabel!
    let viewTag = 10000
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Account"
        
        let orderTapGesture = UITapGestureRecognizer()
        orderTapGesture.addTarget(self, action: #selector(self.ordersViewTouched(_:)))
        ordersView.addGestureRecognizer(orderTapGesture)
        
        let addressTapGesture = UITapGestureRecognizer()
        addressTapGesture.addTarget(self, action: #selector(self.addressViewTouched(_:)))
        addressView.addGestureRecognizer(addressTapGesture)
        let changePwdTapGesture = UITapGestureRecognizer()
        changePwdTapGesture.addTarget(self, action: #selector(self.changePwdTouched(_:)))
        changePwdView.addGestureRecognizer(changePwdTapGesture)
        let deleteTapGesture = UITapGestureRecognizer()
        deleteTapGesture.addTarget(self, action: #selector(self.deleteTouched(_:)))
        deleteAccountView.addGestureRecognizer(deleteTapGesture)
        
        let logOutTapGesture = UITapGestureRecognizer()
        logOutTapGesture.addTarget(self, action: #selector(self.logOutTapGestureTouched(_:)))
        logOutView.addGestureRecognizer(logOutTapGesture)
        
        myOrdersLbl.textColor = AppColours.textGreen
        changePwd.textColor = AppColours.textGreen
        bAddressLbl.textColor = AppColours.textGreen
        deleteAccLbl.textColor = AppColours.textGreen
        logOutLbl.textColor = AppColours.textGreen
        
        print("Trainee details \( TraineeDetails.traineeDetails?.trainee_address)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //        deleteAccSecConstrain.isActive = false
        //        deleteAccPriConstrain.isActive = true
        deleteAccSecConstrain.priority = UILayoutPriority(rawValue: 500)
        deleteAccPriConstrain.priority = UILayoutPriority(rawValue: 999)
        if TraineeDetails.traineeDetails?.trainee_profile_staus == "google" {
            
            deleteAccSecConstrain.priority = UILayoutPriority(rawValue: 999)
            deleteAccPriConstrain.priority = UILayoutPriority(rawValue: 500)
            
            //            if #available(iOS 13.0, *) {
            ////                deleteAccPriConstrain.isActive = false
            ////                deleteAccSecConstrain.isActive = true
            //                deleteAccPriConstrain.priority = UILayoutPriority(rawValue: 500)
            //                deleteAccSecConstrain.priority = UILayoutPriority(rawValue: 999)
            //            } else {
            //                // Fallback on earlier versions
            //                deleteAccPriConstrain.isActive = false
            //                deleteAccSecConstrain.isActive = true
            //
            //            }
            
        }else {
            
            deleteAccSecConstrain.priority = UILayoutPriority(rawValue: 500)
            deleteAccPriConstrain.priority = UILayoutPriority(rawValue: 999)
            //            if #available(iOS 13.0, *) {
            //                deleteAccPriConstrain.isActive = true
            //                deleteAccSecConstrain.isActive = false
            //                deleteAccPriConstrain.priority = UILayoutPriority(rawValue: 999)
            //                deleteAccSecConstrain.priority = UILayoutPriority(rawValue: 500)
            //            } else {
            //                // Fallback on earlier versions
            //                deleteAccPriConstrain.isActive = true
            //                deleteAccSecConstrain.isActive = false
            //            }
        }
    }
    
    @objc func logOutTapGestureTouched(_ sender: UITapGestureRecognizer) {
        
        if TraineeDetails.traineeDetails?.trainee_profile_staus == "google" {
            AWSMobileClient.sharedInstance().signOut(options: SignOutOptions(signOutGlobally: true)) { (error) in
                print("Error: \(error.debugDescription)")
                
            }
            //self.deleteLocalUserData()
        }else {
            AWSMobileClient.sharedInstance().signOut() { error in
                if let error = error {
                    print(error)
                    return
                }else {
                    
                }
                
            }
            
        }
        self.deleteLocalUserData()
        
    }
    
    func deleteLocalUserData() {
        let userdefaults = UserDefaults.standard
        userdefaults.removeObject(forKey: UserDefaultsKeys.guestLogin)
        userdefaults.removeObject(forKey: UserDefaultsKeys.userName)
        userdefaults.removeObject(forKey: UserDefaultsKeys.password)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LandingVC")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @objc func ordersViewTouched(_ sender: UITapGestureRecognizer) {
        
        let storyboard = UIStoryboard(name: "OrdersViewController", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "OrdersViewController") as! OrdersViewController
        self.navigationController?.pushViewController(controller, animated: true)
        
        
    }
    @objc func addressViewTouched(_ sender: UITapGestureRecognizer) {
        
        let storyboard = UIStoryboard(name: "ProfileMenuVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "BillingAddressVC") as! BillingAddressVC
        controller.addressArra = TraineeDetails.traineeDetails?.trainee_address
        self.navigationController?.pushViewController(controller, animated: true)
        
        
    }
    @objc func changePwdTouched(_ sender: UITapGestureRecognizer) {
        
        let storyboard = UIStoryboard(name: "ChangePwdVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    @objc func deleteTouched(_ sender: UITapGestureRecognizer) {
        
        self.presentAlertWithTitle(title: "", message: "Are you sure want to delete your account", options: "Cancel","Done") { (option) in
            if option == 1 {
                self.processDelteUser()
            }
        }
        
        
    }
    func processDelteUser() {
        let staticCredentialProvider = AWSStaticCredentialsProvider.init(accessKey: UserPoolCredentials.accessKey, secretKey: UserPoolCredentials.secretKey)
        let configuration = AWSServiceConfiguration.init(region: .USEast2, credentialsProvider: staticCredentialProvider)
        AWSServiceManager.default()?.defaultServiceConfiguration = configuration
        
        let request = AWSCognitoIdentityProviderDeleteUserRequest()
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        request?.accessToken = token
        
        AWSCognitoIdentityUserPool.default().currentUser()?.delete().continueWith(block: { (task) -> Any? in
                   if let error = task.error {
                       print("Error deleting user: \(error.localizedDescription)")
                   }
                   if let _ = task.result {
                       print("User deleted successfully.")
                    self.deleteUserPostCall()
                   }
                   return nil
               })
    }
    func deleteUserPostCall() {
        let postBody : [String: Any] = ["first_name": TraineeDetails.traineeDetails?.first_name ?? "","last_name": TraineeDetails.traineeDetails?.last_name ?? "","created_on": Date.getCurrentDate() ,"updated_on":Date.getCurrentDate(),"user_type":"inactive","trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"username":TraineeInfo.details.username,"gender": TraineeDetails.traineeDetails?.gender ?? "","age":TraineeDetails.traineeDetails?.age ?? 0]
        DispatchQueue.main.async {
            LoadingOverlay.shared.showOverlay(view: UIApplication.shared.windows.first!)
        }
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
                                        DispatchQueue.main.async {
                                            self.deleteLocalUserData()
                                        }
                                    }else {
                                        
                                    }
                                    
                                } else {
                                    DispatchQueue.main.async {
                                        self.presentAlertWithTitle(title: "", message: "Profile Update failed", options: "OK") {_ in
                                        }
                                    }
                                }
                            } }catch let error {
                                DispatchQueue.main.async {
                                    LoadingOverlay.shared.hideOverlayView()
                                    self.presentAlertWithTitle(title: "", message: "Profile Update failed", options: "OK") {_ in
                                    }
                                }
                                
                            }
                    }
                    
                default:
                    DispatchQueue.main.async {
                        
                    }
                }
            }
        }
    }
}
