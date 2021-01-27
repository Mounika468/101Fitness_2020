//
//  OrdersViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 30/10/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class OrdersViewController: UIViewController {

    @IBOutlet weak var nodataLbl: UILabel!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var orderTblView: UITableView!
    var ordersArr : [MyOrders]?
    var navigationView = NavigationView()
    var xBarHeight :CGFloat  = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // self.orderTblView.register(OrderTableViewCell.self, forCellReuseIdentifier: "ordercell")
        
        orderTblView.tableFooterView = UIView()
        self.navigationController?.isNavigationBarHidden = false
                      xBarHeight = (navigationController?.navigationBar.frame.maxY)!
                       navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight))
                                    navigationView.titleLbl.text = "My Orders"
                             navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.addBtn.isHidden = true
                                    navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
                                    self.view.addSubview(navigationView)
                             self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func backBtnTapped(sender : UIButton){
     self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.getMyOrders()
    }
    func reloadPrograms() {
        self.orderTblView.reloadData()
        self.tblHeightConstraint.constant = CGFloat((self.ordersArr?.count ?? 0) * 185 + 40)
    }
    func getMyOrders() {
        LoadingOverlay.shared.showOverlay(view: self.view)
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
               var authenticatedHeaders: [String: String] {
                   [
                       HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                       HeadersKeys.contentType: HeaderValues.json
                   ]
               }
    
        ProgramAPI.getOrdersAPI(traineeId: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,  header: authenticatedHeaders) {[weak self] (programs) in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                if programs?.count ?? 0 > 0 {
                    self?.nodataLbl.isHidden = true
                    self?.ordersArr = programs
                    self?.reloadPrograms()
                }else {
                    self?.ordersArr = nil
                    self?.reloadPrograms()
                    self?.nodataLbl.isHidden = false
                }
            }
            
        } errorHandler: { (error) in
            DispatchQueue.main.async {
            LoadingOverlay.shared.hideOverlayView()
                self.presentAlertWithTitle(title: "Error", message:"\(error.errorDescription)", options: "OK") {[weak self] (_) in
                    self?.ordersArr = nil
                    self?.reloadPrograms()
                    self?.nodataLbl.isHidden = true
            }
            }
        }

    }
   

}
extension OrdersViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 185
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ordersArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ordercell")
            as? OrderTableViewCell
            else {
                return UITableViewCell()
        }
        let prName = self.ordersArr![indexPath.row]
        cell.progName.text = prName.programName
        
        let start = String(prName.program_start_date!.prefix(10)) as String
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: start)
        let date1 = Date.getDateInFormat(format: "MMM d, yyyy", date: date!)
        cell.prDetailValLbl.text = prName.description ?? ""
        cell.sdateValLbl.text = String(format: "%@", date1)
        cell.trainerNameValLbl.text = prName.trainerName ?? ""
        cell.piBtn.tag = indexPath.row
        cell.piBtn.addTarget(self, action: #selector(detailsTapped(sender:)), for: .touchUpInside)
        let curency = prName.currencyPaidIn ?? ""
        switch curency {
        case "Dollar":
          //  self?.priceValLbl.text = "$"  + String(describing: packageDetails[0].price!)
          // price = String(format: "$ %.2f", (packagesArr?.intermediate?[indexPath.row].priceInRupees)!)
            cell.priceValLbl.text =   String(format: "$ %.2f",prName.price ?? 0)
        case "INR":
           // self?.priceValLbl.text = "\u{20B9}" + String(describing: packageDetails[0].price!)
            cell.priceValLbl.text =   String(format: "\u{20B9} %.2f",prName.price ?? 0)
        default:
            cell.priceValLbl.text =   String(format: "%.2f",prName.price ?? 0)
        }
        
       // cell.prssView.progress = 0.15
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
    @objc func detailsTapped(sender : UIButton){
        let prName = self.ordersArr![sender.tag]
        self.getMyProgramDetails(orderId: prName.order_id!)
    }
    func getMyProgramDetails(orderId : Int) {
        LoadingOverlay.shared.showOverlay(view: self.view)
        
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
        
        ProgramAPI.getDetailsForProgram(header: authenticatedHeaders, traineeId: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, orderId: "\(orderId)")  { [weak self] (details) in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                if details != nil {
                    let storyboard = UIStoryboard(name: "ProgramDetailsViewController", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "ProgramDetailsViewController") as! ProgramDetailsViewController
                    controller.programsDetails = details
                    self?.navigationController?.pushViewController(controller, animated: true)

                }else {
                    self?.presentAlertWithTitle(title: "", message:"No data found", options: "OK") { (_) in
                }
                }
            }
            
        } errorHandler: {[weak self] (error) in
            DispatchQueue.main.async {
            LoadingOverlay.shared.hideOverlayView()
                self?.presentAlertWithTitle(title: "Error", message:"\(error.errorDescription)", options: "OK") { (_) in
                
            }
            }
        }

    }
}
