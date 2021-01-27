//
//  WorkOutHistoryVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 06/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
protocol workOutDelegate {
    func workoutHistroy(descr:String)
}
class WorkOutHistoryVC: UIViewController {
   // @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var bgView: CardView!
    @IBOutlet weak var txtView: UITextView! {
        didSet {
            txtView.text = "Describe your workout history"
            txtView.textColor = UIColor.lightGray
        }
    }
    @IBOutlet weak var txtBgView: UIView!
    @IBOutlet weak var okBtn: UIButton!
    var workOutDelegate: workOutDelegate?
     var workOutDesc: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtBgView.layer.borderWidth = 0.3
        self.txtBgView.layer.cornerRadius = 10.0
        self.txtBgView.layer.borderColor = AppColours.textGreen.cgColor
        self.okBtn.setTitleColor(AppColours.textGreen, for: .normal)
        // Do any additional setup after loading the view.
//        bgView.layer.cornerRadius = 20
//        bgView.layer.borderWidth = 0.2
//        bgView.layer.borderColor = UIColor.lightGray.cgColor
        okBtn.setTitleColor(AppColours.textGreen, for: .normal)
        okBtn.layer.borderWidth = 0.4
        //okBtn.layer.opacity = 0.6
        okBtn.layer.borderColor = AppColours.lineColor.cgColor
        txtView.textContainer.lineBreakMode = .byCharWrapping
        txtView.isScrollEnabled = false
        setUpMeatView()
         self.hideKeyboardWhenTappedAround()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 6, options: .curveEaseIn, animations: {
            self.bgView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
            self.txtView.becomeFirstResponder()
            self.txtView.text = self.workOutDesc
        }, completion: nil)
        
    }
    
    func setUpMeatView() {
        view.addSubview(bgView)
        bgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bgView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height).isActive = true
        bgView.widthAnchor.constraint(equalToConstant: view.bounds.width*0.8).isActive = true
    }
    
    @IBAction func okBtnTapped(_ sender: Any) {
        if self.txtView.text?.count != 0 {
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 4, options: .curveEaseIn, animations: {
            self.bgView.transform = CGAffineTransform.identity
            self.view.backgroundColor = UIColor(white: 0, alpha: 0.0)
        }) { (completed) in
            self.txtView.resignFirstResponder()
            self.workOutDelegate?.workoutHistroy(descr: self.txtView.text ?? "")
            self.dismiss(animated: false, completion: nil)
        }
    }
    }
    
}
extension WorkOutHistoryVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 300    // 10 Limit Value
    }
    func textViewDidBeginEditing(_ textView: UITextView) {

        if textView.textColor == UIColor.lightGray {
                txtView.text = ""
                txtView.textColor = UIColor.white
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text == "" {
            
            if textView.textColor == UIColor.white {
                txtView.text = "Describe your workout history"
                txtView.textColor = UIColor.lightGray
            }
        }
    }
}
