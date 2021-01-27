//
//  CheckOutViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 21/06/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import Stripe

/**
 * This example collects card payments, implementing the guide here: https://stripe.com/docs/payments/accept-a-payment#ios
 * To run this app, follow the steps here https://github.com/stripe-samples/accept-a-card-payment#how-to-run-locally
 */
let BackendUrl = "http://127.0.0.1:4242/"

class CheckoutViewController: UIViewController {
    var paymentIntentClientSecret: String?
    var programDuration: Int = 0
    var orderId : Int = 0
 var navigationView : NavigationView?
    lazy var cardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
        cardTextField.textColor = UIColor.white
        return cardTextField
    }()
    lazy var payButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 5
        button.backgroundColor = AppColours.textGreen
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.setTitle("Pay", for: .normal)
        button.addTarget(self, action: #selector(pay), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.navigationController?.isNavigationBarHidden = false
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
        let stackView = UIStackView(arrangedSubviews: [cardTextField, payButton])
        stackView.backgroundColor = UIColor.black
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 2),
            view.rightAnchor.constraint(equalToSystemSpacingAfter: stackView.rightAnchor, multiplier: 2),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 20),
        ])
    }
    @objc func backBtnTapped(sender : UIButton){
           self.navigationController?.popViewController(animated: true)
       }
    func displayAlert(title: String, message: String, restartDemo: Bool = false) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            if restartDemo {
                alert.addAction(UIAlertAction(title: "Restart demo", style: .cancel) { _ in
                    self.cardTextField.clear()
                    //self.startCheckout()
                })
            }
            else {
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            }
            self.present(alert, animated: true, completion: nil)
        }
    }


    @objc
    func pay() {
        guard let paymentIntentClientSecret = paymentIntentClientSecret else {
            return;
        }
        // Collect card details
        let cardParams = cardTextField.cardParams
        let paymentMethodParams = STPPaymentMethodParams(card: cardParams, billingDetails: nil, metadata: nil)
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: paymentIntentClientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams

        // Submit the payment
        let window = UIApplication.shared.windows.first!
        DispatchQueue.main.async {
            LoadingOverlay.shared.showOverlay(view: window)
        }
        let paymentHandler = STPPaymentHandler.shared()
        paymentHandler.confirmPayment(withParams: paymentIntentParams, authenticationContext: self) { (status, paymentIntent, error) in
            switch (status) {
            case .failed:
                //self.displayAlert(title: "Payment failed", message: error?.localizedDescription ?? "")
                DispatchQueue.main.async {
                    //ProgramDetails.programDetails.programStartDate = Date.getCurrentDateInFormat(format: "dd/MM/yyyy")
                    LoadingOverlay.shared.hideOverlayView()
                    let storyboard = UIStoryboard(name: "SuccessVC", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "successVC") as! SuccessVC
                    //controller.programDuration = self.programDuration
                    controller.paymentStatus = .failure
                    self.navigationController?.pushViewController(controller, animated: true)
                }
                break
            case .canceled:
                self.displayAlert(title: "Payment canceled", message: error?.localizedDescription ?? "")
                break
            case .succeeded:
                DispatchQueue.main.async {
                    //ProgramDetails.programDetails.programStartDate = Date.getCurrentDateInFormat(format: "dd/MM/yyyy")
                    LoadingOverlay.shared.hideOverlayView()
                    let storyboard = UIStoryboard(name: "SuccessVC", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "successVC") as! SuccessVC
                    controller.programDuration = self.programDuration
                    controller.orderId = self.orderId
                    controller.paymentStatus = .success
                    self.navigationController?.pushViewController(controller, animated: true)
                }
                break
            @unknown default:
                fatalError()
                break
            }
           DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
        }
    }
}

extension CheckoutViewController: STPAuthenticationContext {
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
}
