//
//  ProgramDetailsViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 29/10/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class ProgramDetailsViewController: UIViewController {
    @IBOutlet weak var amountValLbl: UILabel!
    @IBOutlet weak var discValLbl: UILabel!
    
    @IBOutlet weak var totalValLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var discLbl: UILabel!
    @IBOutlet weak var taxvalLbl: UILabel!
    @IBOutlet weak var taxLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var sDataValLbl: UILabel!
    @IBOutlet weak var sDateLbl: UILabel!
    @IBOutlet weak var prValLbl: UILabel!
    @IBOutlet weak var prLbl: UILabel!
    @IBOutlet weak var idValLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var phoneValLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var emailValLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var nameValLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var tansitionValLbl: UILabel!
    @IBOutlet weak var transitionLbl: UILabel!
    var navigationView = NavigationView()
    var programsDetails : MyProgramsDetails?
    var isFromOrderScreen : Bool = false
   // var orderId : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100))
        navigationView.backgroundColor = AppColours.topBarGreen
        
        navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        navigationView.addBtn.isHidden = true
        self.view.addSubview(navigationView)
        self.idLbl.textColor = AppColours.textGreen
        self.prLbl.textColor = AppColours.textGreen
        self.sDateLbl.textColor = AppColours.textGreen
        self.amountLbl.textColor = AppColours.textGreen
        self.taxLbl.textColor = AppColours.textGreen
        self.discLbl.textColor = AppColours.textGreen
        self.totalLbl.textColor = AppColours.textGreen
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setupView()
        if self.isFromOrderScreen == true {
            navigationView.titleLbl.text = "Invoice Details"
        }else {
            navigationView.titleLbl.text = "Program Details"
        }
        
    }
    @objc func backBtnTapped(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
       }
    func setupView() {
      //  self.taxvalLbl.text = "programsDetails.ta"
        self.tansitionValLbl.text = programsDetails?.invoice_number ?? ""
        self.nameValLbl.text = programsDetails?.name ?? ""
        self.emailValLbl.text = programsDetails?.email ?? ""
        self.phoneValLbl.text = programsDetails?.phoneNumber ?? ""
        let invoiceDate = String(( programsDetails?.invoice_date!.prefix(10))!) as String
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let indate = dateFormatter.date(from: invoiceDate)
        let indate1 = Date.getDateInFormat(format: "MMM d, yyyy", date: indate!)
        self.idValLbl.text = indate1
        self.prValLbl.text = programsDetails?.programName ?? ""
        
        let start = String((programsDetails?.program_start_date!.prefix(10))!) as String
        let date = dateFormatter.date(from: start)
        let date1 = Date.getDateInFormat(format: "MMM d, yyyy", date: date!)
        
        self.sDataValLbl.text = date1
        if programsDetails?.currencyPaidIn ?? "" == "INR"{
            self.amountValLbl.text = String(format:"\u{20B9} %.2f", programsDetails?.price ?? 0.0)
            self.taxvalLbl.text = String(format:"\u{20B9} %.2f", programsDetails?.tax_amount ?? 0.0)
            self.discValLbl.text = String(format:"\u{20B9} %.2f", programsDetails?.discount_amount ?? 0.0)
            self.totalValLbl.text = String(format:"\u{20B9} %.2f", programsDetails?.total_amount ?? 0.0)
            
        }else {
            self.amountValLbl.text = String(format:"$ %.2f", programsDetails?.price ?? 0.0)
            self.taxvalLbl.text = String(format:"$ %.2f", programsDetails?.tax_amount ?? 0.0)
            self.discValLbl.text = String(format:"$ %.2f", programsDetails?.discount_amount ?? 0.0)
            self.totalValLbl.text = String(format:"$ %.2f", programsDetails?.total_amount ?? 0.0)
        }
        
        
    }
    
    
   

}
