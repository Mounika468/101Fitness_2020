//
//  TrainerDetailsViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 27/04/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Alamofire
enum UserSelection {
    case profile
    case video
    case package
    case call
}
class TrainerDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var bgViewHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var callViewHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var callView: ScheduleCallView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var packagesView: PackagesView!
    @IBOutlet weak var videosView: TrainerVideos!
    @IBOutlet weak var profileView: TrainerProfileView!
    //    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var packageBtn: UIButton!
    @IBOutlet weak var videoBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    var trainersInfo : TrainerInfo?
    var trainersVideos: [TrainerVideoList]?
     var trainerPackage: [TrainerPackage]?
     var introVideo: String?
    var userSelection: UserSelection?
     var navigationView = NavigationView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        let xBarHeight = navigationController?.navigationBar.frame.maxY
        // Do any additional setup after loading the view.
         navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight!))
         navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.titleLbl.text = "Trainer Profile"
        navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(navigationView)
        self.navigationController?.isNavigationBarHidden = true
        self.profileView.profileDelegate = self
        self.packagesView.isHidden = true
        self.profileBtnTapped(self.profileBtn!)
        if self.callView.callScheduleDelegate == nil {
            self.callView.callScheduleDelegate = self
        }
    }
    
    override func viewDidAppear(_ _animated: Bool)
    {
//        self.profileBtnTapped(self.profileBtn!)
        self.refreshView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.tabBarController?.tabBar.isHidden == true {
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    func startLoader()
    {
        let window = UIApplication.shared.windows.first!
               DispatchQueue.main.async {
                   LoadingOverlay.shared.showOverlay(view: window)
               }
    }
    //MARK -- IBAction Methods
    @IBAction func packageBtnTapped(_ sender: UIButton) {
        self.profileViewDisplay(isActive: false)
        self.videoViewDisplay(isActive: false)
         self.callViewDisplay(isActive: false)
        self.packagesViewDisplay(isActive: true)
        self.userSelection = .profile
        self.bgViewHeightConstrain.constant = 800
    }
    @IBAction func videoBtnTapped(_ sender: UIButton) {
        self.profileViewDisplay(isActive: false)
        self.videoViewDisplay(isActive: true)
         self.callViewDisplay(isActive: false)
        self.packagesViewDisplay(isActive: false)
        self.userSelection = .video
        self.bgViewHeightConstrain.constant = 800
        
    }
    @IBAction func profileBtnTapped(_ sender: UIButton) {
        self.profileViewDisplay(isActive: true)
         self.callViewDisplay(isActive: false)
        self.videoViewDisplay(isActive: false)
        self.packagesViewDisplay(isActive: false)
        self.userSelection = .package
        self.bgViewHeightConstrain.constant = 800
        
    }
    
    @IBAction func callBtnTapped(_ sender: Any) {
        self.profileViewDisplay(isActive: false)
        self.callViewDisplay(isActive: true)
        self.videoViewDisplay(isActive: false)
        self.packagesViewDisplay(isActive: false)
        self.userSelection = .call
    }
    func refreshView() {
        switch self.userSelection {
        case .profile:
            self.profileViewDisplay(isActive: false)
            self.videoViewDisplay(isActive: false)
            self.packagesViewDisplay(isActive: true)
            self.callViewDisplay(isActive: false)
            self.userSelection = .profile
            self.bgViewHeightConstrain.constant = 800
        case .video:
            self.profileViewDisplay(isActive: false)
            self.videoViewDisplay(isActive: true)
            self.packagesViewDisplay(isActive: false)
            self.callViewDisplay(isActive: false)
            self.userSelection = .video
            self.bgViewHeightConstrain.constant = 800
        case .package:
            self.profileViewDisplay(isActive: true)
            self.videoViewDisplay(isActive: false)
            self.packagesViewDisplay(isActive: false)
             self.callViewDisplay(isActive: false)
            self.userSelection = .package
            self.bgViewHeightConstrain.constant = 800
        case .call:
            self.callViewDisplay(isActive: true)
            self.profileViewDisplay(isActive: false)
            self.videoViewDisplay(isActive: false)
            self.packagesViewDisplay(isActive: false)
            self.userSelection = .call
        default:
            self.profileViewDisplay(isActive: false)
            self.videoViewDisplay(isActive: true)
            self.packagesViewDisplay(isActive: false)
            self.userSelection = .video
            self.bgViewHeightConstrain.constant = 800
        }
    }
    //MARK -- Button image changes
    func profileViewDisplay(isActive: Bool) {
        if !isActive {
            self.profileBtn.setImage(UIImage(named: "gprofile"), for: .normal)
            self.profileView.isHidden = true
        }
        else
        {
            navigationView.titleLbl.text = "Trainer Profile"
            self.getTrainerProfile()
            self.profileBtn.setImage(UIImage(named: "profile"), for: .normal)
            self.profileView.isHidden = false
            if  let rating = self.trainersInfo?.rating {
                let ratings = String(describing: rating)
                self.profileView.setRatings(rating: ratings)
            }else {
                self.profileView.setRatings(rating: "")
            }
            
            
        }
    }
    func videoViewDisplay(isActive: Bool) {
        if !isActive {
            self.videoBtn.setImage(UIImage(named: "gvideos"), for: .normal)
            self.videosView.isHidden = true
        }
        else
        {
            navigationView.titleLbl.text = "Trainer Videos"
              self.getTrainerPublicVideos()
            self.videosView.isHidden = false
            self.videoBtn.setImage(UIImage(named: "videos"), for: .normal)
        }
    }
    func packagesViewDisplay(isActive: Bool) {
        if !isActive {
            self.packageBtn.setImage(UIImage(named: "gprograms"), for: .normal)
             self.packagesView.isHidden = true
        }
        else
        {
            navigationView.titleLbl.text = "Trainer Packages"
            self.getTrainerPackages()
            self.packageBtn.setImage(UIImage(named: "programs1"), for: .normal)
             self.packagesView.isHidden = false
        }
    }
    func callViewDisplay(isActive: Bool) {
        if !isActive {
            self.callBtn.setImage(UIImage(named: "gTCall"), for: .normal)
             self.callView.isHidden = true
        }
        else
        {
            navigationView.titleLbl.text = "Call Schedule"
            self.callBtn.setImage(UIImage(named: "cTcall"), for: .normal)
             self.callView.isHidden = false
           
            self.getAllCallsForNotSubscribedUser(date: Date())

        }
    }
    func getAllCallsForNotSubscribedUser(date:Date) {
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
        if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                     ProgramDetails.programDetails.subId = id
                                 }
              if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
                  ProgramDetails.programDetails.programId = id
              }
        let timeZone = TimeZone.current.identifier
        let postBody : [String: Any] = ["date": Date.getDateInFormat(format: "yyyy-MM-dd", date: date),"trainerId":(self.trainersInfo?.trainerId)!,"timezone":timeZone]
                let urlString = getCallsByDateForGuest
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
        messageString = ""
        Alamofire.request(request).responseJSON{ (response) in
            print("response is \(response)")
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    if let json = response.result.value as? [String: Any] {
                        print("JSON: \(json)") // serialized json response
                        do {
                            if json["code"] as? Int != 40
                            {
                                if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                    if jsonDict is NSNull {
                                        
                                        if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                            messageString = (jsonMessage as? String)!
                                         //   self.nodataLbl.text = messageString
                                         self.callView.schedulesArr = nil
                                        }
                                       
                                        
                                    }else {
                                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                  options: .prettyPrinted)
                                        let schedulesArr = try JSONDecoder().decode([SlotsData]?.self, from: jsonData)
                                        self.callView.schedulesArr = schedulesArr

                                    }
                                    DispatchQueue.main.async {
                                        self.callView.refreshCallView()
                                        LoadingOverlay.shared.hideOverlayView()
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                         self.callView.schedulesArr = nil
                                         LoadingOverlay.shared.hideOverlayView()
                                       self.callView.refreshCallView()
                                        self.presentAlertWithTitle(title: "", message: "Fetching the Schedules failed", options: "OK") {_ in
                                        }
                                    }
                                }
                            }else {
                                if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                    messageString = (jsonMessage as? String)!
                                     DispatchQueue.main.async {
                                        LoadingOverlay.shared.hideOverlayView()
                                    self.callView.refreshCallView()
                                          self.callView.schedulesArr = nil
                                    }
                                }
                               
                            } }catch let error {
                                DispatchQueue.main.async {
                                    LoadingOverlay.shared.hideOverlayView()
                                    self.callView.refreshCallView()
                                    self.callView.schedulesArr = nil
                                    self.presentAlertWithTitle(title: "", message: "Fetching the Schedules failed", options: "OK") {_ in
                                    }
                                }
                        }
                    }
                    
                default:
                    DispatchQueue.main.async {
                  LoadingOverlay.shared.hideOverlayView()
                                                     self.callView.refreshCallView()
                                                     self.callView.schedulesArr = nil
                                                     self.presentAlertWithTitle(title: "", message: "Fetching the Schedules failed", options: "OK") {_ in
                                                     }
                    }
                }
            }
        }
      
    }
    
    
    //MARK -- Get Trainer Profile
    func getAllCallsForTrainer(date:Date) {
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
        if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                     ProgramDetails.programDetails.subId = id
                                 }
              if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
                  ProgramDetails.programDetails.programId = id
              }
        let timeZone = TimeZone.current.identifier
        let postBody : [String: Any] = ["date": Date.getDateInFormat(format: "yyyy-MM-dd", date: date),"trainerId":(self.trainersInfo?.trainerId)!,"timezone":timeZone]
                let urlString = getAllCallForTrainee
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
        messageString = ""
        Alamofire.request(request).responseJSON{ (response) in
            print("response is \(response)")
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    if let json = response.result.value as? [String: Any] {
                        print("JSON: \(json)") // serialized json response
                        do {
                            if json["code"] as? Int != 40
                            {
                                if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                    if jsonDict is NSNull {
                                        
                                        if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                            messageString = (jsonMessage as? String)!
                                         //   self.nodataLbl.text = messageString
                                         self.callView.schedulesArr = nil
                                        }
                                       
                                        
                                    }else {
                                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                  options: .prettyPrinted)
                                        let schedulesArr = try JSONDecoder().decode([SlotsData]?.self, from: jsonData)
                                        self.callView.schedulesArr = schedulesArr

                                    }
                                    DispatchQueue.main.async {
                                        self.callView.refreshCallView()
                                        LoadingOverlay.shared.hideOverlayView()
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                         self.callView.schedulesArr = nil
                                         LoadingOverlay.shared.hideOverlayView()
                                       self.callView.refreshCallView()
                                        self.presentAlertWithTitle(title: "", message: "Fetching the Schedules failed", options: "OK") {_ in
                                        }
                                    }
                                }
                            }else {
                                if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                    messageString = (jsonMessage as? String)!
                                     DispatchQueue.main.async {
                                        LoadingOverlay.shared.hideOverlayView()
                                    self.callView.refreshCallView()
                                          self.callView.schedulesArr = nil
                                    }
                                }
                               
                            } }catch let error {
                                DispatchQueue.main.async {
                                    LoadingOverlay.shared.hideOverlayView()
                                    self.callView.refreshCallView()
                                    self.callView.schedulesArr = nil
                                    self.presentAlertWithTitle(title: "", message: "Fetching the Schedules failed", options: "OK") {_ in
                                    }
                                }
                        }
                    }
                    
                default:
                    DispatchQueue.main.async {
                  LoadingOverlay.shared.hideOverlayView()
                                                     self.callView.refreshCallView()
                                                     self.callView.schedulesArr = nil
                                                     self.presentAlertWithTitle(title: "", message: "Fetching the Schedules failed", options: "OK") {_ in
                                                     }
                    }
                }
            }
        }
      
    }
   
    private func getTrainerProfile()
    {
        self.startLoader()
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        
        TrainerDetailsAPI.post(trainerId:(self.trainersInfo?.trainerId)!, header: authenticatedHeaders, successHandler: { [weak self] trainerPofile  in
            
            print(" success response \(trainerPofile)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                self?.profileView.nameLbl.text = trainerPofile[0].firstName! + " " + trainerPofile[0].lastName!
                self?.profileView.aboutLbl.text = trainerPofile[0].about!
                let imagePath = trainerPofile[0].profileImage?.profileImagePath!
                self?.profileView.imgView.loadImage(url:URL(string: imagePath!)!)
                self?.profileView.certArray = trainerPofile[0].certification
                 let profileVideo = trainerPofile[0].profileIntroVideo
                self?.introVideo = profileVideo?.videoMp4Destination!
                self?.profileView.setupCertificatesView()
            }
        }) { [weak self] error in
            print(" error \(error)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
        }
    }
    //MARK -- Get Trainer Video List
    private func getTrainerPublicVideos()
    {
        self.startLoader()
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        
        TrainerVideosAPI.post(trainerId:(self.trainersInfo?.trainerId)!, header: authenticatedHeaders, successHandler: { [weak self] trainerVideos  in
           // self?.trainersVideos = trainerVideos
             DispatchQueue.main.async {
            if trainerVideos.count > 0 {
                self?.videosView.isHidden = false
                self?.videosView.videosArr = trainerVideos
                if self?.videosView.videoDelegate == nil {
                    self?.videosView.videoDelegate = self
                }
                self?.videosView.loadVideosList()
            }
            print(" success response \(trainerVideos)")
           
                LoadingOverlay.shared.hideOverlayView()

            }
            
        }) { [weak self] error in
            print(" error \(error)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
        }
    }
    //MARK -- Get Trainer Video List
    private func getTrainerPackages()
    {
        self.startLoader()
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        
        TrainerPackageAPI.post(trainerId:(self.trainersInfo?.trainerId)!, header: authenticatedHeaders, successHandler: { [weak self] trainerPackage  in
           // self?.trainersVideos = trainerVideos
            if trainerPackage != nil {
                DispatchQueue.main.async {
                    if let result = trainerPackage as? TrainerPackage {
                        self?.packagesView.isHidden = false
                        self?.packagesView.packagesArr = trainerPackage
                        if self?.packagesView.packageDelegate == nil {
                            self?.packagesView.packageDelegate = self
                        }
                        self?.packagesView.loadPackagesList()
                    }
                    LoadingOverlay.shared.hideOverlayView()
                }
            }else {
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                }
            }
            
        }) { [weak self] error in
            print(" error \(error)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @objc func backBtnTapped(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
extension TrainerDetailsViewController:TrainerProfileViewDelegate
{
    func certificateSelected(urlString: String?) {
        let storyboard = UIStoryboard(name: "CertificateVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "certVC") as! CertificateViewController
        controller.filePath = urlString
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func playButtonTapped() {
        let url = NSURL(string: self.introVideo!)
        let player = AVPlayer(url: url! as URL)
        let playerViewController = AVPlayerViewController()
        playerViewController.delegate = self
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}
extension TrainerDetailsViewController:TrainerVideosViewDelegate,AVPlayerViewControllerDelegate
{
    func videoSelected(urlString: String?) {
        let url = NSURL(string: urlString!)
        let player = AVPlayer(url: url! as URL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.delegate = self
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    func playerViewController(_ playerViewController: AVPlayerViewController, willEndFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
            if playerViewController.isBeingDismissed {
                playerViewController.dismiss(animated: false) { [weak self] in
                   // self?.someDismissFunc()
                }
            }
        }
    func youTubeVideoSelected(urlString:String) {
       // let url  = NSURL(string: urlString)
        let storyboard = UIStoryboard(name: "YoutubeVideoVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "YoutubeVideoVC") as! YoutubeVideoVC
        let temp = urlString.components(separatedBy: "=")
        if temp.count >= 1 {
            controller.videoId = temp[1]
        }else {
            controller.videoId = ""
        }
        self.navigationController?.present(controller, animated: true, completion: nil)
    }
}
extension TrainerDetailsViewController:PackagesViewDelegate
{
    func packageSelected(packageInfo: Any?) {
        let storyboard = UIStoryboard(name: "PackageDetailsVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "packageDetailVC") as! PackageDetailsViewController
        controller.programDetails = packageInfo
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func displayPhoneNumberAlert() {
        let storyboard = UIStoryboard(name: "PhoneNumberPopVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PhoneNumberPopupVC") as! PhoneNumberPopupVC
        controller.isFromPaymentScreen = true
        // controller.modalPresentationStyle = .custom
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
extension TrainerDetailsViewController: CallScheduleDelegate {
    func setParentViewHeight(height: CGFloat) {
        DispatchQueue.main.async {
            self.callViewHeightConstrain.constant = height + 50
            self.bgViewHeightConstrain.constant = height + 200
       }
       
    }
     
    func dateChanged(date: Date) {
        self.getAllCallsForNotSubscribedUser(date:date)
    }
    
    func callBookSlot(slotId: String, schedulerId: String, date:Date) {
        if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
                         ProgramDetails.programDetails.programId = id
                     }
        if  ProgramDetails.programDetails.programId.count == 0 {
            let storyboard = UIStoryboard(name: "PhotosBottomVC", bundle: nil)
                   let controller = storyboard.instantiateViewController(withIdentifier: "PhotosBottomVC") as! PhotosBottomVC
                   controller.modalPresentationStyle = .custom
                   controller.guestViewDelegate = self
            controller.isFromProfileScreen = true
                   controller.transitioningDelegate = self
                   self.present(controller, animated: true, completion: nil)
        }else {
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
        if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
            ProgramDetails.programDetails.subId = id
        }
            let timeZone = TimeZone.current.identifier
//        let postBody : [String: Any] = ["slotId": slotId,"trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"schedulerId":schedulerId]
            let postBody : [String: Any] = ["slotId": slotId,"trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"date": Date.getDateInFormat(format: "yyyy-MM-dd", date: date),"timezone":timeZone]
        let urlString = bookSlotForCall
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
            messageString = ""
        Alamofire.request(request).responseJSON{ (response) in
            print("response is \(response)")
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    if let json = response.result.value as? [String: Any] {
                        print("JSON: \(json)") // serialized json response
                        do {
                            if json["code"] as? Int != 40 && json["code"] as? Int != 64
                            {
                                if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                    if jsonDict is NSNull {
                                        
                                        if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                            messageString = (jsonMessage as? String)!
                                            
                                        }
                                        self.callView.schedulesArr = nil
                                        
                                    }else {
                                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                  options: .prettyPrinted)
                                        let schedulesArr = try JSONDecoder().decode([SlotsData]?.self, from: jsonData)
                                         self.callView.schedulesArr = schedulesArr
                                    }
                                    DispatchQueue.main.async {
                                        LoadingOverlay.shared.hideOverlayView()
                                        self.callView.refreshCallView()
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                        LoadingOverlay.shared.hideOverlayView()
                                         self.callView.schedulesArr = nil
                                         self.callView.refreshCallView()
                                        self.presentAlertWithTitle(title: "", message: "Booking the slot is failed", options: "OK") {_ in
                                        }
                                    }
                                }
                            }else {
                                if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                    messageString = (jsonMessage as? String)!
                                     DispatchQueue.main.async {
                                        LoadingOverlay.shared.hideOverlayView()
                                        if json["code"] as? Int != 64 {
                                            self.callView.schedulesArr = nil
                                            self.callView.refreshCallView()
                                        }else {
                                            self.presentAlertWithTitle(title: "", message: messageString, options: "OK") {_ in
                                            }
                                        }
                                     
                                    }
                                }
                            }
                            
                        }catch let error {
                                DispatchQueue.main.async {
                                    LoadingOverlay.shared.hideOverlayView()
                                     self.callView.schedulesArr = nil
                                     self.callView.refreshCallView()
                                    self.presentAlertWithTitle(title: "", message: "Booking the slot is failed", options: "OK") {_ in
                                    }
                                }
                        }
                    }
                    
                default:
                    DispatchQueue.main.async {
                        LoadingOverlay.shared.hideOverlayView()
                                                           self.callView.refreshCallView()
                                                           self.callView.schedulesArr = nil
                                                           self.presentAlertWithTitle(title: "", message: "Fetching the Schedules failed", options: "OK") {_ in
                                                           }
                    }
                }
            }
        }
        }
        
        
    }
    func cancelCallSchedule(slotId: String, schedulerId: String, date:Date) {
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
        if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                     ProgramDetails.programDetails.subId = id
                                 }
              if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
                  ProgramDetails.programDetails.programId = id
              }
        let timeZone = TimeZone.current.identifier
//        let postBody : [String: Any] = ["slotId": slotId,"trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"schedulerId":schedulerId]
        let postBody : [String: Any] = ["slotId": slotId,"trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"date": Date.getDateInFormat(format: "yyyy-MM-dd", date: date),"timezone":timeZone]
                let urlString = cancelCall
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
        messageString = ""
        Alamofire.request(request).responseJSON{ (response) in
            print("response is \(response)")
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    if let json = response.result.value as? [String: Any] {
                        print("JSON: \(json)") // serialized json response
                        do {
                            if json["code"] as? Int != 40
                            {
                                if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                    if jsonDict is NSNull {
                                        
                                        if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                            messageString = (jsonMessage as? String)!
                                            self.callView.schedulesArr = nil
                                        }
                                        
                                    }else {
                                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                  options: .prettyPrinted)
                                        let schedulesArr = try JSONDecoder().decode([SlotsData]?.self, from: jsonData)
                                          self.callView.schedulesArr = schedulesArr
                                    }
                                    DispatchQueue.main.async {
                                        LoadingOverlay.shared.hideOverlayView()
                                        self.callView.refreshCallView()
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                         LoadingOverlay.shared.hideOverlayView()
                                        self.callView.schedulesArr = nil
                                         self.callView.refreshCallView()
                                        self.presentAlertWithTitle(title: "", message: "Fetching the Schedules failed", options: "OK") {_ in
                                        }
                                    }
                                }
                            }else {
                                if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                    messageString = (jsonMessage as? String)!
                                    DispatchQueue.main.async {
                                        LoadingOverlay.shared.hideOverlayView()
                                        self.callView.schedulesArr = nil
                                        self.callView.refreshCallView()
                                    }
                                }
                            } }catch let error {
                                DispatchQueue.main.async {
                                    LoadingOverlay.shared.hideOverlayView()
                                    self.callView.schedulesArr = nil
                                                                            self.callView.refreshCallView()
                                    self.presentAlertWithTitle(title: "", message: "Fetching the Schedules failed", options: "OK") {_ in
                                    }
                                }
                        }
                    }
                    
                default:
                    DispatchQueue.main.async {
                  LoadingOverlay.shared.hideOverlayView()
                                                     self.callView.refreshCallView()
                                                     self.callView.schedulesArr = nil
                                                     self.presentAlertWithTitle(title: "", message: "Fetching the Schedules failed", options: "OK") {_ in
                                                     }
                    }
                }
            }
        }
      
    }
    func  getRoomStatus(slotId: String, schedulerId: String) {
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
          if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                       ProgramDetails.programDetails.subId = id
                                   }
                if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
                    ProgramDetails.programDetails.programId = id
                }
        messageString = ""
        GetCallInfoByDateAPI.checkRoomStatus(header: authenticatedHeaders, slotId: slotId, schedulerId: schedulerId, traineeid: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, successHandler:{ [weak self] token in
            
            if (token != nil) {
                 DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                    self?.tabBarController?.tabBar.isHidden = true
                let storyboard = UIStoryboard(name: "TwilioCallViewController", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "TwilioCallViewController") as! TwilioCallViewController
                    vc.accessToken = (token?.token!)!
                    vc.roomName = token?.roomName ?? ""
                      // let nav = UINavigationController.init(rootViewController: vc)
                      // self?.present(nav, animated: true, completion: nil)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }else {
                  DispatchQueue.main.async {
                      LoadingOverlay.shared.hideOverlayView()
                      self?.presentAlertWithTitle(title: "", message: messageString, options: "OK") {_ in
                      }
                  }
              }
              
          }) { [weak self] error in
              print(" error \(error)")
              DispatchQueue.main.async {
                  LoadingOverlay.shared.hideOverlayView()
                self?.presentAlertWithTitle(title: "", message: error.localizedDescription, options: "OK") {_ in
                }
              }
          }
    
      }
    func fetchTokenForTwilio(roomName:String) {
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
                     if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
                         ProgramDetails.programDetails.programId = id
                     }
        messageString = ""
        GetCallInfoByDateAPI.getTokenForCall(header: authenticatedHeaders, roomName: roomName, traineeid: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, successHandler: { [weak self] token in
            print("\(token)")
           // self?.dietView.diet = diet
            if (token != nil) {
                 DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                let storyboard = UIStoryboard(name: "TwilioCallViewController", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "TwilioCallViewController") as! TwilioCallViewController
                    vc.accessToken = (token?.token!)!
                    vc.roomName = token?.roomName ?? ""
                       let nav = UINavigationController.init(rootViewController: vc)
                       self?.present(nav, animated: true, completion: nil)
                }
            }
            DispatchQueue.main.async {
               // self?.dietView.reloadDietView()
                LoadingOverlay.shared.hideOverlayView()
            }
        }) { [weak self] error in
            print(" error \(error)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()

            }
        }
    }
  
}
extension TrainerDetailsViewController :UIViewControllerTransitioningDelegate,GuestUserSubscribeTappedDelegate{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController:presented, presenting: presenting)
    }
    func guestSubscribeTapped() {
        self.profileViewDisplay(isActive: false)
        self.videoViewDisplay(isActive: false)
         self.callViewDisplay(isActive: false)
        self.packagesViewDisplay(isActive: true)
        self.userSelection = .profile
    }
}

