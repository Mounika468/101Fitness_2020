//
//  ChangePasswordVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 24/11/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import AWSMobileClient

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var cpBtn: UIButton!
    @IBOutlet weak var confirmPView: UIView!
    @IBOutlet weak var confirmTxtField: UITextField!
    @IBOutlet weak var cpView: UIView!
    @IBOutlet weak var npTxtField: UITextField!
    @IBOutlet weak var npView: UIView!
    @IBOutlet weak var cpTxtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.confirmPView.layer.cornerRadius = 20.0
        self.confirmPView.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
        
        self.npView.layer.cornerRadius = 20.0
        self.npView.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
        
        self.cpView.layer.cornerRadius = 20.0
        self.cpView.backgroundColor = UIColor.init(red: 91/255, green: 91/255, blue: 91/255, alpha: 0.5)
        
        
        self.cpTxtField.textColor = UIColor.white
        self.cpTxtField.attributedPlaceholder = NSAttributedString(string: "Current Password",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        self.npTxtField.textColor = UIColor.white
        self.npTxtField.attributedPlaceholder = NSAttributedString(string: "New Password",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        self.confirmTxtField.textColor = UIColor.white
        self.confirmTxtField.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        self.navigationController?.isNavigationBarHidden = false
        xBarHeight = (navigationController?.navigationBar.frame.maxY)!
        let  navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight))
        navigationView.titleLbl.text = "Change Password"
        navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.addBtn.isHidden = true
        navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        
        self.view.addSubview(navigationView)
        self.navigationController?.isNavigationBarHidden = true
        self.hideKeyboardWhenTappedAround()
        
        
        
    }
    
    @objc func backBtnTapped(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func changePwdBtnTapped(_ sender: Any) {
        guard let cPassword = cpTxtField.text, !cPassword.isEmpty ,
                      let newPassword = npTxtField.text, !newPassword.isEmpty ,
                      let confirmPassword = confirmTxtField.text, !confirmPassword.isEmpty else {
            self.presentAlertWithTitle(title: "", message: "Please enter all the input fields", options: "OK") { (_) in
                
            }
            return
        }
        if newPassword != confirmPassword {
            self.presentAlertWithTitle(title: "", message: "New password and confirm password didn't match", options: "OK") { (_) in
                
            }
            return
        }
        DispatchQueue.main.async {
            LoadingOverlay.shared.showOverlay(view: UIApplication.shared.keyWindow!)
        }
        
        AWSMobileClient.sharedInstance().changePassword(currentPassword: cPassword, proposedPassword: newPassword) { (error) in
            if let error = error {
                            print("Error getting token \(error.localizedDescription)")
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                }
                self.presentAlertWithTitle(title: "Error", message: "\(error.localizedDescription)", options: "OK") { (_) in
                    
                }
            }else {
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                }
                let userdefaults = UserDefaults.standard
                userdefaults.removeObject(forKey: UserDefaultsKeys.guestLogin)
                userdefaults.removeObject(forKey: UserDefaultsKeys.userName)
                userdefaults.removeObject(forKey: UserDefaultsKeys.password)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "LandingVC")
            self.navigationController?.pushViewController(controller, animated: true)
            }
            
        }
        
    }
}
extension ChangePasswordVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
