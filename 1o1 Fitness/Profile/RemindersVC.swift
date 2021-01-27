//
//  RemindersVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 13/07/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import Alamofire

class RemindersVC: UIViewController {

    @IBOutlet weak var weightSwitch: UISwitch!
    @IBOutlet weak var exerciseSwitch: UISwitch!
    @IBOutlet weak var drinkSwitch: UISwitch!
    @IBOutlet weak var mealSwitch: UISwitch!
    @IBOutlet weak var mainSwitch: UISwitch!
    @IBOutlet weak var weightView: CardView!
    @IBOutlet weak var exerciseView: CardView!
    @IBOutlet weak var waterView: CardView!
    @IBOutlet weak var mealView: CardView!
    var reminders: Reminders?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Reminders"
        
        let    mealTapGesture = UITapGestureRecognizer()
           mealTapGesture.addTarget(self, action: #selector(self.mealsViewTouched(_:)))
           mealView.addGestureRecognizer(mealTapGesture)
        
        let   waterTapGesture = UITapGestureRecognizer()
          waterTapGesture.addTarget(self, action: #selector(self.waterViewTouched(_:)))
          waterView.addGestureRecognizer(  waterTapGesture)
        let  exerciseTapGesture = UITapGestureRecognizer()
         exerciseTapGesture.addTarget(self, action: #selector(self.exerciseTouched(_:)))
         exerciseView.addGestureRecognizer( exerciseTapGesture)
        let  weightTapGesture = UITapGestureRecognizer()
         weightTapGesture.addTarget(self, action: #selector(self.weightViewTouched(_:)))
        weightView.addGestureRecognizer( weightTapGesture)
//        mainSwitch.thumbTintColor = UIColor(patternImage:UIImage(named:"onSwitch")!)
//        mealSwitch.thumbTintColor = UIColor(patternImage:UIImage(named:"smeal")!)
//        drinkSwitch.thumbTintColor = UIColor(patternImage:UIImage(named:"swater")!)
//        weightSwitch.thumbTintColor = UIColor(patternImage:UIImage(named:"sweight")!)
//        exerciseSwitch.thumbTintColor = UIColor(patternImage:UIImage(named:"sexercise")!)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getReminders()
        
    }
    func updateswitches() {
        
    }
    @IBAction func weightSwitchChanged(_ sender: Any) {
        
    }
    @IBAction func exerciseSwitchChanged(_ sender: Any) {
    }
    @IBAction func drinkSwitchChanged(_ sender: Any) {
    }
    @IBAction func mealSwitchChanged(_ sender: Any) {
    }
    @IBAction func mainSwitchChanged(_ sender: Any) {
        if mainSwitch.isOn {
            print ("switch is off")
        }else {
            print ("switch is on")
        }
    }
    
    @objc func weightViewTouched(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc func exerciseTouched(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc func waterViewTouched(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc func mealsViewTouched(_ sender: UITapGestureRecognizer) {
//        let storyboard = UIStoryboard(name: "MealEditViewController", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "MealEditViewController")
//        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        self.postRemiders()
    }
    //get reminders
    func getReminders() {
        let window = UIApplication.shared.windows.first!
        DispatchQueue.main.async {
            LoadingOverlay.shared.showOverlay(view: window)
        }
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        RemindersAPI.getRemindersCall(header: authenticatedHeaders) {[weak self] (reminders) in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                print(" reminders \(reminders)")
                if reminders != nil {
                    self?.mainSwitch.setOn(reminders?.meal?.isNotify ??  false, animated: true)
                    self?.weightSwitch.setOn(reminders?.weight?.isNotify ??  false, animated: true)
                    self?.drinkSwitch.setOn(reminders?.water?.isNotify ??  false, animated: true)
                    self?.mealSwitch.setOn(reminders?.meal?.isNotify ??  false, animated: true)
                    self?.exerciseSwitch.setOn(reminders?.exercise?.isNotify ??  false, animated: true)
                }
            }
        } errorHandler: {[weak self] (error) in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                self?.presentAlertWithTitle(title: "", message: "Fetching the reminders failed", options: "OK") {_ in
                    self?.mainSwitch.setOn(false, animated: true)
                    self?.weightSwitch.setOn(false, animated: true)
                    self?.drinkSwitch.setOn(false, animated: true)
                    self?.mealSwitch.setOn(false, animated: true)
                    self?.exerciseSwitch.setOn(false, animated: true)
                }
            }
        }

    }
    
    func postRemiders() {
        LoadingOverlay.shared.showOverlay(view: UIApplication.shared.windows.first!)
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
               var authenticatedHeaders: [String: String] {
                   [
                       HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                       HeadersKeys.contentType: HeaderValues.json
                   ]
               }
               if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                            ProgramDetails.programDetails.subId = id
                                        }
        let  weightReminder : [String : Any] = ["isNotify": self.weightSwitch.isOn]
        let  drinkReminder : [String : Any] = ["isNotify": self.drinkSwitch.isOn]
        let  mealReminder : [String : Any] = ["isNotify": self.mealSwitch.isOn]
        let  exerciseReminder : [String : Any] = ["isNotify": self.exerciseSwitch.isOn]
        let postBody : [String: Any] = ["trainee_id": UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"meal":mealReminder,"water":drinkReminder,"weight":weightReminder,"exercise":exerciseReminder]
                let urlString = postReminders
                guard let url = URL(string: urlString) else {return}
                var request        = URLRequest(url: url)
                request.httpMethod = "Put"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("\(HeaderValues.token) \(token!) ", forHTTPHeaderField: "Authorization")
                do {
                    request.httpBody   = try JSONSerialization.data(withJSONObject: postBody)
                } catch let error {
                    print("Error : \(error.localizedDescription)")
                }
        Alamofire.request(request).responseJSON{ (response) in
            print("response is \(response)")
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    if let json = response.result.value as? [String: Any] {
                        print("JSON: \(json)") // serialized json response
                        do {
                            if json["code"] as? Int == 0
                            {
                                if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                    if jsonDict is NSNull {
                                        
                                        if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                            messageString = (jsonMessage as? String)!
                                        }
                                        DispatchQueue.main.async {
                                            LoadingOverlay.shared.hideOverlayView()
                                            self.presentAlertWithTitle(title: "", message: messageString, options: "OK") {_ in
                                            }
                                        }
                                        
                                    }else {
                                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                  options: .prettyPrinted)
                                        self.reminders = try JSONDecoder().decode(Reminders.self, from: jsonData)
                                        DispatchQueue.main.async {
                                            LoadingOverlay.shared.hideOverlayView()
                                        }
                                    }

                                } else {
                                    DispatchQueue.main.async {
                                         LoadingOverlay.shared.hideOverlayView()
                                        self.presentAlertWithTitle(title: "", message: "Syncing the reminders failed", options: "OK") {_ in
                                        }
                                    }
                                }
                            }else {
                                if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                    messageString = (jsonMessage as? String)!
                                     DispatchQueue.main.async {
                                        LoadingOverlay.shared.hideOverlayView()
                                        self.presentAlertWithTitle(title: "", message: messageString, options: "OK") {_ in
                                        }
                                    }
                                }
                            } }catch let error {
                                DispatchQueue.main.async {
                                    LoadingOverlay.shared.hideOverlayView()
                                    self.presentAlertWithTitle(title: "", message: "Syncing the reminders failed", options: "OK") {_ in
                                    }
                                }
                        }
                    }
                    
                default:
                    DispatchQueue.main.async {
                        self.presentAlertWithTitle(title: "", message: "Syncing the reminders failed", options: "OK") {_ in
                        }
                    }
                }
            }
        }

    }

}
