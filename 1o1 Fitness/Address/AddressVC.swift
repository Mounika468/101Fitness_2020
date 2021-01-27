//
//  AddressVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 18/06/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import UserNotifications
import GooglePlaces
enum AddressTypeScreen {
    case editAddress
    case newAddressProfile
    case newAddressUser
}
class AddressVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var countryCode2Btn: UIButton!
    @IBOutlet weak var countryCode1Btn: UIButton!
    @IBOutlet weak var countryBtn: UIButton!
    @IBOutlet weak var stateBtn: UIButton!
    var selectedCountryId = ""
     var selectedCountry = ""
     var selectedStates = ""
    @IBOutlet weak var postBtn: UIButton! {
        didSet {
            self.postBtn.backgroundColor = AppColours.topBarGreen
        }
    }
    @IBOutlet weak var addressTypeTxtField: UITextField! {
        didSet {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            addressTypeTxtField.leftView = leftView
            addressTypeTxtField.leftViewMode = .always
        }
    }
    @IBOutlet weak var nametxtField: UnderlineTextField! {
        didSet {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            addressTypeTxtField.leftView = leftView
            addressTypeTxtField.leftViewMode = .always
        }
    }
    @IBOutlet weak var countryTxtField: UnderlineTextField! {
        didSet {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            addressTypeTxtField.leftView = leftView
            addressTypeTxtField.leftViewMode = .always
        }
    }
    @IBOutlet weak var stateTxtField: UnderlineTextField! {
        didSet {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            addressTypeTxtField.leftView = leftView
            addressTypeTxtField.leftViewMode = .always
        }
    }
    @IBOutlet weak var cityTxtField: UnderlineTextField! {
        didSet {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            addressTypeTxtField.leftView = leftView
            addressTypeTxtField.leftViewMode = .always
        }
    }
    @IBOutlet weak var pinCodeTxtField: UnderlineTextField! {
        didSet {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            addressTypeTxtField.leftView = leftView
            addressTypeTxtField.leftViewMode = .always
        }
    }
    @IBOutlet weak var landMarkTxtField: UnderlineTextField! {
        didSet {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            addressTypeTxtField.leftView = leftView
            addressTypeTxtField.leftViewMode = .always
        }
    }
    @IBOutlet weak var flatTxtField: UnderlineTextField! {
        didSet {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            addressTypeTxtField.leftView = leftView
            addressTypeTxtField.leftViewMode = .always
        }
    }
    @IBOutlet weak var mobileTxtField: UnderlineTextField! {
        didSet {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            addressTypeTxtField.leftView = leftView
            addressTypeTxtField.leftViewMode = .always
        }
    }
    @IBOutlet weak var codeTxtField: UITextField! {
        didSet {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            addressTypeTxtField.leftView = leftView
            addressTypeTxtField.leftViewMode = .always
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!
     var navigationView = NavigationView()
     var xBarHeight :CGFloat  = 0.0
    var kbSizeHeight : CGFloat = 0.0
    var focusManager : FocusManager?
    var paymentInfo: PaymentDetails?
    var addressTypeScreen: AddressTypeScreen = .newAddressUser
     var trainerId : String?
    var editAddress : Address?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         GMSPlacesClient.provideAPIKey("AIzaSyBOKPdHZddp0T8jKjVAZXK5oigoCt42QJM")
        self.navigationController?.isNavigationBarHidden = false
               xBarHeight = (navigationController?.navigationBar.frame.maxY)!
                navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight))
                            
                      navigationView.backgroundColor = AppColours.topBarGreen
                             navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
                             self.view.addSubview(navigationView)
                      self.navigationController?.isNavigationBarHidden = true
        codeTxtField.layer.cornerRadius = 10
        codeTxtField.layer.borderColor = UIColor.white.cgColor
        codeTxtField.layer.borderWidth = 0.5
        addressTypeTxtField.layer.cornerRadius = 10
        addressTypeTxtField.layer.borderColor = UIColor.white.cgColor
        addressTypeTxtField.layer.borderWidth = 0.5
        self.focusManager = FocusManager()
        self.postBtn.backgroundColor = AppColours.topBarGreen
        
        countryCode1Btn.layer.cornerRadius = 10
        countryCode1Btn.layer.borderColor = UIColor.white.cgColor
        countryCode1Btn.layer.borderWidth = 0.5
        countryCode2Btn.layer.cornerRadius = 10
        countryCode2Btn.layer.borderColor = UIColor.white.cgColor
        countryCode2Btn.layer.borderWidth = 0.5
        self.nametxtField.attributedPlaceholder = NSAttributedString(string: "Name",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.mobileTxtField.attributedPlaceholder = NSAttributedString(string: "Mobile Number",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.flatTxtField.attributedPlaceholder = NSAttributedString(string: "Flat No, Street",
               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.landMarkTxtField.attributedPlaceholder = NSAttributedString(string: "Landmark (Optional)",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.pinCodeTxtField.attributedPlaceholder = NSAttributedString(string: "Zipcode / Pincode",
               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.cityTxtField.attributedPlaceholder = NSAttributedString(string: "City",
               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
//        self.stateTxtField.attributedPlaceholder = NSAttributedString(string: "State",
//        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
//        self.countryTxtField.attributedPlaceholder = NSAttributedString(string: "Country",
//        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.addressTypeTxtField.attributedPlaceholder = NSAttributedString(string: "Enter Address type like Home/Work",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        if let focusManager = self.focusManager {
            focusManager.addItem(item: self.nametxtField)
            focusManager.addItem(item: codeTxtField)
              focusManager.addItem(item: self.mobileTxtField)
            focusManager.addItem(item: self.flatTxtField)
            focusManager.addItem(item: self.landMarkTxtField)
            focusManager.addItem(item: self.pinCodeTxtField)
            focusManager.addItem(item: self.cityTxtField)
           // focusManager.addItem(item: self.stateTxtField)
            focusManager.addItem(item: self.addressTypeTxtField)
         //   focusManager.addItem(item: self.countryTxtField)
//            focusManager.addItem(item: self.tfWorkPhone)
//            focusManager.addItem(item: self.tfWorkEmail)
            
          
            focusManager.focus(index: 0)
        }
        self.nametxtField.autocorrectionType = .yes
       
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
           let notifier = NotificationCenter.default
           notifier.addObserver(self,
                                selector: #selector(self.keyboardWillShow(_:)),
                                name: UIWindow.keyboardWillShowNotification,
                                object: nil)
           
           notifier.addObserver(self,
                                selector: #selector(self.keyboardWillHide(_:)),
                                name: UIWindow.keyboardWillHideNotification,
                                object: nil)
        
        switch self.addressTypeScreen {
        case .newAddressUser:
            navigationView.titleLbl.text = "Address"
        case .newAddressProfile:
            navigationView.titleLbl.text = "Add Address"
        case .editAddress:
            navigationView.titleLbl.text = "Edit Address"
            self.popupAddressFields()
        default:
            navigationView.titleLbl.text = "Address1"
        }
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           self.view.endEditing(true)
           NotificationCenter.default.removeObserver(self)

           super.viewWillDisappear(animated)
       }
    func popupAddressFields() {
        self.nametxtField.text = self.editAddress!.name
        self.codeTxtField.text = self.editAddress!.country_code
        self.countryCode1Btn.setTitle(self.editAddress!.country_code, for: .normal)
        self.mobileTxtField.text = self.editAddress!.mobile_number
        if let landmark = self.editAddress?.land_mark {
            self.landMarkTxtField.text = landmark
        }else {
             self.landMarkTxtField.text = ""
        }
        self.flatTxtField.text = self.editAddress?.address ?? ""
        self.addressTypeTxtField.text = self.editAddress!.address_type
        self.pinCodeTxtField.text = self.editAddress!.pincode
        self.cityTxtField.text = self.editAddress!.city
        self.countryBtn.setTitle( self.editAddress!.country, for: .normal)
          self.stateBtn.setTitle( self.editAddress!.state, for: .normal)
      //  self.stateTxtField.text = self.editAddress!.state
      //  self.countryTxtField.text = self.editAddress!.country
        self.selectedCountry = self.editAddress!.country ?? ""
        self.selectedStates = self.editAddress!.state ?? ""
    }
    @objc func backBtnTapped(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
       }
    var isIphoneX : Bool {
           
           get {
               guard #available(iOS 11.0, *) else {
                   return false
               }
               
               print(UIApplication.shared.windows[0].safeAreaInsets)
               if(UIApplication.shared.windows[0].safeAreaInsets.bottom != 0.0) {
                   return true
               }
               
               return false
           }
       }
    @IBAction func countryCode2BtnTapped(_ sender: Any) {
        countryCode2Btn.isSelected = true
        if countryCode1Btn.titleLabel?.text ?? "" == "+ 91" || countryCode1Btn.titleLabel?.text ?? "" == "+91"{
            countryCode1Btn.setTitle("+1", for: .normal)
        }else {
            countryCode1Btn.setTitle("+91", for: .normal)
        }
        countryCode2Btn.isHidden = true
    }
    
    @IBAction func countryCode1BtnTapped(_ sender: Any) {
        countryCode1Btn.isSelected = true
        countryCode2Btn.isHidden = false
        if countryCode1Btn.titleLabel?.text ?? "" == "+ 91" || countryCode1Btn.titleLabel?.text ?? "" == "+91"{
            countryCode2Btn.setTitle("+1", for: .normal)
        }else {
            countryCode2Btn.setTitle("+91", for: .normal)
        }
    }
    // MARK: - UITextFieldDelegate
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if textField == pinCodeTxtField {
        let maxLength = 6
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    if textField.keyboardType == .numberPad {
        // Check for invalid input characters
        if CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) {
            return false
        }
    }
    if textField == nametxtField {
            let allowedCharacters = CharacterSet(charactersIn:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvxyz").inverted
                let components = string.components(separatedBy: allowedCharacters)
                let filtered = components.joined(separator: "")
                
                if string == filtered {
                    
                    return true

                } else {
                    
                    return false
                }
            }
    return true
   }

    @IBAction func countryBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AddressPopVC", bundle: nil)
                    let alertVC = storyboard.instantiateViewController(withIdentifier: "AddressPopVC") as! AddressPopVC
                    alertVC.delegate = self
        alertVC.isContriesSelected = true
        // alertVC.navigationType = .profileMenu
          //  alertVC.selectedMeatArr = self.meatSelectedArr
                    alertVC.modalPresentationStyle = .custom
                    present(alertVC, animated: false, completion: nil)
    }
    @IBAction func stateBtnTapped(_ sender: Any) {
        if selectedCountryId.count == 0 {
            presentAlertWithTitle(title: "", message: "Please select country first", options: "OK") { (option) in

                                          }
        }else {
            let storyboard = UIStoryboard(name: "AddressPopVC", bundle: nil)
                        let alertVC = storyboard.instantiateViewController(withIdentifier: "AddressPopVC") as! AddressPopVC
                        alertVC.delegate = self
            
            alertVC.selectedCountryId = self.selectedCountryId
            alertVC.isContriesSelected = false
                        alertVC.modalPresentationStyle = .custom
                        present(alertVC, animated: false, completion: nil)
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if textField is UnderlineTextField {
            focusManager!.focusTouch(item: textField)
        }
        if textField == self.flatTxtField {
                textField.resignFirstResponder()
                let controller = GMSAutocompleteViewController()
            UINavigationBar.appearance().barTintColor = AppColours.topBarGreen
            UINavigationBar.appearance().tintColor = UIColor.white

          //  UISearchBar.appearance().setTextColor(UIColor.white)
            UISearchBar.appearance().barStyle = UIBarStyle.default
        //    UISearchBar.appearance().setPlaceholderTextColor(.white)
         //   UISearchBar.appearance().setSearchImageColor(.white)
            controller.view.backgroundColor = UIColor.black
                  controller.primaryTextColor = UIColor.white
                  controller.secondaryTextColor = UIColor.white
            controller.primaryTextHighlightColor = UIColor.white
                  controller.tableCellSeparatorColor = UIColor.lightGray
                  controller.tableCellBackgroundColor = UIColor.black
                controller.delegate = self
                present(controller, animated: true, completion: nil)
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

           
        }
        
    }
    
   func showFoodPreferences() {
       
   }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField is UnderlineTextField {
            let control = textField as! UnderlineTextField
            control.updateFocus(isFocus: false)
        }
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        let name = self.nametxtField.text
        self.codeTxtField.text = "+ 91"
        let countryCode = self.countryCode1Btn.titleLabel?.text ?? ""
//        self.countryCode1Btn.setTitle(self.editAddress!.country_code, for: .normal)
        let mobile = self.mobileTxtField.text
        let street = self.flatTxtField.text
              // let landmark = self.landMarkTxtField.text
               let city = self.cityTxtField.text
      //  let type = self..text
              
            let pincode = self.pinCodeTxtField.text
        if name?.count ?? 0 > 0 && countryCode.count > 0 && mobile?.count ?? 0 > 0 && street?.count ?? 0 > 0 && city?.count ?? 0 > 0  && pincode?.count ?? 0 > 0 {
            if self.mobileTxtField.text?.isPhoneNumber == false {
                
                presentAlertWithTitle(title: "", message: "Please enter valid phone number", options: "OK") { (option) in

                }
                return
            }
            self.postAddress()
        }else {
            presentAlertWithTitle(title: "", message: "Please enter all the fields", options: "OK") { (option) in

                           }
                           return
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        textField.resignFirstResponder()
        if textField is UnderlineTextField {
            focusManager!.focusNext()
        }
        
        return true
    }
    
    // MARK: - NotificationCenter
    @objc func keyboardWillShow(_ notification: NSNotification) {
        print("keyboardWillShow")
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            // iPhoneX
            var gapOffsetY : CGFloat = 0.0
            if self.isIphoneX == true {
                gapOffsetY = 34.0
            }
            self.kbSizeHeight = keyboardRectangle.height - gapOffsetY
            
            let contentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: self.kbSizeHeight, right: 0)
            self.scrollView.contentInset = contentInset
            self.scrollView.scrollIndicatorInsets = contentInset
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        print("keyboardWillHide")
        let contentInset: UIEdgeInsets = .zero
        self.scrollView.contentInset = contentInset
        self.scrollView.scrollIndicatorInsets = contentInset
        
        self.kbSizeHeight = 0
    }
    //MARK: POST Address
    func postAddress(){
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
        var landmark = ""
        if landMarkTxtField.text?.count ?? 0 > 0 {
            landmark = landMarkTxtField.text!
        }
       
        switch self.addressTypeScreen {
        case .newAddressUser, .newAddressProfile:
            let postBody : [String: Any] = ["address": flatTxtField.text!,"city": cityTxtField.text!,"state":self.selectedStates,"country": self.selectedCountry,"pincode": pinCodeTxtField.text!,"isPrimary": true, "name":nametxtField.text!,"country_code":self.countryCode1Btn.titleLabel?.text ?? "","mobile_number":mobileTxtField.text!,"address_type":addressTypeTxtField.text!,"land_mark":landmark]
            let jsonData = try! JSONSerialization.data(withJSONObject: postBody)
            AddressAPI.postAddress(parameters: [:], header: authenticatedHeaders, dataParams: jsonData, methodName: "post", successHandler: { [weak self] address in
                if address != nil {
                    switch self?.addressTypeScreen {
                    case .newAddressProfile:
                        DispatchQueue.main.async {
                             TraineeDetails.traineeDetails?.trainee_address = address
                        self?.presentAlertWithTitle(title: "Success", message: "Address added successfully", options: "OK") { (option) in
                            self?.navigationController?.popViewController(animated: true)
                        }
                        }
                    case .newAddressUser:
                        self?.subscribtionToProgram()
                    default:
                        self?.subscribtionToProgram()
                    }
                    
                }else {
                     DispatchQueue.main.async {
                   self?.presentAlertWithTitle(title: "Error", message: "Address adding failed", options: "OK") { (option) in
                   }
                    }
                }
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                }
               
            }) { [weak self] error in
                print(" error \(error)")
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                    self?.presentAlertWithTitle(title: "Error", message: "Address adding failed", options: "OK") { (option) in
                    }
                }
            }
        case .editAddress:
            let postBody : [String: Any] = ["address": flatTxtField.text!,"city": cityTxtField.text!,"state": self.selectedStates,"country": self.selectedCountry,"pincode": pinCodeTxtField.text!,"isPrimary": true, "name":nametxtField.text!,"country_code":self.countryCode1Btn.titleLabel?.text ?? "","mobile_number":mobileTxtField.text!,"address_type":addressTypeTxtField.text!,"land_mark":landmark,"id":self.editAddress?.id!]
            let jsonData = try! JSONSerialization.data(withJSONObject: postBody)
            AddressAPI.postAddress(parameters: [:], header: authenticatedHeaders, dataParams: jsonData, methodName: "put", successHandler: { [weak self] address in
                if address != nil {
                     DispatchQueue.main.async {
                         TraineeDetails.traineeDetails?.trainee_address = address
                                       self?.presentAlertWithTitle(title: "", message: "Address edited successfully", options: "OK") { (option) in
                                        self?.navigationController?.popViewController(animated: true)
                                       }
                                        }
                }else {
                     DispatchQueue.main.async {
                   self?.presentAlertWithTitle(title: "Error", message: "Address edit failed", options: "OK") { (option) in
                   }
                    }
                }
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                }
//                self?.subscribtionToProgram()
            }) {[weak self] error in
                print(" error \(error)")
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                    self?.presentAlertWithTitle(title: "Error", message: "Address edit failed", options: "OK") { (option) in
                    }
                }
            }
        default:
            print("nothing do")
        }
        
    }
    func subscribtionToProgram() {
        
        let window = UIApplication.shared.windows.first!
        DispatchQueue.main.async {
            LoadingOverlay.shared.showOverlay(view: window)
        }
        
        var country = ""
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
           }else {
            country = "NO"
           }
        }
        
        let postBody : [String: Any] = ["program_id":  ProgramDetails.programDetails.programId,"trainee_id": UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"trainer_id":self.trainerId!,"trainee_location":country]
        let jsonData = try! JSONSerialization.data(withJSONObject: postBody)
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        SubscriptionAPI.postSubscription(parameters: [:], header: authenticatedHeaders, dataParams: jsonData, successHandler: { [weak self]  paymentDetails in
            if paymentDetails != nil {
                self?.paymentInfo = paymentDetails
                DispatchQueue.main.async {
                    ProgramPaymentDetails.programPaymentDetails.PaymentInfo = paymentDetails
                    if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                        ProgramDetails.programDetails.subId = id
                    }
                    if let programId = UserDefaults.standard.string(forKey: ProgramDetails.programDetails.subId) {
                        UserDefaults.standard.removeObject(forKey: ProgramDetails.programDetails.subId)
                    }
                    UserDefaults.standard.set(ProgramDetails.programDetails.programId, forKey:ProgramDetails.programDetails.subId )
                    let programId = UserDefaults.standard.string(forKey: ProgramDetails.programDetails.subId)
                    UserDefaults.standard.set( ProgramDetails.programDetails.programStartDate, forKey:UserDefaultsKeys.programStartdate )
                    LoadingOverlay.shared.hideOverlayView()
                    let storyboard = UIStoryboard(name: "PaymentDetailVC", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "paymentVC") as! PaymentDetailVC
                    controller.trainerId = self?.trainerId ?? ""
                    self?.navigationController?.pushViewController(controller, animated: true)
                }
            }else {
                            DispatchQueue.main.async {
                    self?.presentAlertWithTitle(title: "Error", message: "Please try after sometime", options: "OK") { (option) in
                               }
                }
            }
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
        }) { [weak self] error in
            print(" error \(error)")
           
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                self?.presentAlertWithTitle(title: "Error", message: "Please try after sometime", options: "OK") { (option) in
                           }
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
    
extension AddressVC :  UIViewControllerTransitioningDelegate{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController:presented, presenting: presenting)
    }
}
extension AddressVC: selectedValuesDelegate {
    func selectedCountryId(cname: String, id: String) {
        self.countryBtn.setTitle(cname, for: .normal)
        self.selectedCountryId = id
         self.selectedCountry = cname
    }
    func selectedState(states: String) {
        self.stateBtn.setTitle(states, for: .normal)
         self.selectedStates = states
    }
}
extension AddressVC: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {

    let city = place.addressComponents?.first(where: { $0.type == "locality" })?.name
    let postal_code = place.addressComponents?.first(where: { $0.type == "postal_code" })?.name
     let country = place.addressComponents?.first(where: { $0.type == "country" })?.name
     let state = place.addressComponents?.first(where: { $0.type == "administrative_area_level_1" })?.name
     let area = place.addressComponents?.first(where: { $0.type == "sublocality_level_1" })?.name
     let area1 = place.addressComponents?.first(where: { $0.type == "sublocality_level_2" })?.name
      let neighborhood = place.addressComponents?.first(where: { $0.type == "neighborhood" })?.name
     let street = place.addressComponents?.first(where: { $0.type == "sublocality_level_3" })?.name
   // print("locality: \(name)")
    
    var keys = [String]()
     place.addressComponents?.forEach{keys.append($0.type)}
     var values = [String]()
     place.addressComponents?.forEach({ (component) in
         keys.forEach{ component.type == $0 ? values.append(component.name): nil}
     })
     print(values)
    dismiss(animated: true, completion: nil)
    self.cityTxtField.text = city
    self.pinCodeTxtField.text = postal_code
    self.countryBtn.setTitle(country, for: .normal)
    self.selectedCountry = country ?? ""
    self.stateBtn.setTitle(state, for: .normal)
    self.selectedStates = state ?? ""
    var address = place.name ?? ""
    if street != nil {
        address = street!
    }
    if neighborhood != nil {
        if address.count > 0 {
            address = "\(address), \(neighborhood!)"
        }else {
            address = "\(neighborhood!)"
        }
        
    }
    if area1 != nil {
        if address.count > 0 {
             address = "\(address), \(area1!)"
        }else {
            address = "\(area1!)"
        }
        
    }
    if area != nil {
        if address.count > 0 {
             address = "\(address), \(area!)"
        }else {
            address = "\(area!)"
        }
           
       }
    self.flatTxtField.text = address
    self.flatTxtField .resignFirstResponder()
    textFieldDidEndEditing(self.flatTxtField)
   // self.stateTxtField.text = state
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: \(error)")
     self.flatTxtField .resignFirstResponder()
    textFieldDidEndEditing(self.flatTxtField)
    dismiss(animated: true, completion: nil)
  }

  // User cancelled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    print("Autocomplete was cancelled.")
     self.flatTxtField .resignFirstResponder()
    textFieldDidEndEditing(self.flatTxtField)
    dismiss(animated: true, completion: nil)
  }
}
