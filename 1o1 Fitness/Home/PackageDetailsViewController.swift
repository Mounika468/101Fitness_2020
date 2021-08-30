//
//  PackageDetailsViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 30/04/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class PackageDetailsViewController: UIViewController {

    @IBOutlet weak var slotsValNum: UILabel!
    @IBOutlet weak var aboutYogaLbl: UILabel!
    @IBOutlet weak var yogaSubscribe: UIButton!
    @IBOutlet weak var yogaTImDura: UILabel!
    @IBOutlet weak var yogaDuration: UILabel!
    @IBOutlet weak var yogaStartDay: UILabel!
    @IBOutlet weak var timingCV: UICollectionView!
    @IBOutlet weak var morningCV: UICollectionView!
    @IBOutlet weak var eveningCV: UICollectionView!
    @IBOutlet weak var yogaPriceVal: UILabel!
    @IBOutlet weak var yogaTxtView: UITextView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
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
    var morningArr: [DisplaySlots]?
    var eveningArr: [DisplaySlots]?
    var country = ""
    var morningSelectedIndex = -1
    var eveningSelectedIndex = -1
    var morningSlot = ""
    var eveningSlot = ""
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
        
        
        // This is to load yoga layout
        if self.packageDetails?.isOnlineProgram ?? false {
            let ynib = UINib(nibName: "TrainingDaysCVCell", bundle: nil)
            self.timingCV.register(ynib, forCellWithReuseIdentifier:"trainingDaysCVCell")
            
            let nib = UINib(nibName: "DayTimeCVCells", bundle: nil)
            self.morningCV.register(nib, forCellWithReuseIdentifier:"dayTimeCVCells")
            self.eveningCV.register(nib, forCellWithReuseIdentifier:"dayTimeCVCells")
            
            
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        self.timingCV.collectionViewLayout = flowLayout
        
        
        let flowLayout1 = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        self.eveningCV.collectionViewLayout = flowLayout1
        
        
        let flowLayout2 = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        self.morningCV.collectionViewLayout = flowLayout2
            self.setupYogaLayout()
        } else {
            self.setupNormal()
        }
        
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
       // self.getPackageDetails()
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
                        switch FitnessProgramSelection.fitnessType.programType {
                        
                        case .yoga:
                            self?.setupYogaLayout()
                        default:
                            self?.setupNormal()
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
    func setupNormal() {
        self.durationLbl.text = String(describing: self.packageDetails?.programDuration!) + " Weeks"
        self.abtLbl.text = self.packageDetails?.description!
        switch self.country {
        case "IN":
            if (self.packageDetails?.priceInRupees!) == 0 {
            self.priceValLbl.text = String(format: "$ %.2f",self.packageDetails?.priceInDollars ?? "")
         }else {
            self.priceValLbl.text = String(format: "\u{20B9} %.2f", self.packageDetails?.priceInRupees ?? "")
         }
        case "US":
            self.priceValLbl.text = String(format: "$ %.2f",self.packageDetails?.priceInDollars ?? "")
        default:
            self.priceValLbl.text = String(format: "\u{20B9} %.2f", self.packageDetails?.priceInRupees ?? "")
        }
        self.navigationView!.titleLbl.text = self.packageDetails?.programName!
        if self.packageDetails?.isSubscribed ?? false == true {
            self.subscribeBtn.setTitle("Subscribed", for: .normal)
        }else {
            self.subscribeBtn.setTitle("Subscribe", for: .normal)
        }
    }
    func setupYogaLayout() {
        
        self.yogaStartDay.text = String((packageDetails?.startDate!.prefix(10))!) as String
        self.slotsValNum.text = String(format: "%d", self.packageDetails?.displaySlots?.count ?? 0)
        self.yogaDuration.text = String(describing: self.packageDetails!.programDuration!) + " Weeks"
        self.aboutYogaLbl.text = self.packageDetails?.description!
        switch self.country {
        case "IN":
            if (self.packageDetails?.priceInRupees!) == 0 {
                self.yogaPriceVal.text = String(format: "$ %.2f",self.packageDetails?.priceInDollars ?? "")
         }else {
            self.yogaPriceVal.text = String(format: "\u{20B9} %.2f", self.packageDetails?.priceInRupees ?? "")
         }
        case "US":
            self.yogaPriceVal.text = String(format: "$ %.2f",self.packageDetails?.priceInDollars ?? "")
        default:
            self.yogaPriceVal.text = String(format: "\u{20B9} %.2f", self.packageDetails?.priceInRupees ?? "")
        }
        self.navigationView!.titleLbl.text = self.packageDetails?.programName!
        if self.packageDetails?.isSubscribed ?? false == true {
            self.yogaSubscribe.setTitle("Subscribed", for: .normal)
        }else {
            self.yogaSubscribe.setTitle("Subscribe", for: .normal)
        }
        
//        self.morningArr = masterArray
//                                .flatMap{$0.contentBlocks}
//                                .flatMap{$0}
//                                .filter{$0.contentId == "123"}
        self.morningArr = self.packageDetails?.displaySlots?.filter{$0.startTime ?? "" < "12.00"}
        self.eveningArr = self.packageDetails?.displaySlots?.filter{$0.startTime ?? "" >= "12.00"}
//        self.eveningArr = self.packageDetails?.displaySlots?.compactMap{$0.startTime}.flatMap{$0}.filter{$0.name ?? "" >= "12.00"}
        //self.packageDetails?.displaySlots?.compactMap{$0.startTime}.flatMap{$0}.filter{$0.name ?? "" >= "12.00"}
        self.timingCV.reloadData()
        self.morningCV.reloadData()
        self.eveningCV.reloadData()
    }
    
    @IBAction func yogaSubscribedTapped(_ sender: Any) {
        if self.yogaSubscribe.titleLabel?.text ?? "" == "Subscribed"{
            return
        }
        if self.packageDetails?.isAnyActiveProgram ?? false == true {
            if morningSlot.count > 0 && eveningSlot.count > 0 {
                self.presentAlertWithTitle(title: "", message: "Select either morning or evening slot", options: "OK") { (_) in
                    
                }
            } else if morningSlot.count == 0 && eveningSlot.count == 0 {
                self.presentAlertWithTitle(title: "", message: "Select either morning or evening slot", options: "OK") { (_) in
                    
                }
            } else {
                self.presentAlertWithTitle(title: "", message: "You have already active program running. Do you still continue for new subscription", options:"Cancel", "OK", completion: { (option) in
                    if option == 1 {
                        self.proccedForSubscribe()
                    }
                })
            }
            
            
        }else {
            if morningSlot.count > 0 && eveningSlot.count > 0 {
                self.presentAlertWithTitle(title: "", message: "Select either morning or evening slot", options: "OK") { (_) in
                    
                }
            } else if morningSlot.count == 0 && eveningSlot.count == 0 {
                self.presentAlertWithTitle(title: "", message: "Select either morning or evening slot", options: "OK") { (_) in
                    
                }
            } else {
                self.proccedForSubscribe()
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
                    if self.morningSlot.count ?? 0 > 0 {
                        controller.slotTime = self.morningSlot
                    } else {
                        controller.slotTime = self.eveningSlot
                    }
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
        var fitness = "Fitness"
        if let fitnessType = UserDefaults.standard.string(forKey: "FitnessType") {
            fitness = fitnessType
        }
        let postBody : [String: Any] = ["program_id": self.programId!,"trainee_id": UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"trainer_id":self.trainerId!,"trainee_location":country,"category":fitness]
            let jsonData = try! JSONSerialization.data(withJSONObject: postBody)
            let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
            var authenticatedHeaders: [String: String] {
                [
                    HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                    HeadersKeys.contentType: HeaderValues.json
                ]
            }
            SubscriptionAPI.postSubscription(parameters: [:], header: authenticatedHeaders, dataParams: jsonData, successHandler: { [weak self]  paymentDetails in
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
                        
                        //  UserDefaults.standard.set(self?.programId, forKey:UserDefaultsKeys.programId )
                        
                        UserDefaults.standard.set( ProgramDetails.programDetails.programStartDate, forKey:UserDefaultsKeys.programStartdate )
                        LoadingOverlay.shared.hideOverlayView()
                        let storyboard = UIStoryboard(name: "PaymentDetailVC", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "paymentVC") as! PaymentDetailVC
                        controller.trainerId = self?.trainerId ?? ""
                        if self?.morningSlot.count ?? 0 > 0 {
                            controller.slotTime = self?.morningSlot
                        } else {
                            controller.slotTime = self?.eveningSlot
                        }
                        
                        
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

extension PackageDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.timingCV:
            return self.packageDetails?.trainingDays?.count ?? 0
        case self.morningCV:
            return self.morningArr?.count ?? 0
        case self.eveningCV:
            return self.eveningArr?.count ?? 0
        default:
            return 1
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case self.timingCV:
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trainingDaysCVCell", for: indexPath) as! TrainingDaysCVCell
            cell.dayName.text = self.packageDetails?.trainingDays![indexPath.row]
            return cell
        case self.morningCV:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayTimeCVCells", for: indexPath) as! DayTimeCVCells
            cell.timeBtn.setTitle(self.morningArr![indexPath.row].startTime, for: .normal)
            cell.timeBtn.tag = indexPath.row
            cell.timeBtn.addTarget(self, action: #selector(morningSlotSelected(sender:)), for: .touchUpInside)
           return cell
        case self.eveningCV:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayTimeCVCells", for: indexPath) as! DayTimeCVCells
            cell.timeBtn.setTitle(self.eveningArr![indexPath.row].startTime, for: .normal)
            cell.timeBtn.tag = indexPath.row
            cell.timeBtn.addTarget(self, action: #selector(eveningSlotSelected(sender:)), for: .touchUpInside)
           return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayTimeCVCells", for: indexPath) as! DayTimeCVCells
           return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
            case self.timingCV:
            
            let noOfCellsInRow = 4

                       let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
                       let totalSpace = flowLayout.sectionInset.left
                           + flowLayout.sectionInset.right
                           + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

                       let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

                       return CGSize(width: size, height: 60)
       
        default:
            let noOfCellsInRow = 3

                       let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
                       let totalSpace = flowLayout.sectionInset.left
                           + flowLayout.sectionInset.right
                           + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

                       let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

                       return CGSize(width: size, height: 30)
        }
        
        
       // return CGSize.init(width: collectionView.frame.width/7 - 5, height: 80)
    }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
          
        case self.morningCV:
            collectionView.cellForItem(at: indexPath)?.isSelected = true
        case self.eveningCV:
            collectionView.cellForItem(at: indexPath)?.isSelected = true
        default:
            collectionView.cellForItem(at: indexPath)?.isSelected = true
        }
     }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.isSelected = false
    }
    @objc func morningSlotSelected(sender : UIButton){
        let selectedCell = self.morningCV.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! DayTimeCVCells
        if sender.isSelected {
            selectedCell.timeBtn.backgroundColor = .clear
            sender.isSelected = false
            morningSlot = ""
        } else {
            if morningSelectedIndex != -1 {
                   
                let cell = self.morningCV.cellForItem(at: IndexPath(row: morningSelectedIndex, section: 0)) as! DayTimeCVCells
                    cell.timeBtn.backgroundColor = UIColor.clear
                cell.timeBtn.isSelected = false
            }
            selectedCell.timeBtn.backgroundColor = .lightText
            sender.isSelected = true
            morningSelectedIndex = sender.tag
            morningSlot = self.morningArr![sender.tag].utcStartTime ?? ""
        }
    }
    @objc func eveningSlotSelected(sender : UIButton){
        let selectedCell = self.eveningCV.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! DayTimeCVCells
        if sender.isSelected {
            selectedCell.timeBtn.backgroundColor = .clear
            sender.isSelected = false
            eveningSlot = ""
        } else {
            if eveningSelectedIndex != -1 {
                   
                let cell = self.eveningCV.cellForItem(at: IndexPath(row: eveningSelectedIndex, section: 0)) as! DayTimeCVCells
                    cell.timeBtn.backgroundColor = UIColor.clear
                cell.timeBtn.isSelected = false
                    
            }
            selectedCell.timeBtn.backgroundColor = .lightText
            sender.isSelected = true
            eveningSelectedIndex = sender.tag
            eveningSlot = self.eveningArr![sender.tag].utcStartTime ?? ""
        }
    }
}
