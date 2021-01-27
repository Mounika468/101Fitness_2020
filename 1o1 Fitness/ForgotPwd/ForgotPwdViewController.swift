//
//  ForgotPwdViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 29/10/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import AWSMobileClient

class ForgotPwdViewController: UIViewController {

    @IBOutlet weak var bgViewPwd: UIView!
    @IBOutlet weak var bgViewVerify: UIView!
    @IBOutlet weak var verificationCode: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    var username: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.bgViewPwd.layer.cornerRadius = 20.0
        self.bgViewPwd.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
        
        self.bgViewVerify.layer.cornerRadius = 20.0
        self.bgViewVerify.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
        
        
        self.verificationCode.textColor = UIColor.white
        self.verificationCode.attributedPlaceholder = NSAttributedString(string: "Confirmation Code",
                                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        self.pwdField.textColor = UIColor.white
        self.pwdField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
         self.hideKeyboardWhenTappedAround()
    }
    

    @IBAction func setPwdTapped(_ sender: Any) {
        guard let username = username,
                      let newPassword = pwdField.text,
                      let confirmationCode = verificationCode.text else {
                      return
                  }
                  
       
        LoadingOverlay.shared.showOverlay(view: UIApplication.shared.keyWindow!)
                  AWSMobileClient.sharedInstance().confirmForgotPassword(username: username,
                                                                         newPassword: newPassword,
                                                                         confirmationCode: confirmationCode) { (forgotPasswordResult, error) in
                      if let forgotPasswordResult = forgotPasswordResult {
                          switch(forgotPasswordResult.forgotPasswordState) {
                          case .done:
                             // self.dismiss(self)
                            DispatchQueue.main.async {
                                let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
                                let controller = storyboard.instantiateViewController(withIdentifier: "loginVC")
                                self.navigationController?.pushViewController(controller, animated: true)
                            }
                          default:
                            DispatchQueue.main.async {
                                LoadingOverlay.shared.hideOverlayView()
                           self.presentAlertWithTitle(title: "", message: "Could not change password", options: "OK") {_ in
                           }
                           }
                           return
                          }
                      } else if let error = error {
                          print("Error occurred: \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            LoadingOverlay.shared.hideOverlayView()
                       self.presentAlertWithTitle(title: "Error", message: "\(error.localizedDescription)", options: "OK") {_ in
                       }
                       }
                       return
                      }
                  }
        DispatchQueue.main.async {
            LoadingOverlay.shared.hideOverlayView()
        }
    }
    

}
