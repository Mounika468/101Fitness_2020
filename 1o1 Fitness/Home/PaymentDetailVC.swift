import UIKit
import Razorpay
import Stripe
let razorpayName = "Razorpay"

class PaymentDetailVC: UIViewController {

    var paymentInfo : PaymentDetails?
     var addressArra: [Address]?
    @IBOutlet weak var addressTblView: UITableView!
    @IBOutlet weak var totalAmtLbl: UILabel!
    @IBOutlet weak var taxAmtLbl: UILabel!
    @IBOutlet weak var couponAmtLbl: UILabel!
    @IBOutlet weak var packageAmtLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var packagenameLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileImg: UIImageView! {
        didSet {
            self.profileImg.layer.cornerRadius = 0.5 * profileImg.bounds.size.width
                              self.profileImg.clipsToBounds = true
                              self.profileImg.layer.borderColor = AppColours.appGreen.cgColor
                              self.profileImg.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var makePaymentBtn: UIButton! {
        didSet {
            self.makePaymentBtn.backgroundColor = AppColours.topBarGreen
        }
    }
    @IBOutlet weak var couponBg: UIView!
    @IBOutlet weak var couponTxtField: UITextField!
    var navigationView : NavigationView?
     private var razorpay: RazorpayCheckout!
    var orderDetails : OrderDetails?
     var trainerId : String = ""
    var selectedAddressId : String = ""
    var selectedIndex : Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        let xBarHeight = navigationController?.navigationBar.frame.maxY
        // Do any additional setup after loading the view.
        navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight!))
        navigationView?.titleLbl.text = "Payment"
        navigationView!.backgroundColor = AppColours.topBarGreen
        // Do any additional setup after loading the view.
        //  navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64))
        navigationView!.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(navigationView!)
        self.navigationController?.isNavigationBarHidden = true
        self.makePaymentBtn.backgroundColor = AppColours.topBarGreen
        addressTblView.separatorColor = UIColor.lightGray
        self.layoutView()
        self.couponBg.layer.cornerRadius = 10.0
        self.couponBg.backgroundColor = UIColor.black
        self.couponBg.layer.borderWidth = 0.2
        self.couponBg.layer.borderColor = UIColor.lightGray.cgColor
        self.couponTxtField.attributedPlaceholder = NSAttributedString(string: "Apply coupon code",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        addressTblView.tableFooterView = UIView()
        addressTblView.separatorColor = UIColor.lightGray.withAlphaComponent(0.5)
    }
    func layoutView(){
        self.paymentInfo = ProgramPaymentDetails.programPaymentDetails.PaymentInfo
        var currencyString = ""
       // let currency = self.paymentInfo?.currency?[0]
        let currency = self.paymentInfo!.currency_id!
        switch currency {
        case "USD":
            currencyString = "$"
        case "INR":
           currencyString = "\u{20B9}"
        default:
            print()
        }
        self.profileImg.loadImage(url: URL(string: (self.paymentInfo!.profile_image?.profileImagePath)!)!)
        if let lastname = self.paymentInfo!.last_name {
             self.nameLbl.text = (self.paymentInfo?.first_name)! + " " + lastname
        }else {
             self.nameLbl.text = (self.paymentInfo?.first_name)!
        }
        //"\(currencyString)" + "\(self.paymentInfo!.price)"
      
        self.packagenameLbl.text = self.paymentInfo!.program_name
        self.durationLbl.text = "\(self.paymentInfo!.programDuration)" + " Week"
         self.priceLbl.text =  String(format: "%@ %.2f", currencyString,Double(self.paymentInfo!.price))
        // self.packageAmtLbl.text = "\(currencyString)" + "\(self.paymentInfo!.program_amount)"
        self.packageAmtLbl.text = String(format: "%@ %.2f", currencyString,self.paymentInfo!.program_amount)
        self.couponAmtLbl.text = "\(currencyString)" + "0.00"
         self.taxAmtLbl.text = String(format: "%@ %.2f", currencyString,Double(self.paymentInfo!.tax_amount))
         self.totalAmtLbl.text = String(format: "%@ %.2f", currencyString,Double(self.paymentInfo!.total_amount))
        
        let nib = UINib(nibName: "AddressTableViewCell", bundle: nil)
        self.addressTblView.register(nib, forCellReuseIdentifier: "addressCell")
        if self.paymentInfo!.key_name.count > 0 {
       // razorpay = RazorpayCheckout.initWithKey(self.paymentInfo!.key_name,andDelegate: self)
            razorpay = RazorpayCheckout.initWithKey(self.paymentInfo!.key_name, andDelegateWithData: self)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
           self.addressArra = self.paymentInfo?.address
           self.addressTblView.reloadData()
       }
    @objc func backBtnTapped(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func makePaymentBtnTapped(_ sender: Any) {
        
        if self.selectedAddressId.count > 0 {
            self.subscribtionToProgram()
            self.viewWillAppear(true)
        }else {
            self.generateOrderDetails()
        }
    }
   
    func generateOrderDetails() {
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
        var currencyName = "usd"
        if self.paymentInfo?.paymentgateway_name == razorpayName {
            currencyName = "INR"
        }
        var addressId = ""
        for index in 0...self.paymentInfo!.address!.count - 1 {
            
            let address = self.paymentInfo!.address![index]
            if address.isPrimary! == true {
                addressId = address.id!
            }
        }
        
        let postBody : [String: Any] = ["amount_without_tax":self.paymentInfo!.price,"order_purchase_date": Date.getCurrentDateInFormat(format: "yyyy-MM-dd") ,"order_status":"1o1_new","payment_type_id":self.paymentInfo!.payment_type_id,"program_id":ProgramDetails.programDetails.programId,"tax_brack_up_id":self.paymentInfo!.tax_break_up_id,"total_amount":self.paymentInfo!.total_amount,"trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"payment_mode":"card","address_id":addressId,"currency_id":self.paymentInfo!.currency_id!]
                   let jsonData = try! JSONSerialization.data(withJSONObject: postBody)
        SubscriptionAPI.postToOrderId(parameters: [:], header: authenticatedHeaders, dataParams: jsonData, successHandler:  { [weak self] orderDetails  in
            print("order details \(orderDetails)")
            self?.orderDetails = orderDetails
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
            if  self?.orderDetails != nil && self?.orderDetails?.order_id != 0 {

                if self?.paymentInfo?.paymentgateway_name == razorpayName {
                    self?.navigateToRazorPay()
                }else{
                    self?.stripePayment(secrete:orderDetails.stripe_client_secret!)
                }
                
            }else {
                self?.presentAlertWithTitle(title: "Failure", message: "Fetching order details failed", options: "OK") { (option) in
                }
            }
            
        }) {  error in
            print(" error \(error)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                self.presentAlertWithTitle(title: "Failure", message: "Fetching order details failed", options: "OK") { (option) in
                }
            }
            
        }
    }
    func navigateToRazorPay() {
       let address =  self.addressArra![0]
       let options: [String:Any] = [
            "amount": "\(self.paymentInfo!.total_amount*100)", //This is in currency subunits. 100 = 100 paise= INR 1.
            "currency": "\(self.paymentInfo!.currency_id!)",//We support more that 92 international currencies.
            "description": "To subscribe workout program",
            "order_id": "\(self.orderDetails!.paymentgateway_order_id)",
            "image": "https://url-to-image.png",
            "name": "\(self.paymentInfo!.program_name)",
            "prefill": [
                "contact": "\(address.mobile_number!)",
                "email": "foo@bar.com"
            ],
            "theme": [
                "color": "#F37254"
            ]
        ]
     razorpay.open(options)
    }
    func stripePayment(secrete:String) {
        Stripe.setDefaultPublishableKey(self.paymentInfo!.key_name)
        let config = STPPaymentConfiguration()
        config.requiredBillingAddressFields = .full
        let checkoutViewController = CheckoutViewController()
        checkoutViewController.paymentIntentClientSecret = secrete
        checkoutViewController.orderId = self.orderDetails?.order_id ?? 0
        checkoutViewController.programDuration = self.paymentInfo!.programDuration
        self.navigationController?.pushViewController(checkoutViewController, animated: true)

    }
    func subscribtionToProgram() {
           

            let window = UIApplication.shared.windows.first!
            DispatchQueue.main.async {
                LoadingOverlay.shared.showOverlay(view: window)
            }
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
         let postBody : [String: Any] = ["program_id":  ProgramDetails.programDetails.programId,"trainee_id": UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"trainer_id":self.trainerId,"address_id":self.selectedAddressId,"trainee_location":country]
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
                     self?.generateOrderDetails()
                    }
                }else {
                  DispatchQueue.main.async {
                    self?.presentAlertWithTitle(title: "", message: "No data available for this trainer", options: "OK") { (option) in
                    }
                 }
                }
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                }
            }) { [weak self] error in
                print(" error \(error)")
                self?.presentAlertWithTitle(title: "Error", message: "Please try after sometine", options: "OK") { (option) in
                }
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                }
            }
       // }
       }
    
}
extension PaymentDetailVC: UITableViewDelegate, UITableViewDataSource {

func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
   }
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //return 2
    return self.addressArra?.count ?? 0
}
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell")
        as? AddressTableViewCell
        else {
            return UITableViewCell()
    }
    let address = self.addressArra![indexPath.row]
//    if let address = address.address {
//        cell.nameLbl.text = address
//    }else {
//
//    }
//     cell.nameLbl.text = self.paymentInfo!.first_name
    cell.nameLbl.text = address.name ?? ""
    cell.btnCheck.tag = indexPath.row
    cell.btnCheck.addTarget(self, action: #selector(self.addressSelected(_:)), for: .touchUpInside)
    cell.cityLbl.text = address.state
    cell.phonrLbl.text = address.country
    cell.streetLbl.text = address.city
    if address.address_type?.count != 0 {
        cell.addressTypeLbl.text = address.address_type
    }
     
    if (self.selectedIndex != nil && indexPath.row == self.selectedIndex!)  {
        if cell.btnCheck.currentImage == UIImage(named: "wradio") {
            cell.btnCheck.setImage(UIImage(named: "cradio"), for: .normal)
            self.selectedAddressId = ""
        }else {
            cell.btnCheck.setImage(UIImage(named: "wradio"), for: .normal)
        }
    }else {
        
            cell.btnCheck.setImage(UIImage(named: "cradio"), for: .normal)
    }
    if address.isPrimary! == true &&  self.selectedIndex == nil{
        cell.btnCheck.setImage(UIImage(named: "wradio"), for: .normal)
         self.selectedAddressId = address.id ?? ""
    }
     cell.layoutIfNeeded()
    return cell
}

func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
    return 0;
}
    @objc func addressSelected(_ button: UIButton) {
        
        let index = button.tag
        self.selectedIndex = index
         let address = self.addressArra![index]
        self.selectedAddressId = address.id!
        self.addressTblView.reloadData()
//        let cell = self.addressTblView.cellForRow(at: indexpath as IndexPath) as? AddressTableViewCell
//        cell?.btnCheck.setImage(UIImage(named: "scheck"), for: .normal)
    }
}

extension PaymentDetailVC: RazorpayPaymentCompletionProtocolWithData {
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
       
    }
    
    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
        self.syncPayment(payment_id, signature: response?["razorpay_signature"] as! String)
       
    }
}
extension PaymentDetailVC: RazorpayPaymentCompletionProtocol {
    func onPaymentSuccess(_ payment_id: String) {
//        let alert = UIAlertController(title: "Paid", message: "Payment Success", preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//        alert.addAction(action)
       // self.present(alert, animated: true,completion: nil)
    }
    func syncPayment(_ payment_id: String,signature:String) {
        
        let postBody : [String: Any] = ["total_amount":self.paymentInfo!.total_amount,"razorpay_payment_id":payment_id ,"razorpay_order_id":self.orderDetails?.paymentgateway_order_id,"Razorpay_signature":signature,"payment_type_id":self.paymentInfo!.payment_type_id,"status":"Success","currency_id" : self.paymentInfo!.currency_id!]
        let jsonData = try! JSONSerialization.data(withJSONObject: postBody)
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        var authenticatedHeaders: [String: String] {
                   [
                       HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                       HeadersKeys.contentType: HeaderValues.json
                   ]
               }
            SubscriptionAPI.SyncPaymentToServer(parameters: [:], header: authenticatedHeaders, dataParams: jsonData, successHandler: { [weak self] in
                DispatchQueue.main.async {
                    //ProgramDetails.programDetails.programStartDate = Date.getCurrentDateInFormat(format: "dd/MM/yyyy")
                    LoadingOverlay.shared.hideOverlayView()
                   // self?.perform(#selector(<#T##@objc method#>), with: <#T##Any?#>, afterDelay: <#T##TimeInterval#>)
                  //  self?.perform(#selector(getOrderSuccessDetails:), with: nil, afterDelay: 2.0)
                    
                  //  self?.perform(#selector(self?.getOrderSuccessDetails), with: nil, afterDelay: 2.0)
                 //   self?.getOrderSuccessDetails(orderId: self?.orderDetails?.order_id ?? 0)
                    let storyboard = UIStoryboard(name: "SuccessVC", bundle: nil)
                     let controller = storyboard.instantiateViewController(withIdentifier: "successVC") as! SuccessVC
                    controller.programDuration = (self?.paymentInfo!.programDuration)!
                    controller.orderId = self?.orderDetails?.order_id ?? 0
                    controller.paymentStatus = .success
                    self?.navigationController?.pushViewController(controller, animated: true)
                }
            }) {  error in
                print(" error \(error)")
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                    let storyboard = UIStoryboard(name: "SuccessVC", bundle: nil)
                     let controller = storyboard.instantiateViewController(withIdentifier: "successVC") as! SuccessVC
                    controller.programDuration = (self.paymentInfo!.programDuration)
                    controller.paymentStatus = .failure
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
    }
        
    func onPaymentError(_ code: Int32, description str: String) {
        let alert = UIAlertController(title: "Error", message: "\(code)\n\(str)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    @objc func getOrderSuccessDetails(orderId:Int) {
        LoadingOverlay.shared.showOverlay(view: self.view)
        
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
        
        ProgramAPI.getDetailsForProgram(header: authenticatedHeaders, traineeId: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, orderId: "\(orderId)")  { [weak self] (details) in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                if details != nil {
                    let storyboard = UIStoryboard(name: "SuccessVC", bundle: nil)
                     let controller = storyboard.instantiateViewController(withIdentifier: "successVC") as! SuccessVC
                    controller.programDuration = (self?.paymentInfo!.programDuration)!
                    controller.paymentStatus = .success
                    controller.programDetails = details
                    self?.navigationController?.pushViewController(controller, animated: true)

                }else {
                    self?.presentAlertWithTitle(title: "", message:"No data found", options: "OK") { (_) in
                }
                }
            }
            
        } errorHandler: {[weak self] (error) in
            DispatchQueue.main.async {
            LoadingOverlay.shared.hideOverlayView()
                //self?.presentAlertWithTitle(title: "Error", message:"\(error.errorDescription)", options: "OK") { (_) in
                
          //  }
            }
        }

    }
}
