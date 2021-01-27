//
//  PackageDetailsViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 30/04/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class PackageDetailsViewController: UIViewController {

    @IBOutlet weak var subscribeBtn: UIButton!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var priceValLbl: UILabel!
    @IBOutlet weak var pnBtn: UIButton!
    @IBOutlet weak var piBtn: UIButton!
    @IBOutlet weak var abtLbl: UILabel!
    @IBOutlet weak var whatLbl: UILabel!
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    var programDetails : Any?
    var trainerId : String?
    var programId : String?
    var navigationView : NavigationView?
    var packageDetails : PackageDetails?
     var paymentInfo: PaymentDetails?
    var country = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        let xBarHeight = navigationController?.navigationBar.frame.maxY
        // Do any additional setup after loading the view.
        navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight!))
        navigationView!.backgroundColor = AppColours.topBarGreen
        // Do any additional setup after loading the view.
        //  navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64))
        navigationView!.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(navigationView!)
        self.navigationController?.isNavigationBarHidden = true
        self.cardView.backgroundColor = UIColor.clear
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let location = LocationSingleton.sharedInstance.country ?? ""
        if location.lowercased() == "india" {
            country = "IN"
        }else if location.lowercased() == "us" || location.lowercased() == "united states" {
            country = "US"
        }else {
            let countryCode = TraineeInfo.details.country_code
            if countryCode == "+91" || countryCode == "+ 91" {
                country = "IN"
            }else if countryCode == "+1"{
                country = "US"
            }
        }
        self.getPackageDetails()
    }
  func getPackageDetails()
  {
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
    if let beginner = self.programDetails as? Beginner {
        self.programId = beginner.programId
        self.trainerId = beginner.trainerId
    }else if let intermediate = self.programDetails as? Intermediate {
        self.programId = intermediate.programId
        self.trainerId = intermediate.trainerId
    }
    else if let advanced = self.programDetails as? Advanced {
        self.programId = advanced.programId
        self.trainerId = advanced.trainerId
    }
    else
    {
        self.programId = ""
        self.trainerId = ""
    }
    TrainerPackageAPI.postToDetails(trainerId: self.trainerId!, programId: self.programId!, header: authenticatedHeaders, successHandler: { [weak self] packageDetails  in
               // self?.trainersVideos = trainerVideos
                
                 DispatchQueue.main.async {
                    if packageDetails.count > 0 {
                        self?.packageDetails = packageDetails[0]
                        self?.durationLbl.text = String(describing: packageDetails[0].programDuration!) + " Weeks"
                        self?.abtLbl.text = packageDetails[0].description!
                        switch self?.country {
                        case "IN":
                            if (packageDetails[0].priceInRupees!) == 0 {
                            self?.priceValLbl.text = String(format: "$ %.2f",packageDetails[0].priceInDollars!)
                         }else {
                            self?.priceValLbl.text = String(format: "\u{20B9} %.2f", packageDetails[0].priceInRupees!)
                         }
                        case "US":
                            self?.priceValLbl.text = String(format: "$ %.2f",packageDetails[0].priceInDollars!)
                        default:
                            self?.priceValLbl.text = String(format: "\u{20B9} %.2f", packageDetails[0].priceInRupees!)
                        }
                        self?.navigationView!.titleLbl.text = packageDetails[0].programName!
                        if packageDetails[0].isSubscribed ?? false == true {
                            self?.subscribeBtn.setTitle("Subscribed", for: .normal)
                        }else {
                            self?.subscribeBtn.setTitle("Subscribe", for: .normal)
                        }
                    }
                    LoadingOverlay.shared.hideOverlayView()

                }
                
            }) { [weak self] error in
                print(" error \(error)")
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                    self?.presentAlertWithTitle(title: "Error", message: "Error occured. Please try later", options: "OK", completion: { (_) in
                        
                    })
                }
            }
        
    }
    @IBAction func scbcribeTapped(_ sender: Any) {
        if self.subscribeBtn.titleLabel?.text ?? "" == "Subscribed"{
            return
        }
        if self.packageDetails?.isAnyActiveProgram ?? false == true {
            self.presentAlertWithTitle(title: "", message: "You have already active program running. Do you still continue for new subscription", options:"Cancel", "OK", completion: { (option) in
                if option == 1 {
                    self.proccedForSubscribe()
                }
            })
            
        }else {
            self.proccedForSubscribe()
        }

       
    }
    func proccedForSubscribe() {
        let userdefaults = UserDefaults.standard
        if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin) {
            if  savedValue == UserDefaultsKeys.guestLogin {
                self.presentAlert()
            }else {
             //  self.subscribtionToProgram()
                if  TraineeInfo.details.address_submission == true {
                    self.subscribtionToProgram()
                }else {
                ProgramDetails.programDetails.programId = self.programId!
                           ProgramDetails.programDetails.programStartDate = Date.getCurrentDateInFormat(format: "dd/MM/yyyy")
                let storyboard = UIStoryboard(name: "AddressVC", bundle: nil)
                 let controller = storyboard.instantiateViewController(withIdentifier: "addressVC") as! AddressVC
                    controller.addressTypeScreen = .newAddressUser
                controller.trainerId = self.trainerId
                self.navigationController?.pushViewController(controller, animated: true)
                }
            }
        }
    }
    func presentAlert() {
           let storyboard = UIStoryboard(name: "CustomAlertVC", bundle: nil)
           let alertVC = storyboard.instantiateViewController(withIdentifier: "CAVC") as! CustomAlertViewController
           alertVC.modalPresentationStyle = .custom
           alertVC.message = "Please Sign up to subscribe a programs"
           alertVC.customAlertDelegate = self
           present(alertVC, animated: false, completion:nil)
       }
    func navigateToProfile() {
//        let storyboard = UIStoryboard(name: "StartVC", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "startVC") as! StartViewController
//        self.navigationController?.pushViewController(controller, animated: true)
         self.tabBarController?.tabBar.isHidden = true
        let registration = SignUpViewController(nibName:"SignUpViewController", bundle:nil)
        self.navigationController?.pushViewController(registration, animated: true)
    }
    
    @objc func backBtnTapped(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
   
    func subscribtionToProgram() {
        
            let window = UIApplication.shared.windows.first!
            DispatchQueue.main.async {
                LoadingOverlay.shared.showOverlay(view: window)
            }
            ProgramDetails.programDetails.programId = self.programId!
            ProgramDetails.programDetails.programStartDate = Date.getCurrentDateInFormat(format: "dd/MM/yyyy")
            let location = LocationSingleton.sharedInstance.country ?? ""
            var country = ""
            if location.lowercased() == "india" {
                country = "IN"
            }else if location.lowercased() == "us" || location.lowercased() == "united states" {
                country = "US"
            }else {
                let countryCode = TraineeInfo.details.country_code
                if countryCode == "+91" || countryCode == "+ 91" {
                    country = "IN"
                }else {
                    country = "US"
                }
            }
            let postBody : [String: Any] = ["program_id": self.programId!,"trainee_id": UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"trainer_id":self.trainerId!,"trainee_location":country]
            let jsonData = try! JSONSerialization.data(withJSONObject: postBody)
            let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
            var authenticatedHeaders: [String: String] {
                [
                    HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                    HeadersKeys.contentType: HeaderValues.json
                ]
            }
            SubscriptionAPI.postSubscription(parameters: [:], header: authenticatedHeaders, dataParams: jsonData, successHandler: { [weak self]  paymentDetails in
                print("package dettails \(paymentDetails)")
                self?.paymentInfo = paymentDetails
                DispatchQueue.main.async {
                    if self?.paymentInfo != nil {
                        ProgramPaymentDetails.programPaymentDetails.PaymentInfo = paymentDetails
                        if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                            ProgramDetails.programDetails.subId = id
                        }
                        if let programId = UserDefaults.standard.string(forKey: ProgramDetails.programDetails.subId) {
                            UserDefaults.standard.removeObject(forKey: ProgramDetails.programDetails.subId)
                        }
                        UserDefaults.standard.set(ProgramDetails.programDetails.programId, forKey:ProgramDetails.programDetails.subId )
                        let programId = UserDefaults.standard.string(forKey: ProgramDetails.programDetails.subId)
                        
                        print("program id \(programId)")
                        //  UserDefaults.standard.set(self?.programId, forKey:UserDefaultsKeys.programId )
                        
                        UserDefaults.standard.set( ProgramDetails.programDetails.programStartDate, forKey:UserDefaultsKeys.programStartdate )
                        LoadingOverlay.shared.hideOverlayView()
                        let storyboard = UIStoryboard(name: "PaymentDetailVC", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "paymentVC") as! PaymentDetailVC
                        controller.trainerId = self?.trainerId ?? ""
                        self?.navigationController?.pushViewController(controller, animated: true)
                    }else {
                        LoadingOverlay.shared.hideOverlayView()
                        self?.presentAlertWithTitle(title: "", message: "No data found", options: "OK") { (option) in
                            
                        }
                    }
                    
                }
            }) {  error in
                print(" error \(error)")
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                }
            }
        
    }
    
    func moveToNxtScreen(paymentInfo: PaymentDetails)
    {
        //paymentVC
        let storyboard = UIStoryboard(name: "PaymentDetailVC", bundle: nil)
         let controller = storyboard.instantiateViewController(withIdentifier: "paymentVC") as! PaymentDetailVC
        controller.paymentInfo = paymentInfo
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension PackageDetailsViewController: CustomAlertViewDelegate {
    func okBtnTapped() {
        
    }
    
    
    func singUpBtnTapped() {
        self.navigateToProfile()
    }
}
