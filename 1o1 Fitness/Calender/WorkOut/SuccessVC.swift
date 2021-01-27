//
//  SuccessVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 12/06/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
enum PaymentStatus {
    case success
    case failure
}
class SuccessVC: UIViewController {

    @IBOutlet weak var sepLbl: UILabel!
    @IBOutlet weak var totalValLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var disValLbl: UILabel!
    @IBOutlet weak var dicLbl: UILabel!
    @IBOutlet weak var taxValLbl: UILabel!
    @IBOutlet weak var taxLbl: UILabel!
    @IBOutlet weak var ppValLbl: UILabel!
    @IBOutlet weak var ppLbl: UILabel!
    @IBOutlet weak var osLbl: UILabel!
    @IBOutlet weak var odValLbl: UILabel!
    @IBOutlet weak var odLbl: UILabel!
    @IBOutlet weak var oiValLbl: UILabel!
    @IBOutlet weak var oiLbl: UILabel!
    @IBOutlet weak var pnvalLbl: UILabel!
    @IBOutlet weak var pnLbl: UILabel!
    @IBOutlet weak var nameValLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var pdLbl: UILabel!
    @IBOutlet weak var okBtn: UIImageView!
    @IBOutlet weak var responseMsgLbl: UILabel!
   // @IBOutlet weak var programLbl: UILabel!
    var programDuration: Int = 0
    var paymentStatus: PaymentStatus?
    var programDetails : MyProgramsDetails?
    var orderId : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        switch paymentStatus {
        case .success:
            okBtn.image = UIImage(named: "right")
            responseMsgLbl.text = "Thank You! Your Payment is Successful"
            self.sucessViewSetUp(isHidden: true)
           // self.setValues()
          //  self.getOrderSuccessDetails(orderId: self.orderId)
         //   programLbl.text = "Thank you for subscribing \(programDuration) week program"
            case .failure:
            okBtn.image = UIImage(named: "wrong")
            responseMsgLbl.text = "Your Payment is Failed"
         //   programLbl.text = ""
                self.sucessViewSetUp(isHidden: true)
        default:
             okBtn.image = UIImage(named: "wrong")
        }
        self.pdLbl.textColor = AppColours.graphYello
        self.osLbl.textColor = AppColours.graphYello
        self.nameLbl.textColor = AppColours.appGreen
        self.pnLbl.textColor = AppColours.appGreen
        self.oiLbl.textColor = AppColours.appGreen
        self.odLbl.textColor = AppColours.appGreen
        self.ppLbl.textColor = AppColours.appGreen
        self.taxLbl.textColor = AppColours.appGreen
        self.dicLbl.textColor = AppColours.appGreen
        self.totalLbl.textColor = AppColours.appGreen
    }
    
    func sucessViewSetUp(isHidden:Bool) {
        self.pdLbl.isHidden = isHidden
        self.nameLbl.isHidden = isHidden
        self.nameValLbl.isHidden = isHidden
        self.pnLbl.isHidden = isHidden
        self.pnvalLbl.isHidden = isHidden
        self.oiLbl.isHidden = isHidden
        self.oiValLbl.isHidden = isHidden
        self.odLbl.isHidden = isHidden
        self.odValLbl.isHidden = isHidden
        
        self.osLbl.isHidden = isHidden
        self.ppLbl.isHidden = isHidden
        self.ppValLbl.isHidden = isHidden
        self.taxLbl.isHidden = isHidden
        self.taxValLbl.isHidden = isHidden
        self.dicLbl.isHidden = isHidden
        self.disValLbl.isHidden = isHidden
        self.totalLbl.isHidden = isHidden
        self.totalValLbl.isHidden = isHidden
        self.sepLbl.isHidden = isHidden
    }
    
    func setValues() {
        self.nameValLbl.text = self.programDetails?.name ?? ""
        self.pnvalLbl.text = self.programDetails?.programName ?? ""
        self.oiValLbl.text = String(format: "%d", self.programDetails?.order_id ?? 0)
        
        
        
        let invoiceDate = String(( programDetails?.invoice_date!.prefix(10))!) as String
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let indate = dateFormatter.date(from: invoiceDate)
        let indate1 = Date.getDateInFormat(format: "MMM d, yyyy", date: indate!)
        self.odValLbl.text = indate1
        
        self.ppValLbl.text = String(format: "%.2f", self.programDetails?.price ?? 0)
        self.taxValLbl.text = String(format: "%.2f", self.programDetails?.tax_amount ?? 0)
        self.disValLbl.text = String(format: "%.2f", self.programDetails?.discount_amount ?? 0)
        self.totalValLbl.text = String(format: "%.2f", self.programDetails?.total_amount ?? 0)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func okBtnAction(_ sender: Any) {
        switch paymentStatus {
        case .success:
              if  TraineeInfo.details.profile_submission  == true {
                               self.navigationController?.popToRootViewController(animated: true)
              }else {
                let storyboard = UIStoryboard(name: "StartVC", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "startVC") as! StartViewController
                self.navigationController?.pushViewController(controller, animated: true)
              }
             
            
        case .failure:
             self.navigationController?.popViewController(animated: true)
            print("failure")
        default:
            self.tabBarController?.selectedIndex = 2
        }
    }
     func getOrderSuccessDetails(orderId:Int) {
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
                    self?.programDetails = details
                    self?.setValues()
//                    let storyboard = UIStoryboard(name: "SuccessVC", bundle: nil)
//                     let controller = storyboard.instantiateViewController(withIdentifier: "successVC") as! SuccessVC
//                    controller.programDuration = (self?.paymentInfo!.programDuration)!
//                    controller.paymentStatus = .success
//                    controller.programDetails = details
//                    self?.navigationController?.pushViewController(controller, animated: true)

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
