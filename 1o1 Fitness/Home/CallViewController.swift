//
//  CallViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 11/08/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import FSCalendar
import Alamofire

class CallViewController: UIViewController {

    @IBOutlet weak var nodataLbl: UILabel!
    @IBOutlet  var tbleYConstrain: NSLayoutConstraint!
    @IBOutlet  var tbleSecYConstrain: NSLayoutConstraint!
    @IBOutlet  var tblHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var tbleView: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var dateBtn: UIButton!
     var slectedDate: Date = Date()
    var schedulesArr : [SlotsData]?
    var isJsonCode60 :Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        let xBarHeight = navigationController?.navigationBar.frame.maxY
        let navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight!))
               navigationView.titleLbl.text = "Call Schedule"
        navigationView.backgroundColor = AppColours.topBarGreen
               navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
               self.view.addSubview(navigationView)
        self.navigationController?.isNavigationBarHidden = true
        self.dateBtn.layer.cornerRadius = 10
        self.dateBtn.layer.borderColor = UIColor.lightGray.cgColor
        self.dateBtn.layer.borderWidth = 0.5
        let dateString = self.dateSelected(date: Date())
               self.dateBtn.setTitle(dateString, for: .normal)
               self.dateBtn.setTitleColor(AppColours.appGreen, for: .normal)
        self.getAllCallsForTrainer(date: self.slectedDate)
        self.calendar.isHidden = true
        tbleYConstrain.priority = UILayoutPriority(rawValue: 999)
        tbleSecYConstrain.priority = UILayoutPriority(rawValue: 1000)
        self.tbleView.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        if self.tabBarController?.tabBar.isHidden == true {
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    @objc func backBtnTapped(sender : UIButton){
              self.navigationController?.popViewController(animated: true)
             }
    func dateSelected(date: Date)->String {
        
        let gregorian: Calendar = Calendar(identifier: .gregorian)
          var dateFormatter1: DateFormatter = {
            let formatter = DateFormatter()
            //formatter.dateFormat = "yyyy-MM-dd"  E, d MMM
             formatter.dateFormat = "E, d MMM"
            return formatter
        }()
         let dateString : String = dateFormatter1.string(from:date)
        return dateString
    }

    @IBAction func dateBtnTapped(_ sender: Any) {
        if dateBtn.isSelected {
            calendar.isHidden = true
            dateBtn.isSelected = false
            tbleYConstrain.isActive = false
            tbleSecYConstrain.isActive = true
//            tbleYConstrain.priority = UILayoutPriority(rawValue: 999)
//            tbleSecYConstrain.priority = UILayoutPriority(rawValue: 1000)
        }else {
            calendar.isHidden = false
            dateBtn.isSelected = true
//            tbleYConstrain.priority = UILayoutPriority(rawValue: 1000)
//            tbleSecYConstrain.priority = UILayoutPriority(rawValue: 999)
            tbleSecYConstrain.isActive = false
            tbleYConstrain.isActive = true

            
        }
    }
    func callBookSlot(slotId:String,schedulerId:String) {
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
        if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
            ProgramDetails.programDetails.programId = id
        }
        
        let timeZone = TimeZone.current.identifier
        let postBody : [String: Any] = ["slotId": slotId,"trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"date": Date.getDateInFormat(format: "yyyy-MM-dd", date: self.slectedDate),"timezone":timeZone]
        let urlString = bookSlotForCall
        guard let url = URL(string: urlString) else {return}
        var request        = URLRequest(url: url)
        request.httpMethod = "Post"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(HeaderValues.token) \(token!) ", forHTTPHeaderField: "Authorization")
        do {
            request.httpBody   = try JSONSerialization.data(withJSONObject: postBody)
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        Alamofire.request(request).responseJSON{ (response) in
            print("response is \(response)")
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    if let json = response.result.value as? [String: Any] {
                        print("JSON: \(json)") // serialized json response
                        do {
                            if json["code"] as? Int != 40 && json["code"] as? Int != 64
                            {
                                if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                    if jsonDict is NSNull {
                                        
                                        if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                            messageString = (jsonMessage as? String)!
                                            self.nodataLbl.text = messageString
                                        }
                                        self.schedulesArr = nil
                                        
                                    }else {
                                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                  options: .prettyPrinted)
                                        self.schedulesArr = try JSONDecoder().decode([SlotsData]?.self, from: jsonData)
                                    }
                                    DispatchQueue.main.async {
                                        LoadingOverlay.shared.hideOverlayView()
                                        self.refreshView()
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                        LoadingOverlay.shared.hideOverlayView()
                                        self.presentAlertWithTitle(title: "", message: "Booking the slot is failed", options: "OK") {_ in
                                        }
                                    }
                                }
                            }else {
                                
                                if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                    messageString = (jsonMessage as? String)!
                                     DispatchQueue.main.async {
                                        LoadingOverlay.shared.hideOverlayView()
                                    self.nodataLbl.text = messageString
                                        if json["code"] as? Int != 64 {
                                            self.schedulesArr = nil
                                            self.refreshView()
                                        }else {
                                            self.presentAlertWithTitle(title: "", message: messageString, options: "OK") {_ in
                                            }
                                        }
                                         
                                    }
                                }
                               // self.schedulesArr = nil
                            }
                            
                        }catch let error {
                                DispatchQueue.main.async {
                                    LoadingOverlay.shared.hideOverlayView()
                                    self.presentAlertWithTitle(title: "", message: "Booking the slot is failed", options: "OK") {_ in
                                    }
                                }
                        }
                    }
                    
                default:
                    DispatchQueue.main.async {
                        
                    }
                }
            }
        }
        
        
        
    }
    func cancelCallSchedule(slotId:String,schedulerId:String) {
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
              if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
                  ProgramDetails.programDetails.programId = id
              }
        let timeZone = TimeZone.current.identifier
        let postBody : [String: Any] = ["slotId": slotId,"trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"date": Date.getDateInFormat(format: "yyyy-MM-dd", date: self.slectedDate),"timezone":timeZone]
                let urlString = cancelCall
                guard let url = URL(string: urlString) else {return}
                var request        = URLRequest(url: url)
                request.httpMethod = "Post"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("\(HeaderValues.token) \(token!) ", forHTTPHeaderField: "Authorization")
                do {
                    request.httpBody   = try JSONSerialization.data(withJSONObject: postBody)
                } catch let error {
                    print("Error : \(error.localizedDescription)")
                }
        Alamofire.request(request).responseJSON{ (response) in
            print("response is \(response)")
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    if let json = response.result.value as? [String: Any] {
                        print("JSON: \(json)") // serialized json response
                        do {
                            if json["code"] as? Int != 40
                            {
                                if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                    if jsonDict is NSNull {
                                        
                                        if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                            messageString = (jsonMessage as? String)!
                                            self.nodataLbl.text = messageString
                                        }
                                        self.schedulesArr = nil
                                        
                                    }else {
                                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                  options: .prettyPrinted)
                                        self.schedulesArr = try JSONDecoder().decode([SlotsData]?.self, from: jsonData)
                                    }
                                    DispatchQueue.main.async {
                                        LoadingOverlay.shared.hideOverlayView()
                                        self.refreshView()
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                         LoadingOverlay.shared.hideOverlayView()
                                        self.presentAlertWithTitle(title: "", message: "Fetching the Schedules failed", options: "OK") {_ in
                                        }
                                    }
                                }
                            }else {
                                if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                    messageString = (jsonMessage as? String)!
                                     DispatchQueue.main.async {
                                        LoadingOverlay.shared.hideOverlayView()
                                    self.nodataLbl.text = messageString
                                         self.schedulesArr = nil
                                         self.refreshView()
                                    }
                                }
                                self.schedulesArr = nil
                            } }catch let error {
                                DispatchQueue.main.async {
                                    LoadingOverlay.shared.hideOverlayView()
                                    self.presentAlertWithTitle(title: "", message: "Fetching the Schedules failed", options: "OK") {_ in
                                    }
                                }
                        }
                    }
                    
                default:
                    DispatchQueue.main.async {
                  
                    }
                }
            }
        }
      
    }
    func getAllCallsForTrainer(date:Date) {
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
              if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
                  ProgramDetails.programDetails.programId = id
              }
        let timeZone = TimeZone.current.identifier
        let postBody : [String: Any] = ["date": Date.getDateInFormat(format: "yyyy-MM-dd", date: date),"trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"timezone":timeZone]
                let urlString = getAllCallForTrainee
                guard let url = URL(string: urlString) else {return}
                var request        = URLRequest(url: url)
                request.httpMethod = "Post"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("\(HeaderValues.token) \(token!) ", forHTTPHeaderField: "Authorization")
                do {
                    request.httpBody   = try JSONSerialization.data(withJSONObject: postBody)
                } catch let error {
                    print("Error : \(error.localizedDescription)")
                }
        Alamofire.request(request).responseJSON{ (response) in
            print("response is \(response)")
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    if let json = response.result.value as? [String: Any] {
                        print("JSON: \(json)") // serialized json response
                        do {
                            if json["code"] as? Int != 40
                            {
                                if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                    if jsonDict is NSNull {
                                        
                                        if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                            messageString = (jsonMessage as? String)!
                                            self.nodataLbl.text = messageString
                                        }
                                        self.schedulesArr = nil
                                        
                                    }else {
                                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                  options: .prettyPrinted)
                                        self.schedulesArr = try JSONDecoder().decode([SlotsData]?.self, from: jsonData)
                                    }
                                    DispatchQueue.main.async {
                                        LoadingOverlay.shared.hideOverlayView()
                                        self.refreshView()
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                         LoadingOverlay.shared.hideOverlayView()
                                        self.presentAlertWithTitle(title: "", message: "Fetching the Schedules failed", options: "OK") {_ in
                                        }
                                    }
                                }
                            }else {
                                if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                    messageString = (jsonMessage as? String)!
                                     DispatchQueue.main.async {
                                        LoadingOverlay.shared.hideOverlayView()
                                    self.nodataLbl.text = messageString
                                         self.schedulesArr = nil
                                         self.refreshView()
                                    }
                                }
                                self.schedulesArr = nil
                            } }catch let error {
                                DispatchQueue.main.async {
                                    LoadingOverlay.shared.hideOverlayView()
                                    self.presentAlertWithTitle(title: "", message: "Fetching the Schedules failed", options: "OK") {_ in
                                    }
                                }
                        }
                    }
                    
                default:
                    DispatchQueue.main.async {
                  
                    }
                }
            }
        }
      
    }
    func getRoomStatus(slotId:String,schedulerId:String) {
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
              if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
                  ProgramDetails.programDetails.programId = id
              }
       
        GetCallInfoByDateAPI.checkRoomStatus(header: authenticatedHeaders, slotId: slotId, schedulerId: schedulerId, traineeid: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, successHandler:{ [weak self] token in
            
            if (token != nil) {
                 DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                    self?.tabBarController?.tabBar.isHidden = true
                let storyboard = UIStoryboard(name: "TwilioCallViewController", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "TwilioCallViewController") as! TwilioCallViewController
                    vc.accessToken = (token?.token!)!
                    vc.roomName = token?.roomName ?? ""
                      // let nav = UINavigationController.init(rootViewController: vc)
                      // self?.present(nav, animated: true, completion: nil)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }else {
                  DispatchQueue.main.async {
                      LoadingOverlay.shared.hideOverlayView()
                      self?.presentAlertWithTitle(title: "", message: messageString, options: "OK") {_ in
                      }
                  }
              }
              
          }) { [weak self] error in
            print(" error \(error)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                self?.presentAlertWithTitle(title: "", message: error.localizedDescription, options: "OK") {_ in
                }
            }
        }
  
    }
    func fetchTokenForTwilio(roomName:String) {
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
                     if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
                         ProgramDetails.programDetails.programId = id
                     }
        GetCallInfoByDateAPI.getTokenForCall(header: authenticatedHeaders, roomName: roomName, traineeid: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, successHandler: { [weak self] token in
            if (token != nil) {
                 DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                let storyboard = UIStoryboard(name: "TwilioCallViewController", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "TwilioCallViewController") as! TwilioCallViewController
                    vc.accessToken = (token?.token!)!
                    vc.roomName = token?.roomName ?? ""
                       //let nav = UINavigationController.init(rootViewController: vc)
                      // self?.present(nav, animated: true, completion: nil)
                   // self?.navigationController?.pushViewController(vc, animated: true)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
            DispatchQueue.main.async {
               // self?.dietView.reloadDietView()
                LoadingOverlay.shared.hideOverlayView()
            }
        }) { [weak self] error in
            print(" error \(error)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()

            }
        }
    }
    func refreshView() {
              if self.schedulesArr != nil && self.schedulesArr?.count ?? 0 > 0 {
                  self.tbleView.isHidden = false
                  self.nodataLbl.isHidden = true
                  self.tbleView.reloadData()

              }else {
                  self.tbleView.isHidden = true
                  self.nodataLbl.isHidden = false
                if messageString.count == 0 {
                    self.nodataLbl.text = "Trainer doesn't have any scheduled calls"
                }
                //self.nodataLbl.text = messageString
              }
          }
    func navigateToTwilioCall() {
        
    }
}
extension CallViewController: UITableViewDelegate,UITableViewDataSource {
    
//   func numberOfSections(in tableView: UITableView) -> Int {
//    return self.schedulesArr?.count ?? 0
//    }
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 0
   }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.schedulesArr?.count ?? 0
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell",
                                                 for: indexPath) as! ScheduleTableViewCell
        let schedule = self.schedulesArr?[indexPath.row]
        let imageURl = schedule?.profileImage?.profileImagePath
        if imageURl != nil && imageURl?.count ?? 0 > 0 {
            cell.imgView.sd_setImage(with: URL(string:imageURl!)!, placeholderImage: UIImage(named: "chest"))
            //  cell.imageView?.loadImage(url: URL(string: imageURl!)!)
            //   cell.imageView.sd_setImage(with: URL(string:imageURl!)!, placeholderImage: UIImage(named: "chest"))
            // cell.imageView?.sd_setImage(with: URL(string: imageURl!)!), completed: ni)
        }
        cell.nameLbl.text = (schedule?.firstName ?? "") + " " + (schedule?.lastName ?? "")
        let time = (schedule?.startTime ?? "") + "-" + (schedule?.endTime ?? "")
        cell.timeLbl.text = time
        cell.durationValLbl.text = schedule?.frequency?.name ?? ""
        let isToday = Calendar.current.isDateInToday(self.slectedDate)
      //  let ispreviousDay = Calendar.current.isDateInYesterday(self.slectedDate)
        var order = Calendar.current.compare(Date(), to: self.slectedDate, toGranularity: .day)
        if schedule?.status == "open" {
             cell.bookNowBtn.setTitle("Book", for: .normal)
             cell.deleteTapped.isHidden = true
            cell.bookNowBtn.accessibilityValue = "\(indexPath.section)"
            cell.bookNowBtn.tag = indexPath.row
            cell.bookNowBtn.addTarget(self, action: #selector(self.bookNowBtnTapped(_:)), for: .touchUpInside)
            cell.bookNowBtn.layer.borderColor = AppColours.textGreen.cgColor
            cell.bookNowBtn.layer.borderWidth = 0.5
            cell.bookNowBtn.layer.cornerRadius = 10
            cell.unavailableLbl.isHidden = true
            if order == .orderedDescending  {
                cell.bookNowBtn.isEnabled = false
            }else {
                cell.bookNowBtn.isEnabled = true
            }
            
        }else {
            if checkIfUserisParticipant(slots:schedule) {
                cell.bookNowBtn.layer.borderColor = AppColours.textGreen.cgColor
                cell.bookNowBtn.layer.borderWidth = 0.5
                cell.bookNowBtn.layer.cornerRadius = 10
                cell.bookNowBtn.setTitle("Join", for: .normal)
                cell.bookNowBtn.accessibilityValue = "\(indexPath.section)"
                cell.bookNowBtn.tag = indexPath.row
                cell.bookNowBtn.addTarget(self, action: #selector(self.JoinNowTapped(_:)), for: .touchUpInside)
                cell.unavailableLbl.isHidden = true
                if isToday == true || (order == .orderedDescending) {
                    cell.deleteTapped.isHidden = true
                    if order == .orderedDescending  {
                        cell.bookNowBtn.isEnabled = false
                    }else {
                        cell.bookNowBtn.isEnabled = true
                    }
                    if schedule?.status == "completed" {
                        cell.bookNowBtn.setTitle("Completed", for: .normal)
                        cell.bookNowBtn.isEnabled = false
                    }
                }else {
                    if schedule?.status == "completed" {
                        cell.bookNowBtn.setTitle("Completed", for: .normal)
                        cell.bookNowBtn.isEnabled = false
                    }else {
                        cell.bookNowBtn.isEnabled = true
                        cell.deleteTapped.isHidden = false
                         cell.deleteTapped.tag = indexPath.row
                        cell.deleteTapped.addTarget(self, action: #selector(self.deleteTappedSelection(_:)), for: .touchUpInside)
                    }
                }
                
            }else {
                cell.bookNowBtn.setTitle("Booked", for: .normal)
                cell.bookNowBtn.isEnabled = false
                cell.bookNowBtn.accessibilityValue = "\(indexPath.section)"
                cell.bookNowBtn.tag = indexPath.row
                cell.bookNowBtn.layer.borderColor = UIColor.red.cgColor
                cell.bookNowBtn.layer.borderWidth = 0.5
                cell.bookNowBtn.layer.cornerRadius = 10
                cell.unavailableLbl.isHidden = false
                 cell.deleteTapped.isHidden = true
                // cell.bookNowBtn.addTarget(self, action: #selector(self.JoinNowTapped(_:)), for: .touchUpInside)
            }
            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  self.selectedPrimaryGoal =  array1[indexPath.section]
    }
    func convertDateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = .current
        let convertedDate = dateFormatter.date(from: date)

        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "yyyy MMM HH:mm EEEE"///this is what you want to convert format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)

        return timeStamp
    }
    @objc func bookNowBtnTapped(_ button: UIButton) {
      let index = button.tag
        if button.title(for: .normal) == "Join" {
            return
        }
        let schedules = self.schedulesArr![index]
        self.callBookSlot(slotId: schedules.slotId ?? "", schedulerId: "")
        
    }
    @objc func deleteTappedSelection(_ button: UIButton) {
      let index = button.tag
        let schedules = self.schedulesArr![index]
        self.cancelCallSchedule(slotId: schedules.slotId ?? "", schedulerId:  "")
        
    }
    @objc func JoinNowTapped(_ button: UIButton) {
        if button.title(for: .normal) == "Book" {
            return
        }
         let index = button.tag
        let schedules = self.schedulesArr![index]
        self.getRoomStatus(slotId: schedules.slotId ?? "", schedulerId: "")
           
       }
    func checkIfUserisParticipant(slots:SlotsData?)->Bool {
        if slots != nil {
            let participants = slots!.participants!
            let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!
            let filteredArray = participants.filter { $0.trainee_id == id }
            if filteredArray.count > 0 {
                return true
            }
            return false
        }
        
        return false
    }
}
extension CallViewController: FSCalendarDelegate, FSCalendarDataSource ,FSCalendarDelegateAppearance{

   func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//    if date.compare(Date()) == .orderedAscending {
//        self.nodataLbl.text = "Previous dates schedules won't be available"
//        var dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        return formatter }()
//
//        let selectedDate   = dateFormatter.string(from: date)
//         let dateString = self.dateSelected(date: date)
//        self.dateBtn.setTitle(dateString, for: .normal)
//        let dateObj = dateFormatter.date(from: selectedDate)
//        self.schedulesArr = nil
//        self.tbleView.isHidden = true
//        self.nodataLbl.isHidden = false
//        return
//    }
    
    var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter }()

    let selectedDate   = dateFormatter.string(from: date)
     let dateString = self.dateSelected(date: date)
    self.dateBtn.setTitle(dateString, for: .normal)
    let dateObj = dateFormatter.date(from: selectedDate)
    self.slectedDate = date
   self.getAllCallsForTrainer(date: self.slectedDate)
   
   }
func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
    let gregorian: Calendar = Calendar(identifier: .gregorian)
     var dateFormatter1: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateFormat = "yyyy-MM-dd"
       return formatter
   }()
      let somedays = ["2020-05-15",
                   "2020-05-20",
                   "2020-05-22",
                   "2020-05-25"]
       let dateString : String = dateFormatter1.string(from:date)

       if somedays.contains(dateString) {
           return .green
       } else {
           return nil
       }
   }
}
