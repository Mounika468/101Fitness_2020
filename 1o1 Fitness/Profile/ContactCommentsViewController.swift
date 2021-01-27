//
//  ContactCommentsViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 04/12/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import Alamofire

class ContactCommentsViewController: UIViewController {

    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var commentsCardView: CardView!
    @IBOutlet weak var HeaderLbl: UILabel!
    @IBOutlet weak var nameCardView: CardView!
    var navigationView = NavigationView()
    var category : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        xBarHeight = 80
        navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight))
        navigationView.titleLbl.text = "Email Us"
        navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.leftArrow.isHidden = true
        navigationView.rightArrow.isHidden = true
        navigationView.backBtn.isHidden = false
        navigationView.backBtn.addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(navigationView)
        self.navigationController?.isNavigationBarHidden = true
        self.HeaderLbl.textColor = AppColours.textGreen
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // self.getContactUsInfo()
        self.HeaderLbl.text = category
        txtView.textColor = UIColor.lightGray
    }
    @objc func backBtnTapped(sender : UIButton){
     self.navigationController?.popViewController(animated: true)
    }
//    func reloadContacts() {
//        self.contactsTblView.reloadData()
//        self.tblHeightConstraint.constant = CGFloat((self.sourceArr?.count ?? 0) * 70 + 40)
//    }
//    func postContactUsInfo() {
//        LoadingOverlay.shared.showOverlay(view: self.view)
//        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
//               var authenticatedHeaders: [String: String] {
//                   [
//                       HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
//                       HeadersKeys.contentType: HeaderValues.json
//                   ]
//               }
//               if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
//                                            ProgramDetails.programDetails.subId = id
//                                        }
//        ContactsAPI.getContactUsSections(header: authenticatedHeaders) {[weak self] (notifications) in
//            DispatchQueue.main.async {
//                LoadingOverlay.shared.hideOverlayView()
//                if notifications?.count ?? 0 > 0 {
////                    self?.nodataLbl.isHidden = true
////                    self?.notificationsArr = notifications
//                    self?.reloadContacts()
//                }else {
//                   // self?.sourceArr = nil
//                    self?.reloadContacts()
//                  //  self?.nodataLbl.isHidden = false
//                }
//            }
//
//        } errorHandler: { (error) in
//            DispatchQueue.main.async {
//            LoadingOverlay.shared.hideOverlayView()
//                self.presentAlertWithTitle(title: "Error", message:"\(error.errorDescription)", options: "OK") {[weak self] (_) in
//                    self?.sourceArr = nil
//                    self?.reloadContacts()
//                  //  self?.nodataLbl.isHidden = true
//            }
//            }
//        }
//    }

    func postComments() {
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
//        let postComments  = ContactUsPostBody(comments: self.txtView.text, os_version: "", app_version: "", devise_model: "", currentDateTime: "", raisedBy: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, requestType: self.category)
//        let jsonEncoder = JSONEncoder()
//        let jsonData = try! jsonEncoder.encode(postComments)
        let postBody : [String: Any] = ["comments": txtView.text,"app_version":"","os_version":"","devise_model":"","currentDateTime":"","raisedBy":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"requestType":self.category]
                let urlString = postContactComments
                guard let url = URL(string: urlString) else {return}
                var request        = URLRequest(url: url)
                request.httpMethod = "Post"
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
                                            self.navigationController?.popToRootViewController(animated: true)
                                        }
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                         LoadingOverlay.shared.hideOverlayView()
                                        self.presentAlertWithTitle(title: "", message: "Fetching the Schedules failed", options: "OK") {_ in
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
                                    self.presentAlertWithTitle(title: "", message: "Posting comments failed", options: "OK") {_ in
                                    }
                                }
                        }
                    }
                    
                default:
                    DispatchQueue.main.async {
                        self.presentAlertWithTitle(title: "", message: "Posting comments failed", options: "OK") {_ in
                        }
                    }
                }
            }
        }

    }
    @IBAction func submitBtnTapped(_ sender: Any) {
        if txtView.text.count > 0 && txtView.text != "Enter your comments" {
            self.postComments()
        }else {
            self.presentAlertWithTitle(title: "", message: "Please enter comments", options: "OK") { (_) in
                
            }
        }
    }
}
extension ContactCommentsViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        if text == "\n"
        {
            txtView.resignFirstResponder()
            return false
        }
        return numberOfChars < 300    // 10 Limit Value
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtView.textColor == UIColor.lightGray {
            self.txtView.text = ""
            txtView.textColor = UIColor.white
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {

        if txtView.text == "" {
            txtView.text = "Enter your comments"
            txtView.textColor = UIColor.lightGray
        }
    }
}
