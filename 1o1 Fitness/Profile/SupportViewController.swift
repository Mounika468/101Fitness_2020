//
//  SupportViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 01/12/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class SupportViewController: UIViewController {

    @IBOutlet weak var contactView: CardView! {
        didSet {
            contactView.layer.cornerRadius = 0.0
        }
    }
    @IBOutlet weak var faqsView: CardView! {
        didSet {
            faqsView.layer.cornerRadius = 0.0
        }
    }
    @IBOutlet weak var appInfoLbl: UILabel!
    @IBOutlet weak var feedbackLbl: UILabel!
    @IBOutlet weak var contactUsLbl: UILabel!
    @IBOutlet weak var faqLbl: UILabel!
    @IBOutlet weak var appinfo: UIView!
    @IBOutlet weak var feedbackView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Support"
        
        let orderTapGesture = UITapGestureRecognizer()
        orderTapGesture.addTarget(self, action: #selector(self.faqsViewTouched(_:)))
        faqsView.addGestureRecognizer(orderTapGesture)
        
        let addressTapGesture = UITapGestureRecognizer()
        addressTapGesture.addTarget(self, action: #selector(self.feedbackViewTouched(_:)))
        feedbackView.addGestureRecognizer(addressTapGesture)
        let changePwdTapGesture = UITapGestureRecognizer()
        changePwdTapGesture.addTarget(self, action: #selector(self.contactTouched(_:)))
        contactView.addGestureRecognizer(changePwdTapGesture)
        
        
        appInfoLbl.textColor = AppColours.topBarGreen
        faqLbl.textColor = AppColours.topBarGreen
        contactUsLbl.textColor = AppColours.topBarGreen
        feedbackLbl.textColor = AppColours.topBarGreen
    }
    
    @objc func faqsViewTouched(_ sender: UITapGestureRecognizer) {
        
        let storyboard = UIStoryboard(name: "SupportViewController", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
        self.navigationController?.pushViewController(controller, animated: true)
        
        
    }
    @objc func feedbackViewTouched(_ sender: UITapGestureRecognizer) {
        
//        let storyboard = UIStoryboard(name: "SupportViewController", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "BillingAddressVC") as! BillingAddressVC
//        controller.addressArra = TraineeDetails.traineeDetails?.trainee_address
//        self.navigationController?.pushViewController(controller, animated: true)
        
        
    }
    @objc func contactTouched(_ sender: UITapGestureRecognizer) {
        
        let storyboard = UIStoryboard(name: "SupportViewController", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
