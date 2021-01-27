//
//  CertificateViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 27/04/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import WebKit

class CertificateViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var filePath : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
              let xBarHeight = navigationController?.navigationBar.frame.maxY
              // Do any additional setup after loading the view.
              let navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight!))
               navigationView.backgroundColor = AppColours.topBarGreen
       navigationView.titleLbl.text = "Certificate"
       navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
       self.view.addSubview(navigationView)
        self.navigationController?.isNavigationBarHidden = true
        self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
        if filePath?.count ?? 0 > 0 {
            let fileURL = URL(string: filePath!)
            let urlRequest = URLRequest.init(url: fileURL!)
            self.webView.load(urlRequest)
        }
       
       // self.webView.load(URLRequest(url: URL(string: "https://myquest.questdiagnostics.com/web/home?openContactModal=true")!))

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func backBtnTapped(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
       }
    
}
extension CertificateViewController:UIDocumentInteractionControllerDelegate {
    //MARK: UIDocumentInteractionControllerDelegate
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController
    {


        UINavigationBar.appearance().tintColor = UIColor.white

        return self
    }
}
extension CertificateViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished navigating to url \(webView.url)")
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

extension CertificateViewController: WKUIDelegate {

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
