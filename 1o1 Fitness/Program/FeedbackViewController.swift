//
//  FeedbackViewController.swift
//  1o1 Fitness
//
//  Created by Mounika Reddy on 11/02/21.
//  Copyright © 2021 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire

class FeedbackViewController: UIViewController {

    @IBOutlet weak var tCosmoView: CosmosView!
    @IBOutlet weak var pcosmoView: CosmosView!
    @IBOutlet weak var trating5Btn: UIButton!
    @IBOutlet weak var trating4Btn: UIButton!
    @IBOutlet weak var trating3Btn: UIButton!
    @IBOutlet weak var trating2Btn: UIButton!
    @IBOutlet weak var trating1Btn: UIButton!
    @IBOutlet weak var prating5Btn: UIButton!
    @IBOutlet weak var prating4Btn: UIButton!
    @IBOutlet weak var prating3Btn: UIButton!
    @IBOutlet weak var prating2Btn: UIButton!
    @IBOutlet weak var prating1Btn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var lb2: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    var prDetails : MyPrograms?
    var navigationView = NavigationView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100))
        navigationView.backgroundColor = AppColours.topBarGreen
        
        navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        navigationView.addBtn.isHidden = true
        navigationView.titleLbl.text = "Rate Program & Trainer"
        self.view.addSubview(navigationView)
        self.submitBtn.setTitleColor(.white, for: .normal)
        self.lb2.textColor = AppColours.textGreen
        self.lbl1.textColor = AppColours.textGreen
        pcosmoView.rating = 0
        tCosmoView.rating = 0
    }
    @objc func backBtnTapped(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
       }
    @IBAction func trating5BtnTapped(_ sender: Any) {
        if trating5Btn.isSelected == true {
            trating5Btn.setBackgroundImage(UIImage(named: "estar"), for: .normal)
            trating5Btn.isSelected = false
        }else {
            trating5Btn.setBackgroundImage(UIImage(named: "fstar"), for: .normal)
            trating5Btn.isSelected = true
        }
    }
    @IBAction func trating4BtnTapped(_ sender: Any) {
        if trating4Btn.isSelected == true {
            trating4Btn.setBackgroundImage(UIImage(named: "estar"), for: .normal)
            trating4Btn.isSelected = false
        }else {
            trating4Btn.setBackgroundImage(UIImage(named: "fstar"), for: .normal)
            trating4Btn.isSelected = true
        }
    }
    @IBAction func trating3BtnTapped(_ sender: Any) {
        if trating3Btn.isSelected == true {
            trating3Btn.setBackgroundImage(UIImage(named: "estar"), for: .normal)
            trating3Btn.isSelected = false
        }else {
            trating3Btn.setBackgroundImage(UIImage(named: "fstar"), for: .normal)
            trating3Btn.isSelected = true
        }
    }
    @IBAction func trating2BtnTapped(_ sender: Any) {
        if trating2Btn.isSelected == true {
            trating2Btn.setBackgroundImage(UIImage(named: "estar"), for: .normal)
            trating2Btn.isSelected = false
        }else {
            trating2Btn.setBackgroundImage(UIImage(named: "fstar"), for: .normal)
            trating2Btn.isSelected = true
        }
    }
    @IBAction func trating1BtnTapped(_ sender: Any) {
        if trating1Btn.isSelected == true {
            trating1Btn.setBackgroundImage(UIImage(named: "estar"), for: .normal)
            trating1Btn.isSelected = false
        }else {
            trating1Btn.setBackgroundImage(UIImage(named: "fstar"), for: .normal)
            trating1Btn.isSelected = true
        }
    }
    @IBAction func prating5BtnTapped(_ sender: Any) {
        if prating5Btn.isSelected == true {
            prating5Btn.setBackgroundImage(UIImage(named: "estar"), for: .normal)
            prating5Btn.isSelected = false
        }else {
            prating5Btn.setBackgroundImage(UIImage(named: "fstar"), for: .normal)
            prating5Btn.isSelected = true
        }
    }
    @IBAction func prating4BtnTapped(_ sender: Any) {
        if prating4Btn.isSelected == true {
            prating4Btn.setBackgroundImage(UIImage(named: "estar"), for: .normal)
            prating4Btn.isSelected = false
        }else {
            prating4Btn.setBackgroundImage(UIImage(named: "fstar"), for: .normal)
            prating4Btn.isSelected = true
        }
    }
    @IBAction func prating3BtnTapped(_ sender: Any) {
        if prating3Btn.isSelected == true {
            prating3Btn.setBackgroundImage(UIImage(named: "estar"), for: .normal)
            prating3Btn.isSelected = false
        }else {
            prating3Btn.setBackgroundImage(UIImage(named: "fstar"), for: .normal)
            prating3Btn.isSelected = true
        }
    }
    @IBAction func prating2BtnTapped(_ sender: Any) {
        if prating2Btn.isSelected == true {
            prating2Btn.setBackgroundImage(UIImage(named: "estar"), for: .normal)
            prating2Btn.isSelected = false
        }else {
            prating2Btn.setBackgroundImage(UIImage(named: "fstar"), for: .normal)
            prating2Btn.isSelected = true
        }
    }
    
    @IBAction func prating1btnTapped(_ sender: Any) {
        if prating1Btn.isSelected == true {
            prating1Btn.setBackgroundImage(UIImage(named: "estar"), for: .normal)
            prating1Btn.isSelected = false
        }else {
            prating1Btn.setBackgroundImage(UIImage(named: "fstar"), for: .normal)
            prating1Btn.isSelected = false
        }
    }
    
  
    
    @IBAction func submitBtnTapped(_ sender: Any) {
        if Double(self.pcosmoView.rating) == 0.0 || Double(self.pcosmoView.rating) == 0.0 {
            self.presentAlertWithTitle(title: "", message: "Please enter comments", options: "OK") { (_) in
                
            }
        }else {
            LoadingOverlay.shared.showOverlay(view: UIApplication.shared.windows.first!)
            let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
                   var authenticatedHeaders: [String: String] {
                       [
                           HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                           HeadersKeys.contentType: HeaderValues.json
                       ]
                   }
           

            let postBody : [String: Any] = ["review_comment": txtView.text ?? "","program_rating":Double(self.pcosmoView.rating),"trainer_rating":Double(self.tCosmoView.rating),"commentDate":Date.getDateInFormat(format: "dd/MM/yyyy", date: Date()),"trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"program_id":prDetails?.programId ?? ""]
                        let urlString = postRatings
                        guard let url = URL(string: urlString) else {return}
                        var request        = URLRequest(url: url)
                        request.httpMethod = "Post"
                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                        request.setValue("\(HeaderValues.token) \(token!) ", forHTTPHeaderField: "Authorization")
                        do {
                            request.httpBody   = try JSONSerialization.data(withJSONObject: postBody)
                        } catch let error {
                        }
                Alamofire.request(request).responseJSON{ (response) in
                    if let status = response.response?.statusCode {
                        switch(status){
                        case 200:
                            if let json = response.result.value as? [String: Any] {
                                do {
                                    if json["code"] as? Int == 80
                                    {
                                        if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                            if jsonDict is NSNull {
                                                
                                                if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                                    messageString = (jsonMessage as? String)!
                                                }
                                                
                                            }else {
                                               
                                                
                                            }
                                            DispatchQueue.main.async {
                                                LoadingOverlay.shared.hideOverlayView()
                                                self.presentAlertWithTitle(title: "", message: messageString, options: "OK") {_ in
                                                    self.navigationController?.popViewController(animated: true)
                                                }
                                            }
                                        } else {
                                            DispatchQueue.main.async {
                                                 LoadingOverlay.shared.hideOverlayView()
                                                self.presentAlertWithTitle(title: "", message: "Posting comments failed", options: "OK") {_ in
                                                    
                                                }
                                            }
                                        }
                                    }else {
                                        if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                            messageString = (jsonMessage as? String)!
                                             DispatchQueue.main.async {
                                                LoadingOverlay.shared.hideOverlayView()
                                                self.presentAlertWithTitle(title: "", message: messageString, options: "OK") {_ in
                                                    self.navigationController?.popViewController(animated: true)
                                                }
                                            }
                                        }
                                    } }catch let error {
                                        DispatchQueue.main.async {
                                            LoadingOverlay.shared.hideOverlayView()
                                            self.presentAlertWithTitle(title: "", message: "Posting comments failed", options: "OK") {_ in
                                            }
                                        }
                                }
                            }
                            
                        default:
                            DispatchQueue.main.async {
                                LoadingOverlay.shared.hideOverlayView()
                                self.presentAlertWithTitle(title: "", message: "Posting comments failed", options: "OK") {_ in
                                }
                            }
                        }
                    }
                }

        }

    }
    
}
