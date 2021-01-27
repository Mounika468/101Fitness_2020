//
//  LoadingViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 22/04/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
import UIKit
import AWSMobileClient

final class LoadingViewController : BaseViewController {
    @IBOutlet weak var imgView1: UIImageView!
    
    @IBOutlet weak var lblFitness: UILabel!
    @IBOutlet weak var lblZumba: UILabel!
    @IBOutlet weak var imgView3: UIImageView!
    @IBOutlet weak var lblYoga: UILabel!
    @IBOutlet weak var imgView2: UIImageView!
     var timer: Timer?
        var duration : Float = 0.25
        var count : Int = 0
    var isLoading : Bool = false
        override func viewDidLoad() {
            super.viewDidLoad()
   LocationSingleton.sharedInstance.startUpdatingLocation()
            timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector:#selector(displayImgView1), userInfo: nil, repeats: true)
            
           
        }
        
        @objc func displayImgView1()
        {
            
            switch count {
            case 0:
                 self.imgView1.alpha = 1.0
                 duration = 0.25
                case 1:
                self.lblFitness.alpha = 1.0
                duration = 0.25
                case 2:
                self.imgView2.alpha = 1.0
                duration = 0.25
                case 3:
                self.lblYoga.alpha = 1.0
                duration = 0.25
                case 4:
                self.imgView3.alpha = 1.0
                duration = 0.25
                case 5:
                self.lblZumba.alpha = 1.0
                duration = 0.25
                case 6:
                    timer?.invalidate()
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let controller = storyboard.instantiateViewController(withIdentifier: "LandingVC")
//                    self.navigationController?.pushViewController(controller, animated: true)
                    let userdefaults = UserDefaults.standard
                       if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin){
                        if savedValue == UserDefaultsKeys.authUser {
                            let userName  = userdefaults.string(forKey: UserDefaultsKeys.userName)
                            let password  = userdefaults.string(forKey: UserDefaultsKeys.password)
                            self.autologinFunction(userName: userName!, password: password!)
                        }else {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let controller = storyboard.instantiateViewController(withIdentifier: "LandingVC")
                            self.navigationController?.pushViewController(controller, animated: true)
                        }
                       // userdefaults.removeObject(forKey: UserDefaultsKeys.guestLogin)
                       }else {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "LandingVC")
                        self.navigationController?.pushViewController(controller, animated: true)
                       }
                    
               
                default:
                self.imgView1.alpha = 1.0
            }
           count = count + 1

        }
    func autologinFunction(userName:String, password:String) {
        DispatchQueue.main.async {
               LoadingOverlay.shared.showOverlay(view: UIApplication.shared.keyWindow!)
               }
             let username = userName
               let password = password
               print("\(username) and \(password)")
       
               AWSMobileClient.sharedInstance().signIn(username: username, password: password) {
                   (signInResult, error) in
                if self.isLoading == true {
                    return
                }
                       if let error = error  {
                       
                           print("There's an error : \(error.localizedDescription)")
                           print(error)
                           DispatchQueue.main.async {
                           LoadingOverlay.shared.hideOverlayView()
                           }
                        self.isLoading = true
                           return
                       }
                   
                       guard let signInResult = signInResult else {
                         self.isLoading = true
                           return
                       }
                   
                       switch (signInResult.signInState) {
                       case .signedIn:
                           print("User is signed in.")
                            self.isLoading = true
                          // self.getUserattributes() //get user attributes
                           AWSUserSingleton.shared.getUserattributes()
                           let userdefaults = UserDefaults.standard
                              if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin){
                               userdefaults.removeObject(forKey: UserDefaultsKeys.guestLogin)
                           }
                           userdefaults.set(UserDefaultsKeys.authUser, forKey:UserDefaultsKeys.guestLogin)
                        userdefaults.set(userName, forKey:UserDefaultsKeys.userName)
                        userdefaults.set(password, forKey:UserDefaultsKeys.password)
                           
                           // Navigating to Home screen
                           DispatchQueue.main.async {
                               let storyboard = UIStoryboard(name: "TabbarController", bundle: nil)
                               let controller = storyboard.instantiateViewController(withIdentifier: "tabbarController")
                               self.navigationController?.pushViewController(controller, animated: true)
                           }
                       case .newPasswordRequired:
                         self.isLoading = true
                           print("User needs a new password.")
                           DispatchQueue.main.async {
                        self.presentAlertWithTitle(title: "Error", message: "User needs a new password.", options: "OK") {_ in
                                       }
                        }
                       default:
                         self.isLoading = true
                           print("Sign In needs info which is not et supported.")
                       }
                  DispatchQueue.main.async {
                   LoadingOverlay.shared.hideOverlayView()
                   }
               }
    }

    func checkIfUserLoggedIn()
    {
        
        let userdefaults = UserDefaults.standard
           if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin){
            if savedValue == UserDefaultsKeys.authUser {
                let userName  = userdefaults.string(forKey: UserDefaultsKeys.userName)
                let password  = userdefaults.string(forKey: UserDefaultsKeys.password)
                self.autologinFunction(userName: userName!, password: password!)
            }
//        AWSMobileClient.sharedInstance().initialize { (userState, error) in
//                 if let error = error {
//                     print("error: \(error.localizedDescription)")
//                     return
//                 }
//
//                 guard let userState = userState else {
//                     return
//                 }
//
//                 print("The user is \(userState.rawValue).")
//
//           // let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.idToken)
//            if UserDefaults.standard.string(forKey: UserDefaultsKeys.idToken) != nil {
//
//                // Check if user availability
//                switch userState {
//                case .signedIn:
//
//                    AWSUserSingleton.shared.getUserattributes() // To get user attribute values
//                    // Show home page
//                    DispatchQueue.main.async {
//                         LoadingOverlay.shared.hideOverlayView()
//                        let storyboard = UIStoryboard(name: "TabbarController", bundle: nil)
//                        let controller = storyboard.instantiateViewController(withIdentifier: "tabbarController")
//                        self.navigationController?.pushViewController(controller, animated: true)
//                    }
//                    break
//
//                default:
//                    // Show login page
//                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                   let controller = storyboard.instantiateViewController(withIdentifier: "LandingVC")
//                   self.navigationController?.pushViewController(controller, animated: true)
//                    break
//                }
//            }
//            else
//            {
//                AWSUserSingleton.shared.getUserattributes()
//                 DispatchQueue.main.async {
//                // Show login page
//                              let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                              let controller = storyboard.instantiateViewController(withIdentifier: "LandingVC")
//                              self.navigationController?.pushViewController(controller, animated: true)
//                }
//            }
//
//             }
        }
    }

}
