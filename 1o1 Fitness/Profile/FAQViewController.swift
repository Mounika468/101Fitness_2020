//
//  FAQViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 01/12/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import WebKit

class FAQViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var navigationView = NavigationView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        xBarHeight = 88
        navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight))
        navigationView.titleLbl.text = "FAQs"
        navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.leftArrow.isHidden = false
        navigationView.rightArrow.isHidden = false
        navigationView.backBtn.isHidden = false
        navigationView.backBtn.addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        navigationView.leftArrow.addTarget(self, action: #selector(leftArrowTapped(sender:)), for: .touchUpInside)
        navigationView.rightArrow.addTarget(self, action: #selector(rightArrowTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(navigationView)
        self.navigationController?.isNavigationBarHidden = true
        self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
            let fileURL = URL(string: "https://d1ojbumdvbscm0.cloudfront.net/static-mobile/index.html")
            let urlRequest = URLRequest.init(url: fileURL!)
            self.webView.load(urlRequest)
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    @objc func backBtnTapped(sender : UIButton){
     self.navigationController?.popViewController(animated: true)
    }
    @objc func leftArrowTapped(sender : UIButton){
        self.webView.goBack()
    }
    @objc func rightArrowTapped(sender : UIButton){
        self.webView.goForward()
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
extension FAQViewController:UIDocumentInteractionControllerDelegate {
    //MARK: UIDocumentInteractionControllerDelegate
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController
    {


        UINavigationBar.appearance().tintColor = UIColor.white

        return self
    }
}
extension FAQViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished navigating to url \(webView.url)")
        if webView.canGoBack {
            self.navigationView.leftArrow.isEnabled = true
            self.navigationView.leftArrow.setImage(UIImage(named: "canBack"), for: .normal)
        }else {
            self.navigationView.leftArrow.isEnabled = false
            self.navigationView.leftArrow.setImage(UIImage(named: "gcanBack"), for: .normal)
        }
        
        if webView.canGoForward {
            self.navigationView.rightArrow.isEnabled = true
            self.navigationView.rightArrow.setImage(UIImage(named: "canGo"), for: .normal)
        }else {
            self.navigationView.rightArrow.isEnabled = false
            self.navigationView.rightArrow.setImage(UIImage(named: "gcanGo"), for: .normal)
        }
    }
    func  webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("error \(error.localizedDescription)")
    }
    func webView(_ webView: WKWebView,
             decidePolicyFor navigationResponse: WKNavigationResponse,
             decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
        
        
    }
    
}

// MARK: - WKUIDelegate Methods

extension FAQViewController: WKUIDelegate {

    func webView(_ webView: WKWebView,
                 createWebViewWith configuration: WKWebViewConfiguration,
                 for navigationAction: WKNavigationAction,
                 windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        // If the app is attempting to create a new WKWebView window then the link
        // was setup to open in a new browswer window. We need to load the request
        // in the same webview in this case.
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        
        return nil
    }
}
