//
//  HomeViewController.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 25/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import CoreLocation
import AWSMobileClient
import PopupDialog
import PieCharts
let kRotationAnimationKey = "com.myapplication.rotationanimationkey"

class HomeViewController: UIViewController {
//    func onLocationUpdate(location: CLLocation) {
//        print("locatiojn is \(location.coordinate.latitude) , \(location.coordinate.longitude)")
//    }
//
//    func onLocationDidFailWithError(error: Error) {
//         print("locatiojn is \(error)")
//    }
    @IBOutlet weak var welcomeLbl: UILabel!
    var searchActive : Bool = false
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var locBtn: UIButton!
    var loadingView: LoadingReusableView?
    var pageNumber : Int = 0
    var isLoading = false
    @IBOutlet weak var trainersCollectionView: UICollectionView! {
        didSet {
            trainersCollectionView.showsVerticalScrollIndicator = false
            trainersCollectionView.showsHorizontalScrollIndicator = false
        }
    }
    @IBOutlet weak var headerCollectionView: UICollectionView! {
        didSet {
            headerCollectionView.showsVerticalScrollIndicator = false
            headerCollectionView.showsHorizontalScrollIndicator = false
        }
    }
    var trainersInfo : [TrainerInfo]?
    var filteredTrainers : [TrainerInfo]?
     var headersImages : Array = ["htrainer","hpgrs","hdiet","hcall","hcamera","hbmi"]
    override func viewDidLoad() {
        print("HOme Loaded")
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.searchBar.isHidden = true
         LocationSingleton.sharedInstance.startUpdatingLocation()
      //  self.tabBarController?.delegate = self
        print("locaions \( String(describing: LocationSingleton.sharedInstance.lastLocation))")
        print("city \( String(describing: LocationSingleton.sharedInstance.city))")
        let nib = UINib(nibName: "HeaderCollectionViewCell", bundle: nil)
        self.headerCollectionView.register(nib, forCellWithReuseIdentifier:"headerCV")
         let trainerNib = UINib(nibName: "HomeTrainerCollectionViewCell", bundle: nil)
        self.trainersCollectionView.register(trainerNib, forCellWithReuseIdentifier:"HomeProfileCV")
        //Register Loading Reuseable View
        let loadingReusableNib = UINib(nibName: "LoadingReusableView", bundle: nil)
        self.trainersCollectionView.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "loadingresuableviewid")
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        self.headerCollectionView.collectionViewLayout = flowLayout
        let flowLayoutVertical = UICollectionViewFlowLayout()
        flowLayoutVertical.scrollDirection = .vertical
        self.trainersCollectionView.collectionViewLayout = flowLayoutVertical
        
        self.searchBar.layer.cornerRadius = 15.0
        self.searchBar.layer.borderColor = UIColor.init(red: 152/255, green: 255/255, blue: 84/255, alpha: 1.0).cgColor
        self.searchBar.layer.borderWidth = 0.5
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: AppColours.textGreen]
        if #available(iOS 13.0, *) {
            self.searchBar.searchTextField.clearButtonMode = .whileEditing
            
        } else {
            // Fallback on earlier versions
        }
//        if IOSVersion.SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version: "13.0") {
//             self.searchBar.searchTextField.textColor = UIColor.white
//        }
       // self.searchBar.searchTextField.textColor = UIColor.white
        self.tabBarController?.delegate = self
        
    }
    
    override func viewDidAppear(_ _animated: Bool)
    {
       
        if let city = LocationSingleton.sharedInstance.city {
            self.locBtn.setTitle(LocationSingleton.sharedInstance.city!, for: .normal)
        }else {
            self.locBtn.setTitle("", for: .normal)
        }
        if UserDefaults.standard.string(forKey: UserDefaultsKeys.name) != nil{
            let name =  UserDefaults.standard.string(forKey: UserDefaultsKeys.name)
            welcomeLbl.text = "Hello " + "\(name!)"
        }else
        {
             welcomeLbl.text = "Hello Guest"
        }
        let userdefaults = UserDefaults.standard
        if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin) {
            if  savedValue == UserDefaultsKeys.guestLogin  {
                // return
                self.weightLbl.isHidden = true
            }else {
                self.weightLbl.isHidden = false
            }
        }
        if self.searchBar.isFirstResponder {
            self.searchBar.resignFirstResponder()
        }
    }
    @IBAction func locBtnTapped(_ sender: Any) {
    }
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        if self.searchBar.isHidden == true {
            self.searchBar.isHidden = false
        }else {
            self.searchBar.isHidden = true
        }
        
    }
    @IBAction func profileBtnTapped(_ sender: Any) {


        
        let userdefaults = UserDefaults.standard
        if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin) {
            if  savedValue == UserDefaultsKeys.guestLogin  {
                // return
                self.presentAlert(message: "Please Sign up to access the profile information")
            }else {
                self.tabBarController?.tabBar.isHidden = true
                var name = ""
                if UserDefaults.standard.string(forKey: UserDefaultsKeys.name) != nil{
                    name =  UserDefaults.standard.string(forKey: UserDefaultsKeys.name)!
                }
                self.navigationController?.isNavigationBarHidden = false
                let viewController = UIStoryboard(name: "ProfileMenuVC", bundle: nil).instantiateViewController(withIdentifier: String(describing: ProfileMenuViewController.self)) as! ProfileMenuViewController
                viewController.traineeName = name
                self.navigationController?.pushViewController(viewController, animated: true)
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
    override func viewWillAppear(_ animated: Bool) {
        self.isLoading = false
        self.pageNumber = 0
         self.getTrainerInfo()
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = true
        self.searchBar.text = ""
//       // self.navigateToProfile()
//        let storyboard = UIStoryboard(name: "StartVC", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "startVC") as! StartViewController
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
      //  self.navigationController?.isNavigationBarHidden = false
        if ProgramDetails.programDetails.programId.count == 0 {
        let indexPath = IndexPath(item: 1, section: 0)
        let cell = self.headerCollectionView.cellForItem(at: indexPath) as! HeaderCollectionViewCell
        self.stopRotatingView(view: cell.contentView)
        }
    }
    private func getTrainerInfo()
    {
        
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        if token == nil {
            AWSUserSingleton.shared.getUserattributes()
        }
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        
        let country = LocationSingleton.sharedInstance.country ?? ""
        let lat = LocationSingleton.sharedInstance.lastLocation?.coordinate.latitude.description as? String ?? ""
        let long = LocationSingleton.sharedInstance.lastLocation?.coordinate.longitude.description as? String ?? ""
        let location: [String: String] = [
            "latitude" :lat,
            "longitude" : long
        ]
        
        let window = UIApplication.shared.windows.first!
        DispatchQueue.main.async {
            LoadingOverlay.shared.showOverlay(view: window)
        }
       
        TrainerbyLocationAPI.postCalltoToken(parameters: location, details: "partial", pageNumber: 0) { [weak self] trainerInfo  in
            if trainerInfo.count > 0 {
                self?.trainersInfo = trainerInfo
                self?.pageNumber = self!.pageNumber + 1
                DispatchQueue.main.async { [self] in
                    self?.isLoading = false
//                    self?.trainersCollectionView.collectionViewLayout.invalidateLayout()
                    self?.trainersCollectionView.reloadData()
                    LoadingOverlay.shared.hideOverlayView()
                }
            }else {
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                    self?.presentAlertWithTitle(title: "", message: "No trainer found.", options: "OK") {_ in
                    }
                    self?.isLoading = true
                }
            }
            let userdefaults = UserDefaults.standard
            if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin) {
                if  savedValue != UserDefaultsKeys.guestLogin  {
                    DispatchQueue.main.async {
                        LoadingOverlay.shared.showOverlay(view: window)
                    }
                    self?.getTraineeDetails(authenticatedHeaders: authenticatedHeaders)
                }else  {
                   // if ProgramDetails.programDetails.programId.count == 0 {
                        let indexPath = IndexPath(item: 1, section: 0)
                        self?.headerCollectionView.reloadItems(at: [indexPath])
                        //CollectionView.reloadItems(at: IndexPath])
                   // }
                }
            }
        } errorHandler: { [weak self] error in
            print(" error \(error)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                self?.isLoading = true
            }
            let userdefaults = UserDefaults.standard
            if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin) {
                if  savedValue != UserDefaultsKeys.guestLogin  {
                    DispatchQueue.main.async {
                        LoadingOverlay.shared.showOverlay(view: window)
                    }
                    self?.getTraineeDetails(authenticatedHeaders: authenticatedHeaders)
                }else {
                  //  if ProgramDetails.programDetails.programId.count == 0 {
                    DispatchQueue.main.async {
                        let indexPath = IndexPath(item: 1, section: 0)
                        self?.headerCollectionView.reloadItems(at: [indexPath])
                    }
                        //CollectionView.reloadItems(at: IndexPath])
                  //  }
                }    }
        }

        
      /*  TrainerbyLocationAPI.post(parameters:location,header:authenticatedHeaders, successHandler: { [weak self] trainerInfo  in
            if trainerInfo != nil {
                self?.trainersInfo = trainerInfo
                DispatchQueue.main.async {
                    self?.trainersCollectionView.reloadData()
                    LoadingOverlay.shared.hideOverlayView()
                }
            }else {
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                    self?.presentAlertWithTitle(title: "", message: "No trainer found.", options: "OK") {_ in
                    }
                    
                }
            }
            let userdefaults = UserDefaults.standard
            if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin) {
                if  savedValue != UserDefaultsKeys.guestLogin  {
                    DispatchQueue.main.async {
                        LoadingOverlay.shared.showOverlay(view: window)
                    }
                    self?.getTraineeDetails(authenticatedHeaders: authenticatedHeaders)
                }else  {
                   // if ProgramDetails.programDetails.programId.count == 0 {
                        let indexPath = IndexPath(item: 1, section: 0)
                        self?.headerCollectionView.reloadItems(at: [indexPath])
                        //CollectionView.reloadItems(at: IndexPath])
                   // }
                }
            }
        }) { [weak self] error in
            print(" error \(error)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
            let userdefaults = UserDefaults.standard
            if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin) {
                if  savedValue != UserDefaultsKeys.guestLogin  {
                    DispatchQueue.main.async {
                        LoadingOverlay.shared.showOverlay(view: window)
                    }
                    self?.getTraineeDetails(authenticatedHeaders: authenticatedHeaders)
                }else {
                  //  if ProgramDetails.programDetails.programId.count == 0 {
                    DispatchQueue.main.async {
                        let indexPath = IndexPath(item: 1, section: 0)
                        self?.headerCollectionView.reloadItems(at: [indexPath])
                    }
                        //CollectionView.reloadItems(at: IndexPath])
                  //  }
                }    }
        } */
        // }
        
        
    }
    func getTraineeDetails(authenticatedHeaders:[String: String]) {
         let traineeId = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!
        TraineeRegister.getTraineeDetails(traineeId: traineeId, header: authenticatedHeaders, successHandler:{ [weak self] traineeDetails  in
            TraineeDetails.traineeDetails = traineeDetails
            TraineeInfo.details.username =  TraineeDetails.traineeDetails?.username ?? " "
             TraineeInfo.details.first_name =  TraineeDetails.traineeDetails?.first_name ?? " "
             TraineeInfo.details.last_name =  TraineeDetails.traineeDetails?.last_name ?? " "
            TraineeInfo.details.traineeProfileImg = TraineeDetails.traineeDetails?.traineeProfileImg?.profileImagePath ?? ""
            TraineeInfo.details.address_submission = TraineeDetails.traineeDetails?.address_submission ?? false
             TraineeInfo.details.profile_submission = TraineeDetails.traineeDetails?.profile_submission ?? false
            TraineeInfo.details.mobile_no = TraineeDetails.traineeDetails?.mobile_no ?? ""
            TraineeInfo.details.country_code = TraineeDetails.traineeDetails?.country_code ?? ""
            TraineeInfo.details.traineeProfileImg = TraineeDetails.traineeDetails?.traineeProfileImg?.profileImagePath ?? ""
            TraineeInfo.details.notificationCount = TraineeDetails.traineeDetails?.notificationCount ?? 0
            if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                   ProgramDetails.programDetails.subId = id
                               }
            ProgramDetails.programDetails.programId =  TraineeDetails.traineeDetails?.program_id ?? ""
            if ProgramDetails.programDetails.programId.count > 0 {
                if UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) != nil {
                    UserDefaults.standard.removeObject(forKey: ProgramDetails.programDetails.subId)
            }
                UserDefaults.standard.set( ProgramDetails.programDetails.programId, forKey: ProgramDetails.programDetails.subId)

            }
            let weight = TraineeDetails.traineeDetails?.currrent_weight
            var weightMetric = ""
            var weightVal = 0.0
            if weight?.metric! == "kg" {
               weightMetric = "kg"
            }else {
                weightMetric = "lbs"
            }
            weightVal = (weight?.weight) ?? 0
            var weightStr = String(format: "Weight: %.2f", weightVal,weightMetric)

            var myMutableString = NSMutableAttributedString(string: weightStr)
            myMutableString.addAttribute(.foregroundColor, value: AppColours.textGreen, range: NSRange(location:0,length:7))
            myMutableString.addAttribute(.foregroundColor, value: AppColours.appYellow, range: NSRange(location:7,length:(weightStr.count - 7)))
          DispatchQueue.main.async {
              LoadingOverlay.shared.hideOverlayView()
            if  TraineeInfo.details.traineeProfileImg.count > 0 {
                self?.profileBtn.sd_setImage(with: URL(string: TraineeInfo.details.traineeProfileImg)!, for: .normal, completed: nil)
                self?.profileBtn.layer.cornerRadius = 0.5 * (self?.profileBtn.bounds.size.width ?? 0)
                self?.profileBtn.clipsToBounds = true
            }else {
                self?.profileBtn.setImage(UIImage(named: "user"), for: .normal)
                self?.profileBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                self?.profileBtn.imageView?.layer.cornerRadius = 0
            }
                let indexPath = IndexPath(item: 1, section: 0)
            DispatchQueue.main.async {
                self?.headerCollectionView.reloadItems(at: [indexPath])
            }
            self?.weightLbl.attributedText = myMutableString
            if  TraineeInfo.details.notificationCount > 0 {
                if let tabItems = self?.tabBarController?.tabBar.items {
                    // In this case we want to modify the badge number of the third tab:
                    let tabItem = tabItems[3]
                    tabItem.badgeValue = "\(TraineeInfo.details.notificationCount)"
                }
            }else {
                if let tabItems = self?.tabBarController?.tabBar.items {
                    // In this case we want to modify the badge number of the third tab:
                    let tabItem = tabItems[3]
                    tabItem.badgeValue = nil
                }
            }
            let phoneAlertDisplayed = UserDefaults.standard.bool(forKey:"PhoneAlertDisplayed")
            if  phoneAlertDisplayed == false {
                if  TraineeInfo.details.mobile_no.count == 0 {
                    self?.displayPhoneNumberView()
                }
        }
            
          }
            
        }) { [weak self] error in
            print(" error \(error)")
          DispatchQueue.main.async {
                 LoadingOverlay.shared.hideOverlayView()
                 }
        }    }
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {

        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)

        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }

        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)

        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!

        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)

        return image
    }
    func displayPhoneNumberView() {
        let storyboard = UIStoryboard(name: "PhoneNumberPopVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PhoneNumberPopupVC") as! PhoneNumberPopupVC
        controller.isFromPaymentScreen = false
      controller.modalPresentationStyle = .custom
        self.present(controller, animated: true, completion: nil)
    }
}
extension HomeViewController: UITabBarControllerDelegate,UITabBarDelegate {
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        let userdefaults = UserDefaults.standard
        if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin) {
            if  savedValue == UserDefaultsKeys.guestLogin {
                if viewController == tabBarController.viewControllers?[1] {
                    self.presentAlert(message: "Please Sign up to access the programs")
                    return false
                } else if viewController == tabBarController.viewControllers?[3] {
                    self.presentAlert(message: "Please Sign up to access the notifications")
                    return false
                } else {
                    return true
                }
               
                // self.popupBox()
            }else {
                return true
            }
        }
        return true
//        if viewController == tabBarController.viewControllers?[2] {
//            return false
//        } else {
//            return true
//        }
    }
}

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    fileprivate func createModels() -> [PieSliceModel] {
        
        return [
            PieSliceModel(value: TraineeDetails.traineeDetails?.dayProgress?.workoutNewPercentage ?? 0/100, color: UIColor.init(red: 255/255, green: 179/255, blue: 0, alpha: 1)),
            PieSliceModel(value: TraineeDetails.traineeDetails?.dayProgress?.workoutOtherPercentage ?? 0/100, color: UIColor.init(red: 137/255, green: 196/255, blue: 67/255, alpha: 1))
        ]
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.headerCollectionView:
            return headersImages.count
            case self.trainersCollectionView:
                return self.trainersInfo?.count ?? 0
        default:
            return 1
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch collectionView {
        case self.headerCollectionView:
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCV", for: indexPath) as! HeaderCollectionViewCell
             cell.imgView.image = UIImage(named: headersImages[indexPath.row])
            cell.pieChart.isHidden = true
            if indexPath.row == 1 && ProgramDetails.programDetails.programId.count == 0  {
                DispatchQueue.main.async {
                self.rotateView(view: cell.contentView, duration: 5.0)
                }
            }else if indexPath.row == 1 && ProgramDetails.programDetails.programId.count > 0  {
                DispatchQueue.main.async {
                    cell.pieChart.isHidden = false
                    cell.imgView.image = UIImage(named: "outerProgress")
                    cell.pieChart.models =  self.createModels()
                }
            }
            return cell
            case self.trainersCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeProfileCV", for: indexPath) as! HomeTrainerCollectionViewCell
            cell.contentView.layer.cornerRadius = 10.0
            cell.contentView.layer.backgroundColor = UIColor.init(red: 41/255, green: 37/255, blue: 37/255, alpha: 1.0).cgColor
             cell.contentView.layer.masksToBounds = false
            let trainer = self.trainersInfo?[indexPath.row] as! TrainerInfo
            let imageInfo = trainer.profileImage?.profileImagePath as! String
            if imageInfo.count > 0 {
                cell.profileImgView.sd_setImage(with: URL(string: imageInfo)!, completed: nil)
            }
            cell.nameLbl.text = trainer.firstName! + " " + trainer.lastName!
                cell.ratingBtn.setImage(UIImage(named: ""), for: .normal)
                cell.ratingBtn.isHidden = true
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "meatCV", for: indexPath) as! MeatCollectionViewCell
           
                   return cell
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.trainersCollectionView && self.trainersInfo?.count ?? 0 > 2{
            if indexPath.row == self.trainersInfo!.count  - 1 && !self.isLoading {
               // self.isLoading = true
                loadMoreData()
            }
        }
       
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        if collectionView == self.trainersCollectionView {
//        if self.isLoading {
//            return CGSize.zero
//        } else {
//            return CGSize(width: collectionView.bounds.size.width, height: 55)
//        }
//        }else {
//            return CGSize.zero
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if collectionView == self.trainersCollectionView {
//        if kind == UICollectionView.elementKindSectionFooter {
//            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "loadingresuableviewid", for: indexPath) as! LoadingReusableView
//            loadingView = aFooterView
//            loadingView?.backgroundColor = UIColor.clear
//            return aFooterView
//        }
//        return UICollectionReusableView()
//        }else {
//            return UICollectionReusableView()
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
//        if collectionView == self.trainersCollectionView {
//        if elementKind == UICollectionView.elementKindSectionFooter {
//            self.loadingView?.activityIndicator.startAnimating()
//        }
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
//        if collectionView == self.trainersCollectionView {
//        if elementKind == UICollectionView.elementKindSectionFooter {
//            self.loadingView?.activityIndicator.stopAnimating()
//        }
//        }
//    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
//            let start = self.trainersInfo!.count + 1
//            let end = start + 20
        //    DispatchQueue.global().async {
                // fake background loading task
              //  sleep(2)
//                for _ in start...end {
//                    self.itemsArray.append(self.getRandomColor())
//                }
                let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
                if token == nil {
                    AWSUserSingleton.shared.getUserattributes()
                }
                var authenticatedHeaders: [String: String] {
                    [
                        HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                        HeadersKeys.contentType: HeaderValues.json
                    ]
                }
                
                let country = LocationSingleton.sharedInstance.country ?? ""
                let lat = LocationSingleton.sharedInstance.lastLocation?.coordinate.latitude.description as? String ?? ""
                let long = LocationSingleton.sharedInstance.lastLocation?.coordinate.longitude.description as? String ?? ""
                let location: [String: String] = [
                    "latitude" :lat,
                    "longitude" : long
                ]  //17.46646962576084, 78.37609064592026
//            let location: [String: String] = [
//                "latitude" :"17.46646962576084",
//                "longitude" :  "78.37609064592026"
//            ]
                let window = UIApplication.shared.windows.first!
                DispatchQueue.main.async {
                    LoadingOverlay.shared.showOverlay(view: window)
                }
                TrainerbyLocationAPI.postCalltoToken(parameters: location, details: "partial", pageNumber: self.pageNumber) { [weak self] trainerInfo  in
                    if trainerInfo.count > 0 {
                        self?.trainersInfo?.append(contentsOf: trainerInfo)
                       // self?.trainersInfo = trainerInfo
                        self?.pageNumber = self!.pageNumber + 1
                        DispatchQueue.main.async { [self] in
                            self?.isLoading = false
//                            self?.trainersCollectionView.collectionViewLayout.invalidateLayout()
                            self?.trainersCollectionView.reloadData()
                            LoadingOverlay.shared.hideOverlayView()
                        }
                    }else {
                        DispatchQueue.main.async {
                            LoadingOverlay.shared.hideOverlayView()
//                            self?.presentAlertWithTitle(title: "", message: "No trainer found.", options: "OK") {_ in
//                            }
                            self?.trainersCollectionView.reloadData()
                            self?.isLoading = true
                        }
                    }

                } errorHandler: { [weak self] error in
                    print(" error \(error)")
                    DispatchQueue.main.async {
                        LoadingOverlay.shared.hideOverlayView()
                    }
                    DispatchQueue.main.async {
                        self?.trainersCollectionView.reloadData()
                        self?.isLoading = true
                    }
                }
                
          //  }
        }
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
            case self.headerCollectionView:
            
            let noOfCellsInRow = 6

                       let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
                       let totalSpace = flowLayout.sectionInset.left
                           + flowLayout.sectionInset.right
                           + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

                       let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

                       return CGSize(width: size, height: 70)
            case self.trainersCollectionView:
            
            let noOfCellsInRow = 2

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
               flowLayout.scrollDirection = .vertical
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size, height: 140)
            
             default:
            print ("Default statement")
            return CGSize.zero
            
        }
        
        
       // return CGSize.init(width: collectionView.frame.width/7 - 5, height: 80)
    }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case self.headerCollectionView:
            switch indexPath.row {
            case 0:
                let storyboard = UIStoryboard(name: "TrainerList", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "trainerListVC") as! TrainersListViewController
                //controller.trainersInfo = self.trainersInfo
                self.navigationController?.pushViewController(controller, animated: true)
            case 1:
                let userdefaults = UserDefaults.standard
                if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin) {
                    if  savedValue == UserDefaultsKeys.guestLogin {
                        self.presentAlert(message: "Please Sign up to get a free access")
                        // self.popupBox()
                    }
                }
            
                
                
            case 2:
                isFromHomediet = true
                self.tabBarController?.selectedIndex = 2
            case 3:
                let userdefaults = UserDefaults.standard
                if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin) {
                    if  savedValue == UserDefaultsKeys.guestLogin {
                        self.presentAlert(message: "Please Sign up to access the 1o1 call features")
                        return
                    }
                }
                let storyboard = UIStoryboard(name: "CallViewController", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "CallViewController") as! CallViewController
                //controller.trainersInfo = self.trainersInfo
                self.navigationController?.pushViewController(controller, animated: true)
         
            case 4:
                let userdefaults = UserDefaults.standard
                if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin) {
                    if  savedValue == UserDefaultsKeys.guestLogin {
                        self.presentAlert(message: "Please Sign up to access the 1o1 progress photos")
                        return
                    }
                }
                let storyboard = UIStoryboard(name: "PhotoViewController", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
                //controller.trainersInfo = self.trainersInfo
                self.navigationController?.pushViewController(controller, animated: true)
               
                
                case 5:
                let userdefaults = UserDefaults.standard
                if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin) {
                    if  savedValue == UserDefaultsKeys.guestLogin {
                        self.presentAlert(message: "Please Sign up to access the BMI/BMR")
                        return
                    }else {
                        if TraineeDetails.traineeDetails?.profile_submission == false {
                            self.presentAlertWithTitle(title: "Profile Not Submitted", message: "Please submit your profile to view BMI/BMR", options: "OK") { (_) in
                                self.tabBarController?.tabBar.isHidden = true
                                let storyboard = UIStoryboard(name: "StartVC", bundle: nil)
                                let controller = storyboard.instantiateViewController(withIdentifier: "startVC") as! StartViewController
                                self.navigationController?.pushViewController(controller, animated: true)
                            }
                        }else {
                            let storyboard = UIStoryboard(name: "BMIBMRVC", bundle: nil)
                            let controller = storyboard.instantiateViewController(withIdentifier: "BMIBMRVC") as! BMIBMRViewController
                            //controller.trainersInfo = self.trainersInfo
                            self.navigationController?.pushViewController(controller, animated: true)
                        }
                    }
                }else {
                    if TraineeDetails.traineeDetails?.profile_submission == false {
                        self.presentAlertWithTitle(title: "Profile Not Submitted", message: "Please submit your profile to view BMI/BMR", options: "OK") { (_) in
                            self.tabBarController?.tabBar.isHidden = true
                            let storyboard = UIStoryboard(name: "StartVC", bundle: nil)
                            let controller = storyboard.instantiateViewController(withIdentifier: "startVC") as! StartViewController
                            self.navigationController?.pushViewController(controller, animated: true)
                        }
                    }else {
                        let storyboard = UIStoryboard(name: "BMIBMRVC", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "BMIBMRVC") as! BMIBMRViewController
                        //controller.trainersInfo = self.trainersInfo
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                }
                
                
            default:
                print("default statement")
            }
           
            
        case self.trainersCollectionView:
            let trainer = self.trainersInfo?[indexPath.row]
                   let storyboard = UIStoryboard(name: "TrainerDetailsVC", bundle: nil)
                   let controller = storyboard.instantiateViewController(withIdentifier: "TrainerDetailsVC") as! TrainerDetailsViewController
                   controller.trainersInfo = trainer
                   self.navigationController?.pushViewController(controller, animated: true)
            
        default:
            print("default statement")
        }

    }
    func rotateView(view: UIView, duration: Double = 5) {
        if view.layer.animation(forKey: kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")

            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float(.pi*2.0)
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity

            view.layer.add(rotationAnimation, forKey: kRotationAnimationKey)
        }
        
    }
    func stopRotatingView(view: UIView) {
        if view.layer.animation(forKey: kRotationAnimationKey) != nil {
            view.layer.removeAnimation(forKey: kRotationAnimationKey)
        }
    }
    func presentAlert(message:String) {
        let storyboard = UIStoryboard(name: "CustomAlertVC", bundle: nil)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "CAVC") as! CustomAlertViewController
        alertVC.customAlertDelegate = self
        alertVC.modalPresentationStyle = .custom
        alertVC.message = message
        present(alertVC, animated: false, completion: nil)
    }
    func popupBox() {
       
        
        let overlayAppearance = PopupDialogOverlayView.appearance()

        overlayAppearance.color           = .black
        overlayAppearance.blurRadius      = 20
        overlayAppearance.blurEnabled     = false
        overlayAppearance.liveBlurEnabled = false
        overlayAppearance.opacity         = 0.8
        
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.backgroundColor = UIColor.black.withAlphaComponent(1.0)
        dialogAppearance.titleFont            = UIFont(name: "Lato-Semibold", size: 14.0)!
        dialogAppearance.titleColor           = AppColours.textGreen
        dialogAppearance.titleTextAlignment   = .center
        dialogAppearance.messageFont          = UIFont(name: "Lato-Regular", size: 12)!
        dialogAppearance.messageColor         = AppColours.textGreen
        dialogAppearance.messageTextAlignment = .center
        
            let title = "Members Only"
            let message = "Sign up to get a free Subscription"

            let popup = PopupDialog(title: title,
                                    message: message,
                                    buttonAlignment: .horizontal,
                                    transitionStyle: .zoomIn,
                                    tapGestureDismissal: false,
                                    panGestureDismissal: false,
                                    hideStatusBar: true) {
                print("Completed")
            }
            let browsing = CancelButton(title: "Keep Browsing") {
            }
        CancelButton.appearance().buttonColor = .black
        CancelButton.appearance().titleColor = AppColours.textGreen
         CancelButton.appearance().titleFont = UIFont(name: "Lato-Regular", size: 12)!
               CancelButton.appearance().layer.cornerRadius = 10.0
               CancelButton.appearance().layer.borderColor = AppColours.greenBorder.cgColor
               CancelButton.appearance().layer.borderWidth = 1.0
        CancelButton.appearance().separatorColor = AppColours.lineColor
            let signUp = DefaultButton(title: "Sign Up") {
                DispatchQueue.main.async {
                    self.navigateToProfile()
                }
            }
        DefaultButton.appearance().buttonColor = .black
        DefaultButton.appearance().titleColor = AppColours.textGreen
        DefaultButton.appearance().layer.cornerRadius = 10.0
         DefaultButton.appearance().titleFont = UIFont(name: "Lato-Regular", size: 12)!
        DefaultButton.appearance().layer.borderColor = AppColours.greenBorder.cgColor
        DefaultButton.appearance().layer.borderWidth = 1.0
        DefaultButton.appearance().separatorColor = AppColours.lineColor
       
            popup.addButtons([browsing, signUp])
        popup.view.layer.cornerRadius = 20.0
            self.present(popup, animated: true, completion: nil)
        }
   func navigateToProfile() {
    
    self.tabBarController?.tabBar.isHidden = true
    let registration = SignUpViewController(nibName:"SignUpViewController", bundle:nil)
    self.navigationController?.pushViewController(registration, animated: true)
    

   }
}

extension UIImageView {
    func load(url: URL, width: CGFloat, height: CGFloat) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    let cgimage = image.cgImage!
                    let contextImage: UIImage = UIImage(cgImage: cgimage)
                    let contextSize: CGSize = contextImage.size
                    var posX: CGFloat = 0.0
                    var posY: CGFloat = 0.0
                    var cgwidth: CGFloat = CGFloat(width)
                    var cgheight: CGFloat = CGFloat(height)
                    
                    // See what size is longer and create the center off of that
                    if contextSize.width > contextSize.height {
                        posX = ((contextSize.width - contextSize.height) / 2)
                        posY = 0
                        cgwidth = contextSize.height
                        cgheight = contextSize.height
                    } else {
                        posX = 0
                        posY = ((contextSize.height - contextSize.width) / 2)
                        cgwidth = contextSize.width
                        cgheight = contextSize.width
                    }
                    
                    let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
                    
                    // Create bitmap image from context using the rect
                    let imageRef: CGImage = cgimage.cropping(to: rect)!
                    
                    // Create a new image based on the imageRef and rotate back to the original orientation
                    let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
                    
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
//        self.brandedBtn.isHidden = true
//        self.commonBtn.isHidden = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
//        self.brandedBtn.isHidden = true
//        self.commonBtn.isHidden = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchTrainersList), object: nil)
        self.perform(#selector(searchTrainersList), with: nil, afterDelay: 0.5)

    }
    @objc func searchTrainersList() {
        
       var idToken = ""
        
        let searchText = self.searchBar.text ?? ""
        if searchText.count == 0 { // If no search text is entered
            self.isLoading = false
            self.pageNumber = 0
            self.getTrainerInfo()
        }else {
            let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
            if token == nil {
                AWSUserSingleton.shared.getUserattributes()
            }
                var authenticatedHeaders: [String: String] {
                                           [
                                             HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                                               HeadersKeys.contentType: HeaderValues.json
                                           ]
                         }
                 TrainerSearch.searchTrainers(searchText: searchText , header: authenticatedHeaders) {[weak self] (trainerInfo) in
                     if trainerInfo != nil {
                          self?.trainersInfo = trainerInfo
                         DispatchQueue.main.async {
                                            self?.trainersCollectionView.reloadData()
         //                                   LoadingOverlay.shared.hideOverlayView()
                                        }
                     }else {
                          DispatchQueue.main.async {
                         self?.presentAlertWithTitle(title: "", message: "No trainer found.", options: "OK") {_ in
                             }
                             
                         }
                     }
                     
                 } errorHandler: { (error) in
                     
                 }
        }
       
       // }
       

    }
}
extension HomeViewController: CustomAlertViewDelegate {
    func okBtnTapped() {
    
    }
    
    
    func singUpBtnTapped() {
        self.navigateToProfile()
    }
}
