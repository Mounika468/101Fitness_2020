//
//  ReportReviewVC.swift
//  1o1 Fitness
//
//  Created by Mounika Reddy on 03/03/21.
//  Copyright © 2021 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import WebKit

class ReportReviewVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var url : String = ""
    var navigationView = NavigationView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        xBarHeight = 88
        navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight))
        navigationView.titleLbl.text = "Report Preview"
        navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.shareBtn.isHidden = false
        navigationView.backBtn.isHidden = false
        navigationView.backBtn.addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        navigationView.shareBtn.addTarget(self, action: #selector(shareBtnTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(navigationView)
        self.navigationController?.isNavigationBarHidden = true
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        if self.url.count > 0 {
            let fileURL = URL(string: self.url)
            let urlRequest = URLRequest.init(url: fileURL!)
            self.webView.load(urlRequest)
        }
    }
    
    @objc func backBtnTapped(sender : UIButton){
     self.navigationController?.popViewController(animated: true)
    }
    @objc func shareBtnTapped(sender : UIButton){
        let activity = UIActivityViewController(
            activityItems: ["1o1 Fintness Reports", self.url],
            applicationActivities: nil
          )
         // activity.popoverPresentationController?.barButtonItem = sender

          // 3
          present(activity, animated: true, completion: nil)
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
extension ReportReviewVC: WKUIDelegate,UIDocumentInteractionControllerDelegate,WKNavigationDelegate {
    
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
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController
    {


        UINavigationBar.appearance().tintColor = UIColor.white

        return self
    }
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
