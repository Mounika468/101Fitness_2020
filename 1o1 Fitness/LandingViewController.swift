//
//  LandingViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 22/04/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
import UIKit
import AWSMobileClient

final class LandingViewController : BaseViewController {
    var rightCount : Int = 0
       var leftCount : Int = 0
    @IBOutlet weak var leftBtn: UIButton!
    
    @IBOutlet weak var exploreBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var singupBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var centreImgView: UIImageView!
     var isLoading : Bool = false
    let ciImages = [
        UIImage(named: "b_exercise"),
        UIImage(named: "b_zumba"),
        UIImage(named: "b_zumba")
    ]
    var timer: Timer?
    var leftTimer: Timer?
    var rightTimer: Timer?
    var duration : Float = 0.25
    override func viewDidLoad() {
           super.viewDidLoad()

           // Do any additional setup after loading the view.
           
           self.centreImgView.image =  UIImage(named: "b_exercise")
          // setupButtonsBackgrounds()
       
        self.startImageTimer()
        NotificationCenter.default.addObserver(self, selector: #selector(backgroundHandler), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(foregroundHandler), name: UIApplication.willEnterForegroundNotification, object: nil)


       }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer?.invalidate()
        timer = nil
//        self.leftTimer?.invalidate()
//        self.rightTimer?.invalidate()
    }
    @objc func displayImgView1()
    {
        if self.centreImgView.image == UIImage(named: "b_exercise") {
            self.rightBtn.setImage(UIImage(named: "s_yoga"), for: .normal)
            self.leftBtn.setImage(UIImage(named: "s_excercise"), for: .normal)
            self.centreImgView.image = UIImage(named: "b_zumba")
        }else if self.centreImgView.image == UIImage(named: "b_zumba") {
            self.rightBtn.setImage(UIImage(named: "s_excercise"), for: .normal)
            self.leftBtn.setImage(UIImage(named: "s_zumba"), for: .normal)
            self.centreImgView.image = UIImage(named: "b_yoga")
        }else if self.centreImgView.image == UIImage(named: "b_yoga") {
            self.rightBtn.setImage(UIImage(named: "s_zumba"), for: .normal)
            self.leftBtn.setImage(UIImage(named: "s_yoga"), for: .normal)
            self.centreImgView.image = UIImage(named: "b_exercise")
        }
    }
   
    private func startImageTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector:#selector(displayImgView1), userInfo: nil, repeats: true)
        
//        imageTimer = Timer(fire: Date(), interval: 5, repeats: true) { (timer) in
//            imageView.image = images.randomElement()
//        }

        RunLoop.main.add(timer!, forMode: .common)
    }
    
   
    @objc private func backgroundHandler() {
        timer?.invalidate()
        timer = nil
    }

    @objc private func foregroundHandler() {
        startImageTimer()
    }
//       private func setupButtonsBackgrounds()
//       {
//
////           self.loginBtn.backgroundColor = UIColor(red: 10/255, green: 158/255, blue: 93/255, alpha: 1.0)
////           self.loginBtn.layer.cornerRadius = 8.0
////           self.singupBtn.backgroundColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
////           self.singupBtn.layer.cornerRadius = 8.0
////           self.exploreBtn.backgroundColor = UIColor(red: 146/255, green: 114/255, blue: 28/255, alpha: 1.0)
////           self.exploreBtn.layer.cornerRadius = 8.0
//        self.leftBtn.isHidden = false
//
//       }
    @IBAction func rightBtnTapped(_ sender: Any) {
        
        switch rightCount {
        case 0:
            self.rightBtn.setImage(UIImage(named: "s_zumba"), for: .normal)
            self.leftBtn.setImage(UIImage(named: "s_excercise"), for: .normal)
            self.centreImgView.image = UIImage(named: "b_yoga")
             rightCount = rightCount + 1
            case 1:
            self.rightBtn.setImage(UIImage(named: ""), for: .normal)
            self.leftBtn.setImage(UIImage(named: "s_yoga"), for: .normal)
            self.centreImgView.image = UIImage(named: "b_zumba")
             rightCount = 0
            leftCount = 1
        default:
        self.rightBtn.setImage(UIImage(named: "s_zumba"), for: .normal)
        self.leftBtn.setImage(UIImage(named: "s_excercise"), for: .normal)
        self.centreImgView.image = UIImage(named: "b_yoga")
        }
       
        
    }
    @IBAction func leftBtnTapped(_ sender: Any) {
        
            switch leftCount {
                   case 0:
                       self.rightBtn.setImage(UIImage(named: "s_yoga"), for: .normal)
                       self.leftBtn.setImage(UIImage(named: ""), for: .normal)
                       self.centreImgView.image = UIImage(named: "b_exercise")
                 leftCount  = leftCount + 1
                       case 1:
                       self.rightBtn.setImage(UIImage(named: "s_zumba"), for: .normal)
                       self.leftBtn.setImage(UIImage(named: "s_excercise"), for: .normal)
                       self.centreImgView.image = UIImage(named: "b_yoga")
                 leftCount  = 0
                rightCount = 0
                   default:
                   self.rightBtn.setImage(UIImage(named: "s_zumba"), for: .normal)
                   self.leftBtn.setImage(UIImage(named: "s_excercise"), for: .normal)
                   self.centreImgView.image = UIImage(named: "b_yoga")
                   }
           
    }
    func AutologinFunction(userName:String, password:String) {
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
    func loginFunction() {
        DispatchQueue.main.async {
               LoadingOverlay.shared.showOverlay(view: UIApplication.shared.keyWindow!)
               }
             let username = "guest"
               let password = "Test@123"
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
                           userdefaults.set(UserDefaultsKeys.guestLogin, forKey:UserDefaultsKeys.guestLogin)
                           
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
    @IBAction func exploreBtnTapped(_ sender: Any) {
          self.loginFunction()
//        let storyboard = UIStoryboard(name: "StartVC", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "startVC") as! StartViewController
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func signUpBtnTapped(_ sender: Any) {
        let registration = SignUpViewController(nibName:"SignUpViewController", bundle:nil)
        self.navigationController?.pushViewController(registration, animated: true)
    }
    @IBAction func loginBtnTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "loginVC")
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    func getUserattributes()
    {
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
                    print(attributesDict["sub"] as Any)
                    let subId = attributesDict["sub"]!
                    let userdefaults = UserDefaults.standard
                    if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.subId){
                        userdefaults.removeObject(forKey: UserDefaultsKeys.subId)
                    }
                    userdefaults.set(subId, forKey:UserDefaultsKeys.subId)
                }
             }
        }
    }
}
