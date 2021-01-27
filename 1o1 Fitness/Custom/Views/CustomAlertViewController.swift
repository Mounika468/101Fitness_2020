//
//  CustomAlertViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 27/04/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
protocol CustomAlertViewDelegate {
    func singUpBtnTapped()
     func okBtnTapped()
}
enum ResponseType{
    case success
    case fail
}
enum AlertType{
    case registration
    case popup
}
class CustomAlertViewController: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var alertView: CardView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var successView: CardView!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var responseLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bLbl: UILabel!
    @IBOutlet weak var uLbl: UILabel!
   // @IBOutlet weak var successView: UIView!
    @IBOutlet weak var singUpBtn: UIButton!
    @IBOutlet weak var keepBrowseBtn: UIButton!
   // @IBOutlet weak var alertView: UIView!
    var message : String = ""
    var responseType: ResponseType = .success
      var alertType: AlertType = .popup
    var customAlertDelegate : CustomAlertViewDelegate?
   
       override func viewDidLoad() {
           super.viewDidLoad()
        self.successView.isHidden = true
        self.view.backgroundColor = .clear
        alertView.layer.cornerRadius = 20
        alertView.layer.borderWidth = 0.5
        alertView.backgroundColor = AppColours.alertBgColour
        alertView.layer.borderColor = UIColor.clear.cgColor
        
//        successView.layer.cornerRadius = 20
//               successView.layer.borderWidth = 0.5
//               successView.layer.borderColor = UIColor.lightGray.cgColor
        
//        singUpBtn.layer.cornerRadius = 15.0
//        singUpBtn.layer.borderWidth = 1.0
        singUpBtn.layer.borderColor = AppColours.textGreen.cgColor
//        keepBrowseBtn.layer.cornerRadius = 15.0
//        keepBrowseBtn.layer.borderWidth = 1.0
        keepBrowseBtn.layer.borderColor = AppColours.textGreen.cgColor
       // keepBrowseBtn.drawBorder(edges:[.top,.bottom] , borderWidth: 0.5, color: AppColours.lineColor, margin: 0)
         singUpBtn.drawBorder(edges:[.left] , borderWidth: 0.5, color: AppColours.lineColor, margin: 0)
           setUpAlertView()
        self.messageLbl.text = message
        okBtn.setTitleColor(AppColours.textGreen, for: .normal)
        okBtn.layer.borderWidth = 0.4
        //okBtn.layer.opacity = 0.6
        okBtn.layer.borderColor = AppColours.lineColor.cgColor
        self.topView.backgroundColor = AppColours.lineColor
        self.topView.alpha = 0.5
        self.bottomView.alpha = 0.5
        self.bottomView.backgroundColor = AppColours.lineColor
        
       }
    func displaySuccessView(){
        
        switch self.responseType {
        case .success:
            self.responseLbl.text = "Successfully Registered"
            self.imageView.image = UIImage(named: "ccomplete")
            case .fail:
                       self.responseLbl.text = "Registration failed"
                       self.imageView.image = UIImage(named: "rdelete")
        default:
                   self.responseLbl.text = ""
        }
      
    }
    @IBAction func okBtnTapped(_ sender: Any) {
         self.dismissAlert()
        if self.responseType == .success {
            self.customAlertDelegate?.okBtnTapped()
        }
    }
    @IBAction func signUpTapped(_ sender: Any) {
        self.dismissAlert()
        self.customAlertDelegate?.singUpBtnTapped()
    }
    @IBAction func keepBrowseTapped(_ sender: Any) {
        self.dismissAlert()
    }
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           
           UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 6, options: .curveEaseIn, animations: {
               self.alertView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
             self.successView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.6)
               
           }, completion: nil)
        switch self.alertType {
        case .registration:
            self.successView.isHidden = false
            self.alertView.isHidden = true
            
        default:
            self.successView.isHidden = true
            self.alertView.isHidden = false
        }
       }
       
       func setUpAlertView() {
           view.addSubview(alertView)
        view.addSubview(successView)
        // self.customAlertDelegate = self
           alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height).isActive = true
           alertView.widthAnchor.constraint(equalToConstant: view.bounds.width*0.8).isActive = true
       //    alertView.cancelActionButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        successView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        successView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height).isActive = true
        successView.widthAnchor.constraint(equalToConstant: view.bounds.width*0.8).isActive = true
           
       }
       
       func dismissAlert() {
           UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 4, options: .curveEaseIn, animations: {
               self.alertView.transform = CGAffineTransform.identity
              self.successView.transform = CGAffineTransform.identity
               self.view.backgroundColor = UIColor(white: 0, alpha: 0.0)
           }) { (completed) in
               self.dismiss(animated: false, completion: nil)
           }
           
       }

}
extension CustomAlertViewController: CustomAlertViewDelegate {
    func keepBrowsingBtnTapped() {
        self.dismissAlert()
    }
    func singUpBtnTapped() {
         self.dismissAlert()
    }
    func okBtnTapped() {
        self.dismissAlert()
    }
}
extension UIButton {

     func drawBorder(edges: [UIRectEdge], borderWidth: CGFloat, color: UIColor, margin: CGFloat) {
        for item in edges {
            let borderLayer: CALayer = CALayer()
            borderLayer.borderColor = color.cgColor
            borderLayer.borderWidth = borderWidth
            switch item {
            case .top:
                borderLayer.frame = CGRect(x: margin, y: 0, width: frame.width - (margin*2), height: borderWidth)
            case .left:
                borderLayer.frame =  CGRect(x: 0, y: margin, width: borderWidth, height: frame.height )
            case .bottom:
                borderLayer.frame = CGRect(x: margin, y: frame.height - borderWidth, width: frame.width - (margin*2), height: borderWidth)
            case .right:
                borderLayer.frame = CGRect(x: frame.width - borderWidth, y: margin, width: borderWidth, height: frame.height)
            case .all:
                drawBorder(edges: [.top, .left, .bottom, .right], borderWidth: borderWidth, color: color, margin: margin)
            default:
                break
            }
            self.layer.addSublayer(borderLayer)
        }
    }

}
