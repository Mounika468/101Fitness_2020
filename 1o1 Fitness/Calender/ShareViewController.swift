//
//  ShareViewController.swift
//  1o1 Fitness
//
//  Created by Mounika Reddy on 02/03/21.
//  Copyright © 2021 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import Alamofire

class ShareViewController: UIViewController {

    @IBOutlet weak var reportTypeBtn: UIButton!
    @IBOutlet weak var dietBtn: UIButton!
    @IBOutlet weak var finessBtn: UIButton!
    var reportType : String = "Fitness"
    var reportDuration: String = "Today"
    var fileURl :String = ""
    var navigationView = NavigationView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        xBarHeight = 88
        navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight))
        navigationView.titleLbl.text = "Share Report"
        navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.shareBtn.isHidden = true
        navigationView.backBtn.isHidden = false
        navigationView.backBtn.addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(navigationView)
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        self.reportTypeBtn.setTitle(String(format: "%@  ", reportDuration), for: .normal)
    }
    @objc func backBtnTapped(sender : UIButton){
     self.navigationController?.popViewController(animated: true)
    }
    @IBAction func dietBtnTapped(_ sender: Any) {
        if dietBtn.isSelected {
            self.dietBtn.isSelected = false
            self.dietBtn.setImage(UIImage(named: "rUCheck"), for: .normal)
            self.finessBtn.isSelected = true
            self.finessBtn.setImage(UIImage(named: "rCheck"), for: .normal)
        }else {
            self.dietBtn.isSelected = true
            self.dietBtn.setImage(UIImage(named: "rCheck"), for: .normal)
            self.finessBtn.isSelected = false
            self.reportType = "Diet"
            self.finessBtn.setImage(UIImage(named: "rUCheck"), for: .normal)
        }
    }
    
    @IBAction func fitnessBtnTapped(_ sender: Any) {
        if finessBtn.isSelected == false {
            self.reportType = "Fitness"
            self.dietBtn.isSelected = false
            self.dietBtn.setImage(UIImage(named: "rUCheck"), for: .normal)
            self.finessBtn.isSelected = true
            self.finessBtn.setImage(UIImage(named: "rCheck"), for: .normal)
        }else {
            self.dietBtn.isSelected = true
            self.dietBtn.setImage(UIImage(named: "rCheck"), for: .normal)
            self.finessBtn.isSelected = false
            self.finessBtn.setImage(UIImage(named: "rUCheck"), for: .normal)
        }
    }
    
    @IBAction func reviewBtnTapped(_ sender: Any) {
      
            LoadingOverlay.shared.showOverlay(view: UIApplication.shared.windows.first!)
            let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
                   var authenticatedHeaders: [String: String] {
                       [
                           HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                           HeadersKeys.contentType: HeaderValues.json
                       ]
                   }
        var endDate = Date.getDateInFormat(format: "dd/MM/yyyy", date: Date())
        switch self.reportDuration {
        case "Last 7 days":
            endDate = Date.getEndDateInFormatFrom(format: "yyyy-MM-dd", day: -7, startDate: Date.getDateInFormat(format: "yyyy-MM-dd", date: Date()))
        case "Month":
            endDate = Date.getEndDateInFormatFrom(format: "yyyy-MM-dd", day: -30, startDate: Date.getDateInFormat(format: "yyyy-MM-dd", date: Date()))
        
        default:
            endDate = Date.getDateInFormat(format: "yyyy-MM-dd", date: Date())
        }
        let postBody : [String: Any] = ["startDate": endDate,"endDate":Date.getDateInFormat(format: "yyyy-MM-dd", date: Date()),"report_type":self.reportType,"type":self.reportDuration,"trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!]
//        let postBody : [String: Any] = ["startDate": "2021-03-04","endDate":"2021-03-15","report_type":self.reportType,"type":self.reportDuration,"trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!]
                        let urlString = getShareReportURL
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
                                    if json["code"] as? Int == 0
                                    {
                                        if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                            if jsonDict is NSNull {
                                                
                                                if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                                    messageString = (jsonMessage as? String)!
                                                    DispatchQueue.main.async {
                                                        LoadingOverlay.shared.hideOverlayView()
                                                        self.presentAlertWithTitle(title: "", message: messageString, options: "OK") {_ in
                                                            
                                                        }
                                                    }
                                                }
                                                
                                            }else {
                                               
                                                print("json response \(jsonDict)")
                                                DispatchQueue.main.async {
                                                    LoadingOverlay.shared.hideOverlayView()
                                                let storyboard = UIStoryboard(name: "ShareViewController", bundle: nil)
                                                               let controller = storyboard.instantiateViewController(withIdentifier: "ReportReviewVC") as! ReportReviewVC
                                                controller.url = jsonDict as! String
                                                self.navigationController?.pushViewController(controller, animated: true)
                                                }
                                            }

                                        } else {
                                            DispatchQueue.main.async {
                                                 LoadingOverlay.shared.hideOverlayView()
                                                self.presentAlertWithTitle(title: "", message: "Fetching Report failed", options: "OK") {_ in
                                                    
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
                                            self.presentAlertWithTitle(title: "", message: "Fetching Report failed", options: "OK") {_ in
                                            }
                                        }
                                }
                            }
                            
                        default:
                            DispatchQueue.main.async {
                                LoadingOverlay.shared.hideOverlayView()
                                self.presentAlertWithTitle(title: "", message: "Fetching Report failed", options: "OK") {_ in
                                }
                            }
                        }
                    }
                }


    }
    @IBAction func todayBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ProfileMenuVC", bundle: nil)
                       let controller = storyboard.instantiateViewController(withIdentifier: "PickerVC") as! PickerVC
        controller.popType = .reportType
         controller.reportTypeDelegate = self
                         controller.modalPresentationStyle = .custom
                          controller.transitioningDelegate = self
                              controller.view.backgroundColor = UIColor.black
                              self.present(controller, animated: true, completion: nil)
    }
   
   

}
extension ShareViewController : ReportTypeDelegate ,UIViewControllerTransitioningDelegate{
    func reportTypeSelected(reportType: String) {
        self.reportDuration = reportType
        self.reportTypeBtn.setTitle(String(format: "%@  ", reportType), for: .normal)
    }
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController:presented, presenting: presenting)
    }
}
