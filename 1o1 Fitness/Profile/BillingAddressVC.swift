//
//  BillingAddressVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 01/07/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class BillingAddressVC: UIViewController {

    @IBOutlet weak var noMsgLbl: UILabel!
    @IBOutlet weak var addressTblView: UITableView!
    @IBOutlet weak var noAdressLbl: UILabel!
    var navigationView = NavigationView()
     var xBarHeight :CGFloat  = 0.0
    var addressArra: [Address]?
     var name = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
                      xBarHeight = (navigationController?.navigationBar.frame.maxY)!
                       navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight))
                                    navigationView.titleLbl.text = "Billing Address"
                             navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.addBtn.isHidden = false
                                    navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        navigationView.addBtn.addTarget(self, action: #selector(addBtnTapped(sender:)), for: .touchUpInside)
                                    self.view.addSubview(navigationView)
                             self.navigationController?.isNavigationBarHidden = true
        let nib = UINib(nibName: "AddressTableViewCell", bundle: nil)
               self.addressTblView.register(nib, forCellReuseIdentifier: "addressCell")
        addressTblView.tableFooterView = UIView()
        addressTblView.separatorColor = UIColor.lightGray.withAlphaComponent(0.5)
       
        if UserDefaults.standard.string(forKey: UserDefaultsKeys.name) != nil{
            name =  UserDefaults.standard.string(forKey: UserDefaultsKeys.name)!
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if self.addressArra != nil && self.addressArra?.count ?? 0 > 0 {
            self.noAdressLbl.isHidden = false
            self.noAdressLbl.text = "\(self.addressArra?.count ?? 0) saved Address"
            self.noMsgLbl.isHidden = true
        }else {
            self.noAdressLbl.isHidden = true
            self.noMsgLbl.isHidden = false
        }
        self.getAddressDetails()
    }
    @objc func backBtnTapped(sender : UIButton){
     self.navigationController?.popViewController(animated: true)
    }
    @objc func addBtnTapped(sender : UIButton){
      let storyboard = UIStoryboard(name: "AddressVC", bundle: nil)
      let controller = storyboard.instantiateViewController(withIdentifier: "addressVC") as! AddressVC
        controller.addressTypeScreen = .newAddressProfile
     controller.trainerId = ""
     self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func getAddressDetails() {
        
        if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
            ProgramDetails.programDetails.subId = id
        }
        let window = UIApplication.shared.windows.first!
        DispatchQueue.main.async {
            LoadingOverlay.shared.showOverlay(view: window)
        }
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        
        
        AddressAPI.getAddress(header: authenticatedHeaders,successHandler: { [weak self] address in
            if address != nil {
                DispatchQueue.main.async {
                    TraineeDetails.traineeDetails?.trainee_address = address
                    self?.addressArra = TraineeDetails.traineeDetails?.trainee_address
                    self?.addressTblView.reloadData()
                    let count = self?.addressArra!.count
                    self?.noAdressLbl.text = "\(String(describing:count )) saved Address"
                }
            }else {
                DispatchQueue.main.async {
//                    self?.presentAlertWithTitle(title: "Error", message: "No Addresses found", options: "OK") { (option) in
//                    }
                    self?.addressArra = nil
                    self?.addressTblView.reloadData()
                }
            }
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
        }) {[weak self] error in
            print(" error \(error)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                self?.presentAlertWithTitle(title: "Error", message: "Fetching Addresses failed", options: "OK") { (option) in
                }
            }
        }
    }

}
extension BillingAddressVC: UITableViewDelegate, UITableViewDataSource {

func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
   }
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   // return 2
    return self.addressArra?.count ?? 0
}
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell")
        as? AddressTableViewCell
        else {
            return UITableViewCell()
    }
    
    let address = self.addressArra![indexPath.row]
    cell.nameLbl.text = address.name ?? ""
    cell.addressTypeLbl.text = address.address_type
    cell.btnCheck.isHidden = true
    cell.editBtn.isHidden = false
    cell.editBtn.tag = indexPath.row
    cell.deleteBtn.tag = indexPath.row
    cell.deleteBtn.isHidden = false
    cell.editBtn.addTarget(self, action: #selector(self.editBtnTapped(_:)), for: .touchUpInside)
     cell.deleteBtn.addTarget(self, action: #selector(self.deleteBtnTapped(_:)), for: .touchUpInside)
    cell.cityLbl.text = address.city
    cell.phonrLbl.text = address.mobile_number
    cell.streetLbl.text = address.address
    //cell.addressTypeLbl.isHidden = true
    return cell
}

func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
    return 0;
}
    @objc func editBtnTapped(_ button: UIButton) {
        
        let index = button.tag
        let storyboard = UIStoryboard(name: "AddressVC", bundle: nil)
             let controller = storyboard.instantiateViewController(withIdentifier: "addressVC") as! AddressVC
               controller.addressTypeScreen = .editAddress
        controller.editAddress = self.addressArra![index]
            controller.trainerId = ""
            self.navigationController?.pushViewController(controller, animated: true)
       
    }
    @objc func deleteBtnTapped(_ button: UIButton) {
        
        let index = button.tag
       let address = self.addressArra![index]
       let window = UIApplication.shared.windows.first!
              DispatchQueue.main.async {
                  LoadingOverlay.shared.showOverlay(view: window)
              }
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
              
        AddressAPI.deleteAddress(addressId: address.id!, header: authenticatedHeaders,successHandler:{ [weak self] address in
            if address != nil {
                self?.addressArra = address
              
            }else {
            
            }
            DispatchQueue.main.async {
                 TraineeDetails.traineeDetails?.trainee_address = address
                LoadingOverlay.shared.hideOverlayView()
                self?.addressTblView.reloadData()
                if self?.addressArra?.count ?? 0 > 0 {
                    self?.noAdressLbl.isHidden = false
                    self?.noAdressLbl.text = "\(self?.addressArra!.count) saved Address"
                    self?.noMsgLbl.isHidden = true
                }else {
                    self?.noAdressLbl.isHidden = true
                    self?.noMsgLbl.isHidden = false
                }
            }
           // self?.subscribtionToProgram()
        }) { error in
            print(" error \(error)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
        }
    }
}
