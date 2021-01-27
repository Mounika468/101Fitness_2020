//
//  ContactUsViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 03/12/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {
    var navigationView = NavigationView()
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contactsTblView: UITableView!
    var sourceArr : [ContactUs]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        xBarHeight = 80
        navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight))
        navigationView.titleLbl.text = "Contact Us"
        navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.leftArrow.isHidden = true
        navigationView.rightArrow.isHidden = true
        navigationView.backBtn.isHidden = false
        navigationView.backBtn.addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(navigationView)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getContactUsInfo()
    }
    @objc func backBtnTapped(sender : UIButton){
     self.navigationController?.popViewController(animated: true)
    }
    func reloadContacts() {
        self.contactsTblView.reloadData()
        self.tblHeightConstraint.constant = CGFloat((self.sourceArr?.count ?? 0) * 70 + 10)
    }
    func getContactUsInfo() {
        LoadingOverlay.shared.showOverlay(view: UIApplication.shared.windows.first!)
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
               var authenticatedHeaders: [String: String] {
                   [
                       HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                       HeadersKeys.contentType: HeaderValues.json
                   ]
               }
               if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                            ProgramDetails.programDetails.subId = id
                                        }
        ContactsAPI.getContactUsSections(header: authenticatedHeaders) {[weak self] (contactus) in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                if contactus?.values?.count ?? 0 > 0 {
//                    self?.nodataLbl.isHidden = true
                    self?.sourceArr = contactus?.values?.filter{ $0.isShow == true}
                    self?.reloadContacts()
                }else {
                    self?.sourceArr = nil
                    self?.reloadContacts()
                  //  self?.nodataLbl.isHidden = false
                }
            }

        } errorHandler: { (error) in
            DispatchQueue.main.async {
            LoadingOverlay.shared.hideOverlayView()
                
                self.presentAlertWithTitle(title: "Error", message:"\(error.errorDescription)", options: "OK") {[weak self] (_) in
                    self?.sourceArr = nil
                    self?.reloadContacts()
                  //  self?.nodataLbl.isHidden = true
            }
            }
        }
    }

}
extension ContactUsViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 70
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"contactCell")
            as? ContactTableViewCell
            else {
                return UITableViewCell()
        }
        
        cell.headerLbl.text = self.sourceArr?[indexPath.row].name ?? ""
       // cell.detailLbl.text = self.sourceArr?[indexPath.row].message ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "SupportViewController", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ContactCommentsViewController") as! ContactCommentsViewController
        controller.category = self.sourceArr?[indexPath.row].name ?? ""
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
