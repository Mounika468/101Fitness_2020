//
//  CustomAlert.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 27/04/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

//import Foundation
//import UIKit
//class InsetLabel: UILabel {
//    let topInset = CGFloat(0)
//    let bottomInset = CGFloat(0)
//    let leftInset = CGFloat(10)
//    let rightInset = CGFloat(10)
//
//    override func drawText(in rect: CGRect) {
//        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
//        super.drawText(in: rect.inset(by: insets))
//    }
//
//    override public var intrinsicContentSize: CGSize {
//        var intrinsicSuperViewContentSize = super.intrinsicContentSize
//        intrinsicSuperViewContentSize.height += topInset + bottomInset
//        intrinsicSuperViewContentSize.width += leftInset + rightInset
//        return intrinsicSuperViewContentSize
//    }
//}
//
//class CustomAlertView1: UIView {
//
//    let titleHeader: UILabel = {
//        let th = UILabel()
//        th.textAlignment = .center
//        th.backgroundColor = .black
//        th.font = UIFont.boldSystemFont(ofSize: 17)
//        th.textColor = .white
//        th.text = "Alert"
//        th.translatesAutoresizingMaskIntoConstraints = false
//        return th
//    }()
//
//    let logoImageView: UIImageView = {
//        let imv = UIImageView()
//        imv.translatesAutoresizingMaskIntoConstraints = false
//        imv.layer.cornerRadius = 15
//        imv.clipsToBounds = true
//        imv.backgroundColor = .white
//        imv.image = #imageLiteral(resourceName: "logoImage")
//        return imv
//
//    }()
//
//    let messageLabel: InsetLabel = {
//        let ml = InsetLabel()
//        ml.translatesAutoresizingMaskIntoConstraints = false
//        ml.textAlignment = .center
//        ml.numberOfLines = 0
//        ml.backgroundColor = .white
//
//        return ml
//    }()
//    let backgroundView: UIView = {
//        let bv = UIView()
//        bv.backgroundColor = .white
//        bv.translatesAutoresizingMaskIntoConstraints = false
//        return bv
//    }()
//
//    let topBackgroundView: UIView = {
//        let bv = UIView()
//        bv.backgroundColor = .white
//        bv.translatesAutoresizingMaskIntoConstraints = false
//        return bv
//    }()
//
//
//    let leftActionButton: UIButton = {
//        let btn = UIButton(type: UIButton.ButtonType.system)
//        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
//        btn.setTitleColor(UIColor.buttonTextColor(), for: .normal)
//        btn.backgroundColor = UIColor.buttonBackgroundColor()
//        btn.titleLabel?.textColor = .black
//        btn.setTitle("Left", for: .normal)
//        btn.layer.cornerRadius = CGFloat.buttonCornerRadius()
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        return btn
//    }()
//
//    let rightActionButton: UIButton = {
//        let btn = UIButton(type: UIButton.ButtonType.system)
//        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
//        btn.setTitleColor(UIColor.buttonTextColor(), for: .normal)
//        btn.backgroundColor = UIColor.buttonBackgroundColor()
//        btn.titleLabel?.textColor = .black
//        btn.setTitle("Right", for: .normal)
//        btn.layer.cornerRadius = CGFloat.buttonCornerRadius()
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        return btn
//    }()
//
//    let cancelActionButton: UIButton = {
//        let btn = UIButton(type: UIButton.ButtonType.system)
//        btn.setImage(#imageLiteral(resourceName: "cancelImage").withRenderingMode(.alwaysTemplate), for: .normal)
//        btn.tintColor = .white
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        return btn
//    }()
//
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//    }
//
//    func setButtons(amount: Int, alertTitle: String, firstBtnTitle: String?, secondBtnTitle: String?, message: String) {
//
//        switch amount {
//        case 0:
//            addSubview(messageLabel)
//            messageLabel.topAnchor.constraint(equalTo: topBackgroundView.bottomAnchor).isActive = true
//            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        case 1:
//            addSubview(messageLabel)
//            messageLabel.topAnchor.constraint(equalTo: topBackgroundView.bottomAnchor).isActive = true
//            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//
//            addSubview(backgroundView)
//            backgroundView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor).isActive = true
//            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//            backgroundView.heightAnchor.constraint(equalToConstant: CGFloat.buttonHeight() + 50).isActive = true
//            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//
//
//            addSubview(leftActionButton)
//            leftActionButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//            leftActionButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//            leftActionButton.widthAnchor.constraint(equalToConstant: CGFloat.buttonWidth()).isActive = true
//            leftActionButton.heightAnchor.constraint(equalToConstant: CGFloat.buttonHeight()).isActive = true
//
//            leftActionButton.setTitle(firstBtnTitle, for: .normal)
//
//        case 2:
//            addSubview(messageLabel)
//            messageLabel.topAnchor.constraint(equalTo: topBackgroundView.bottomAnchor).isActive = true
//            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//
//            addSubview(backgroundView)
//            backgroundView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor).isActive = true
//            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//            backgroundView.heightAnchor.constraint(equalToConstant: CGFloat.buttonHeight() + 50).isActive = true
//            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//
//            addSubview(leftActionButton)
//            leftActionButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -70).isActive = true
//            leftActionButton.widthAnchor.constraint(equalToConstant: CGFloat.buttonWidth()).isActive = true
//            leftActionButton.heightAnchor.constraint(equalToConstant: CGFloat.buttonHeight()).isActive = true
//            leftActionButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 25).isActive = true
//
//            addSubview(rightActionButton)
//            rightActionButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 70).isActive = true
//            rightActionButton.widthAnchor.constraint(equalToConstant: CGFloat.buttonWidth()).isActive = true
//            rightActionButton.heightAnchor.constraint(equalToConstant: CGFloat.buttonHeight()).isActive = true
//            rightActionButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 25).isActive = true
//
//            leftActionButton.setTitle(firstBtnTitle, for: .normal)
//            rightActionButton.setTitle(secondBtnTitle, for: .normal)
//
//
//        default:
//            break
//        }
//    }
//
//    func presentCustomAlert(amountOfBtns: Int, alertTitle: String, firstBtnTitle: String?, secondBtnTitle: String?, message: String) {
//        self.backgroundColor = .white
//        addSubview(titleHeader)
//        titleHeader.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        titleHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        titleHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        titleHeader.heightAnchor.constraint(equalToConstant: 66).isActive = true
//
//        titleHeader.addSubview(logoImageView)
//        logoImageView.centerXAnchor.constraint(equalTo: titleHeader.centerXAnchor, constant: -100).isActive = true
//        logoImageView.centerYAnchor.constraint(equalTo: titleHeader.centerYAnchor).isActive = true
//        logoImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
//        logoImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
//
//        addSubview(cancelActionButton)
//        cancelActionButton.centerYAnchor.constraint(equalTo: titleHeader.centerYAnchor).isActive = true
//        cancelActionButton.trailingAnchor.constraint(equalTo: titleHeader.trailingAnchor, constant: -20).isActive = true
//        cancelActionButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
//        cancelActionButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
//
//        addSubview(topBackgroundView)
//        topBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        topBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        topBackgroundView.topAnchor.constraint(equalTo: titleHeader.bottomAnchor).isActive = true
//        topBackgroundView.heightAnchor.constraint(equalToConstant: 20).isActive = true
//
//        titleHeader.text = alertTitle
//        messageLabel.text = message
//
//        setButtons(amount: amountOfBtns, alertTitle: alertTitle, firstBtnTitle: firstBtnTitle, secondBtnTitle: secondBtnTitle, message: message)
//
//    }
//
//}
//class AlertViewController: UIViewController {
//
//    let alertView: CustomAlertView1 = {
//        let av = CustomAlertView1()
//        av.layer.cornerRadius = 12
//        av.layer.masksToBounds = true
//        av.translatesAutoresizingMaskIntoConstraints = false
//        return av
//    }()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setUpAlertView()
//
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 6, options: .curveEaseIn, animations: {
//            self.alertView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
//            self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
//
//        }, completion: nil)
//
//    }
//
//    func setUpAlertView() {
//        view.addSubview(alertView)
//        alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height).isActive = true
//        alertView.widthAnchor.constraint(equalToConstant: view.bounds.width*0.8).isActive = true
//        alertView.cancelActionButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
//
//    }
//
//    @objc func dismissAlert() {
//        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 4, options: .curveEaseIn, animations: {
//            self.alertView.transform = CGAffineTransform.identity
//            self.view.backgroundColor = UIColor(white: 0, alpha: 0.0)
//        }) { (completed) in
//            self.dismiss(animated: false, completion: nil)
//        }
//
//    }
//
//
//}
