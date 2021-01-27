//
//  ScheduleCallView.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 26/08/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import FSCalendar
import Alamofire
protocol CallScheduleDelegate {
   
    func callBookSlot(slotId: String, schedulerId: String, date:Date)
     func cancelCallSchedule(slotId: String, schedulerId: String, date:Date)
    func  getRoomStatus(slotId: String, schedulerId: String)
    func dateChanged(date:Date)
    func setParentViewHeight(height: CGFloat)
}
class ScheduleCallView: UIView {

    @IBOutlet weak var nodataLblCallView: UILabel!
    @IBOutlet weak var tblTopConstraint: NSLayoutConstraint!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblTop2Constraint: NSLayoutConstraint!
    @IBOutlet weak var callTbleView: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var dateBtn: UIButton!
    var callScheduleDelegate:CallScheduleDelegate?
    var slectedDate: Date = Date()
       var schedulesArr : [SlotsData]?
    override init(frame: CGRect) {
              super.init(frame: frame)
              commonInit()
          }
          required init?(coder aDecoder: NSCoder) {
              super.init(coder: aDecoder)
               commonInit()
          }
          private func  commonInit()
          {
              Bundle.main.loadNibNamed("ScheduleCallView", owner: self, options: nil)
              addSubview(contentView)
              contentView.frame = self.bounds
              contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
              
              let nib = UINib(nibName: "CallScheduleTableViewCell", bundle: nil)
              self.callTbleView.register(nib, forCellReuseIdentifier: "callSchedulCell")
            
          self.dateBtn.layer.cornerRadius = 10
                 self.dateBtn.layer.borderColor = UIColor.lightGray.cgColor
                 self.dateBtn.layer.borderWidth = 0.5
                 let dateString = self.dateSelected(date: Date())
                        self.dateBtn.setTitle(dateString, for: .normal)
                        self.dateBtn.setTitleColor(AppColours.appGreen, for: .normal)
              self.calendar.isHidden = true
                     tblTopConstraint.priority = UILayoutPriority(rawValue: 999)
                     tblTop2Constraint.priority = UILayoutPriority(rawValue: 1000)
                     self.callTbleView.tableFooterView = UIView()
          }
    override func layoutSubviews() {
           self.updateConstraints()
        if self.schedulesArr?.count ?? 0 > 0 {
                   self.tblHeightConstraint.constant =  CGFloat((self.schedulesArr?.count ?? 0) * 120 + 40)
               }else {
                    self.tblHeightConstraint.constant =  120
               }
         //  self.tblHeightConstraint.constant =  CGFloat((self.schedulesArr?[0].slots?.count ?? 0) * 120 + 40)
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
            tblTopConstraint.isActive = false
//            tblTopConstraint.priority = UILayoutPriority(rawValue: 998)
//            tblTop2Constraint.priority = UILayoutPriority(rawValue: 999)
            tblTop2Constraint.isActive = true
        }else {
            calendar.isHidden = false
            dateBtn.isSelected = true
            tblTop2Constraint.isActive = false
           // tblTop2Constraint.priority = UILayoutPriority(rawValue: 998)
           // tblTopConstraint.priority = UILayoutPriority(rawValue: 999)
             tblTopConstraint.isActive = true
           
            
        }
    }
    func refreshCallView() {
        if self.schedulesArr?.count ?? 0 > 0{
            self.nodataLblCallView.isHidden = true
        }else {
            self.nodataLblCallView.isHidden = false
            self.nodataLblCallView.text = messageString
            if messageString.count == 0 {
                self.nodataLblCallView.text = "Trainer doesn't have any scheduled calls"
            }

        }
        if  self.schedulesArr?.count ?? 0 > 0 {
            if dateBtn.isSelected {
                self.tblHeightConstraint.constant =  CGFloat((self.schedulesArr?.count ?? 0) * 120 + 40)
                self.callScheduleDelegate?.setParentViewHeight(height: self.tblHeightConstraint.constant)
            }else {
                self.tblHeightConstraint.constant =  CGFloat((self.schedulesArr?.count ?? 0) * 120 + 250)
                self.callScheduleDelegate?.setParentViewHeight(height: self.tblHeightConstraint.constant)
            }
            
        }else {
             self.tblHeightConstraint.constant =  120
        }
        
        self.callTbleView.reloadData()
    }
    
}
extension ScheduleCallView: UITableViewDelegate,UITableViewDataSource {
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "callSchedulCell",
                                                 for: indexPath) as! CallScheduleTableViewCell
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
       
        cell.durationValLbl.text = schedule!.frequency?.name ?? ""
        let isToday = Calendar.current.isDateInToday(self.slectedDate)
     //   let ispreviousDay = Calendar.current.isDateInYesterday(self.slectedDate)
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
            if order == .orderedDescending {
                cell.bookNowBtn.isEnabled = false
            }else {
                cell.bookNowBtn.isEnabled = true
            }
        }else {
            if checkIfUserisParticipant(slots:schedule!) {
                cell.bookNowBtn.layer.borderColor = AppColours.textGreen.cgColor
                cell.bookNowBtn.layer.borderWidth = 0.5
                cell.bookNowBtn.layer.cornerRadius = 10
                cell.bookNowBtn.setTitle("Join", for: .normal)
                cell.bookNowBtn.accessibilityValue = "\(indexPath.section)"
                cell.bookNowBtn.tag = indexPath.row
                cell.bookNowBtn.addTarget(self, action: #selector(self.JoinNowTapped(_:)), for: .touchUpInside)
                cell.unavailableLbl.isHidden = true
                if isToday == true || order == .orderedDescending {
                    cell.deleteTapped.isHidden = true
                    if order == .orderedDescending {
                        cell.bookNowBtn.isEnabled = false
                    }else {
                        cell.bookNowBtn.isEnabled = true
                    }
                }else {
                    cell.bookNowBtn.isEnabled = true
                    cell.deleteTapped.isHidden = false
                     cell.deleteTapped.tag = indexPath.row
                    cell.deleteTapped.addTarget(self, action: #selector(self.deleteTappedSelection(_:)), for: .touchUpInside)
                }
                
            }else {
                cell.bookNowBtn.setTitle("Booked", for: .normal)
                cell.bookNowBtn.accessibilityValue = "\(indexPath.section)"
                cell.bookNowBtn.tag = indexPath.row
                cell.bookNowBtn.layer.borderColor = UIColor.red.cgColor
                cell.bookNowBtn.layer.borderWidth = 0.5
                cell.bookNowBtn.layer.cornerRadius = 10
                cell.unavailableLbl.isHidden = false
                 cell.deleteTapped.isHidden = true
                cell.bookNowBtn.isEnabled = false
                // cell.bookNowBtn.addTarget(self, action: #selector(self.JoinNowTapped(_:)), for: .touchUpInside)
            }
            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  self.selectedPrimaryGoal =  array1[indexPath.section]
    }
    @objc func bookNowBtnTapped(_ button: UIButton) {
      let index = button.tag
        if button.title(for: .normal) == "Join" {
            return
        }
        let schedules = self.schedulesArr![index]
        self.callScheduleDelegate?.callBookSlot(slotId: schedules.slotId ?? "", schedulerId:"", date:self.slectedDate)
     //   self.callBookSlot(slotId: slot.slotId!, schedulerId: schedules.schedulerId!)
        
    }
    @objc func deleteTappedSelection(_ button: UIButton) {
      let index = button.tag
        let schedules = self.schedulesArr![index]
        self.callScheduleDelegate?.cancelCallSchedule(slotId: schedules.slotId ?? "", schedulerId: "", date: self.slectedDate)
     //   self.cancelCallSchedule(slotId: slot.slotId!, schedulerId: schedules.schedulerId!)
        
    }
    @objc func JoinNowTapped(_ button: UIButton) {
         let index = button.tag
        if button.title(for: .normal) == "Book" {
                   return
               }
           let schedules = self.schedulesArr![index]
        self.callScheduleDelegate?.getRoomStatus(slotId: schedules.slotId ?? "", schedulerId:  "")
     //   self.getRoomStatus(slotId: slot.slotId ?? "", schedulerId: schedules.schedulerId ?? "")
           
       }
    func checkIfUserisParticipant(slots:SlotsData)->Bool {
        if slots != nil {
            let participants = slots.participants!
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
extension ScheduleCallView: FSCalendarDelegate, FSCalendarDataSource ,FSCalendarDelegateAppearance{
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        var dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter }()
//        if date .compare(Date()) == .orderedAscending {
//            // self.nodataLbl.text = "Previous dates schedules won't be available"
//          
//            let selectedDate   = dateFormatter.string(from: date)
//            let dateString = self.dateSelected(date: date)
//            self.slectedDate = dateFormatter.date(from: selectedDate) ?? Date()
//            self.dateBtn.setTitle(dateString, for: .normal)
//            return
//        }
        
        
        let selectedDate   = dateFormatter.string(from: date)
        let dateString = self.dateSelected(date: date)
        self.dateBtn.setTitle(dateString, for: .normal)
        let dateObj = dateFormatter.date(from: selectedDate)
        self.slectedDate = date
        self.callScheduleDelegate?.dateChanged(date: date)
      //  self.getAllCallsForTrainer(date: self.slectedDate)
        
    }
}
