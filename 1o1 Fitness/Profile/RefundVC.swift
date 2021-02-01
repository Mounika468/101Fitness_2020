//
//  RefundVC.swift
//  1o1 Fitness
//
//  Created by Mounika Reddy on 27/01/21.
//  Copyright © 2021 Mounika.x.muduganti. All rights reserved.
//

import UIKit
enum RefundOptions {
    case other
    case switchProgram
    case notSupportive
}
class RefundVC: UIViewController {
    
    

    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var otherBtn: UIButton!
    @IBOutlet weak var switchBtn: UIButton!
    @IBOutlet weak var notSupBtn: UIButton!
    var programID : String = ""
    var navigationView = NavigationView()
    var otherSelected: Bool = false
    var comments : String = ""
    var reason : String = ""
    var refundOptions : RefundOptions = .notSupportive
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        xBarHeight = 80
        navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight))
        navigationView.titleLbl.text = "Refund"
        navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.leftArrow.isHidden = true
        navigationView.rightArrow.isHidden = true
        navigationView.backBtn.isHidden = false
        navigationView.backBtn.addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(navigationView)
        self.navigationController?.isNavigationBarHidden = true
        bgView.layer.borderWidth = 1
        bgView.layer.cornerRadius = 10
        bgView.layer.borderColor = AppColours.lineColor.cgColor
        self.hideKeyboardWhenTappedAround()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.changeViews(refundReason: .notSupportive)
    }
    
    @objc func backBtnTapped(sender : UIButton){
     self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnTapped(_ sender: Any) {
        if otherSelected == true {
            if otherSelected {
                guard let Othercomments = self.txtView.text, !Othercomments.isEmpty else {
                    
                    self.presentAlertWithTitle(title: "", message: "Please enter comments", options: "OK") { (_) in
                        
                    }
                    return
                }
                comments = self.txtView.text ?? ""
            }
        }
        let storyboard = UIStoryboard(name: "RefundAlertVC", bundle: nil)
        let customAlert = storyboard.instantiateViewController(withIdentifier: "RefundAlertVC") as! RefundAlertVC
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        customAlert.delegate = self
        self.navigationController?.present(customAlert, animated: true, completion: nil)
    }
    
    @IBAction func otherBtnTapped(_ sender: Any) {
        self.changeViews(refundReason: .other)
    }
    @IBAction func notSupportiveBtnTapped(_ sender: Any) {
        self.changeViews(refundReason: .notSupportive)
    }
    
    @IBAction func switchBtnTapped(_ sender: Any) {
        self.changeViews(refundReason: .switchProgram)
    }
    func changeViews(refundReason : RefundOptions) {
        switch refundReason {
        case .other:
            self.otherViewDisplay(isActive: true)
            self.notSupportiveDisplay(isActive: false)
            self.switchProgramDisplay(isActive: false)
            self.reason = "others"
            
        case .notSupportive:
            self.otherViewDisplay(isActive: false)
            self.notSupportiveDisplay(isActive: true)
            self.switchProgramDisplay(isActive: false)
            self.reason = "trainer is not supportive"
            
        case .switchProgram:
            self.otherViewDisplay(isActive: false)
            self.notSupportiveDisplay(isActive: false)
            self.switchProgramDisplay(isActive: true)
            self.reason = "i want to switch plan"
        default:
            self.otherViewDisplay(isActive: true)
            self.notSupportiveDisplay(isActive: false)
            self.switchProgramDisplay(isActive: false)
            self.reason = "others"
            
        }
    }
    func otherViewDisplay(isActive: Bool) {
        if !isActive {
            self.otherBtn.setImage(UIImage(named: "cradio"), for: .normal)
            self.otherSelected = false
        }
        else
        {
            self.otherSelected = true
            self.otherBtn.setImage(UIImage(named: "wradio"), for: .normal)
              
        }
    }
    func switchProgramDisplay(isActive: Bool) {
        if !isActive {
            self.switchBtn.setImage(UIImage(named: "cradio"), for: .normal)
        }
        else
        {
            
            self.switchBtn.setImage(UIImage(named: "wradio"), for: .normal)
              
        }
    }
    func notSupportiveDisplay(isActive: Bool) {
        if !isActive {
            self.notSupBtn.setImage(UIImage(named: "cradio"), for: .normal)
        }
        else
        {
            self.notSupBtn.setImage(UIImage(named: "wradio"), for: .normal)
              
        }
    }
    
}
extension RefundVC : UITextViewDelegate,RefundAlertViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        if text == "\n"
        {
            textView.resignFirstResponder()
            return false
        }
        return numberOfChars < 250    // 10 Limit Value
    }
    func yesButtonTapped() {
        DispatchQueue.main.async {
        LoadingOverlay.shared.showOverlay(view: UIApplication.shared.windows.first!)
        }
        RefundsAPI.postRefundCall(comments: self.comments, programId: self.programID, reason: self.reason) {
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
            self.navigationController?.popViewController(animated: true)
            
        } errorHandler: { (message) in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
            self.presentAlertWithTitle(title: "", message: message, options: "OK") { (_) in
                
            }
        }

    }
    
    func noButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
