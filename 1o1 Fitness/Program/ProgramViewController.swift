//
//  ProgramViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 29/10/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class ProgramViewController: UIViewController {

    @IBOutlet weak var headerLbl: UILabel! {
        didSet {
            headerLbl.textColor = AppColours.textGreen
        }
    }
    @IBOutlet weak var nodataLbl: UILabel!
    @IBOutlet weak var tblHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var prTblView: UITableView!
    var programsArr : [MyPrograms]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "ProgramTableViewCell", bundle: nil)
        self.prTblView.register(nib, forCellReuseIdentifier: "programsCell")
        prTblView.tableFooterView = UIView()
        self.nodataLbl.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        let userdefaults = UserDefaults.standard
        if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin) {
            if  savedValue == UserDefaultsKeys.guestLogin {
                self.nodataLbl.isHidden = false
                let storyboard = UIStoryboard(name: "CustomAlertVC", bundle: nil)
                let alertVC = storyboard.instantiateViewController(withIdentifier: "CAVC") as! CustomAlertViewController
                alertVC.customAlertDelegate = self
                alertVC.message = "Please Sign up to access the programs"
                alertVC.modalPresentationStyle = .custom
                present(alertVC, animated: false, completion: nil)
                self.prTblView.isHidden = true
            }else {
                self.prTblView.isHidden = false
                self.getMyPrograms()
            }
        }
        
        
    }
    func reloadPrograms() {
        self.prTblView.reloadData()
        self.tblHeightConstrain.constant = CGFloat((self.programsArr?.count ?? 0) * 125 + 40)
    }
    func getMyPrograms() {
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
    
        ProgramAPI.getProgramsAPI(traineeId: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,  header: authenticatedHeaders) {[weak self] (programs) in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                if programs?.count ?? 0 > 0 {
                    self?.nodataLbl.isHidden = true
                    self?.programsArr = programs
                    self?.reloadPrograms()
                }else {
                    self?.programsArr = nil
                    self?.reloadPrograms()
                    self?.nodataLbl.isHidden = false
                }
            }
            
        } errorHandler: { (error) in
            DispatchQueue.main.async {
            LoadingOverlay.shared.hideOverlayView()
                self.presentAlertWithTitle(title: "Error", message:"\(error.errorDescription)", options: "OK") {[weak self] (_) in
                    self?.programsArr = nil
                    self?.reloadPrograms()
                    self?.nodataLbl.isHidden = true
            }
            }
        }

    }
   

}
extension ProgramViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 150
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.programsArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "programsCell")
            as? ProgramTableViewCell
            else {
                return UITableViewCell()
        }
        let prName = self.programsArr![indexPath.row]
        cell.prNameLbl.text = prName.programName
        let imageURl = prName.programImg?.imgPath
        if imageURl != nil && imageURl?.count ?? 0 > 0 {
            cell.imgView.sd_setImage(with: URL(string:imageURl!)!, placeholderImage: UIImage(named: "chest"))
        }
        let start = String(prName.program_start_date!.prefix(10)) as String
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: start)
        let date1 = Date.getDateInFormat(format: "MMM d, yyyy", date: date!)
        
        let end = String(prName.program_end_date!.prefix(10)) as String
        let endDate = dateFormatter.date(from: end)
        let date2 = Date.getDateInFormat(format: "MMM d, yyyy", date: endDate!)
        cell.durationLbl.text = String(format: "Duration %@ to %@", date1,date2)
        cell.progressLbl.text = String(format: "%d days left", prName.daysLeft ?? 0)
        cell.detailsBtn.tag = indexPath.row
        cell.detailsBtn.addTarget(self, action: #selector(detailsTapped(sender:)), for: .touchUpInside)
        let progress =  Float(prName.daysLeft!) /  Float(prName.programDuration!)
        cell.prssView.progress = Float(1 - progress)
       // cell.prssView.progress = 0.15
        if self.programsArr![indexPath.row].isProgramActive == true {
            cell.prStatusLbl.text = "Active"
            cell.prStatusLbl.textColor = AppColours.textGreen
        }else {
            cell.prStatusLbl.text = "Inactive"
            cell.prStatusLbl.textColor = .red
        }
        
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
    @objc func detailsTapped(sender : UIButton){
        let prName = self.programsArr![sender.tag]
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
extension ProgramViewController: CustomAlertViewDelegate {
    func okBtnTapped() {
    
    }
    
    
    func singUpBtnTapped() {
        self.navigateToProfile()
    }
    func navigateToProfile() {
     
     self.tabBarController?.tabBar.isHidden = true
     let registration = SignUpViewController(nibName:"SignUpViewController", bundle:nil)
     self.navigationController?.pushViewController(registration, animated: true)
     
 //       let storyboard = UIStoryboard(name: "StartVC", bundle: nil)
 //       let controller = storyboard.instantiateViewController(withIdentifier: "startVC") as! StartViewController
 //       self.navigationController?.pushViewController(controller, animated: true)
    }
}
