//
//  DatePickerViewController.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 10/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//

import UIKit


class DatePickerViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet  var secPriority: NSLayoutConstraint!
    @IBOutlet  var firstPriority: NSLayoutConstraint!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var bottomView: ProfileBottomView!
    @IBOutlet weak var headerView: ProfileHeaderView!
    var dateOfBirth = ""
  //  @IBOutlet weak var weekdayPicker: WeekdayPicker!
     private var weekdayPicker: WeekdayPicker?
    var dateFormatter = DateFormatter()
    var navigationType: NavigationType = .profileNormal
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
       // showDatePicker()
        headerView.countLbl.text = "3 / 11"
        bottomView.bottonDelegate = self
        self.ageField.layer.borderColor = UIColor(red: 8/255, green: 56/255, blue: 28/255, alpha: 1.0).cgColor
        self.ageField.textColor = AppColours.appGreen
//        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
//        datePicker.setValue(false, forKeyPath: "highlightsToday")
        
    }
    
//  func showDatePicker(){
//     //Formate Date
//    // datePicker.datePickerMode = .date
//    let calendar = Calendar(identifier: .gregorian)
//
//    let currentDate = Date()
//    var components = DateComponents()
//    components.calendar = calendar
//
//  //  components.year = -1
//    components.month = 12
//   // let maxDate = calendar.date(byAdding: components, to: currentDate)!
//
//    components.year = -80
//    let minDate = calendar.date(byAdding: components, to: currentDate)!
//
//    datePicker.minimumDate = minDate
//    datePicker.maximumDate = currentDate
//
//    //ToolBar
//    let toolbar = UIToolbar();
//    toolbar.sizeToFit()
//    let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
//    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//   let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
//
//  toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
//
////   txtDatePicker.inputAccessoryView = toolbar
////   txtDatePicker.inputView = datePicker
//
//  }

   @objc func donedatePicker(){

    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
   // txtDatePicker.text = formatter.string(from: datePicker.date)
    self.view.endEditing(true)
  }

  @objc func cancelDatePicker(){
     self.view.endEditing(true)
   }
    // MARK: - WeekdayPickerDelegate
 
     private func setupDatePicker() {
            
            // Create our object
            self.weekdayPicker = WeekdayPicker()
            self.weekdayPicker?.delegated = self
            
            if let customPicker = self.weekdayPicker {
                
                // Apply frame
                customPicker.frame = CGRect(origin: CGPoint(x: 20, y: self.headerLbl.frame.maxY + 20),
                                            size: CGSize(width: self.view.frame.size.width - 20,
                                                         height: 150))
                
                customPicker.setValue(UIColor.white, forKeyPath: "textColor")
               // customPicker.tintColor = UIColor.white
                let monthsToAdd = 0
                       let daysToAdd = 0
                       let yearsToAdd = -80
                       let currentDate = Date()
                
                       var dateComponent = DateComponents()
                       
                       dateComponent.month = monthsToAdd
                       dateComponent.day = daysToAdd
                       dateComponent.year = yearsToAdd
                       
                       let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
                       
                       print(currentDate)
                       print(futureDate!)
                
                customPicker.setToDate(futureDate!)
                
                // Add picker to current view
                self.view.addSubview(customPicker)
            }
        
        }
    @IBAction func backBtnTapped(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(true)
        switch self.navigationType {
        case .profileNormal:
            self.headerLbl.alpha = 1
            self.headerView.isHidden = false
            self.bottomView.isHidden = false
            self.backBtn.isHidden = true
            self.ageField.isHidden = false
            
//            secPriority.isActive = false
//            firstPriority.isActive = true
            
                           secPriority.priority = UILayoutPriority(rawValue: 999)
                            firstPriority.priority = UILayoutPriority(rawValue: 1000)
            self.weekdayPicker?.frame = CGRect(origin: CGPoint(x: 20, y: self.headerLbl.frame.maxY + 20),
                                               size: CGSize(width: self.view.frame.size.width - 20,
                                                            height: 150))
            
        case .profileMenu:
            self.headerLbl.alpha = 0
            self.headerView.isHidden = true
            self.bottomView.isHidden = true
            self.backBtn.isHidden = false
            
//            firstPriority.isActive = false
//            secPriority.isActive = true
            
                           firstPriority.priority = UILayoutPriority(rawValue: 999)
                           secPriority.priority = UILayoutPriority(rawValue: 1000)
            self.ageField.isHidden = true
            self.view.dropShadow(color: UIColor.white, opacity: 10, offSet: CGSize.init(width: 3, height: 3), radius: 3, scale: true)
            self.weekdayPicker?.frame = CGRect(origin: CGPoint(x: 20, y: 100),
                                               size: CGSize(width: self.view.frame.size.width - 20,
                                                            height: 200))
        default:
            print(")")
        }
       }

}
// MARK: - WeekdayPickerDelegate
extension DatePickerViewController: WeekdayPickerDelegate {
    
    func weekdayPickerDateChanged(_ date: Date?) {
        if let dateLabel = self.ageField, let date = date {
            self.ageField.text = "\(date)"
            let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
            let now = Date()
            let calcAge = calendar.components(.year, from: date, to: now, options: [])
            let age = calcAge.year
            print("Age is \(String(describing: age))")
            self.ageField.text = "\(age ?? 0)"
            let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat = "yyyy-MM-dd"
                   self.dateOfBirth = dateFormatter.string(from: date)
        }
    }
}
extension DatePickerViewController : BottomViewDelegate {
    func leftBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    func rightBtnTapped() {
        if self.ageField.text != "" &&  self.ageField.text != "0"{
            let age = self.ageField.text!
            TraineeInfo.details.age = Int(age) ?? 0
            TraineeInfo.details.date_of_birth = self.dateOfBirth
            let storyboard = UIStoryboard(name: "WeightVC", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "weightVC")
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else {
        presentAlertWithTitle(title: "", message: "Please select age", options: "OK") { (option) in

                  }
        }
        
    }
}
extension String {

    func removeCharsFromEnd(count:Int) -> String{
        let stringLength = self.count

        let substringIndex = (stringLength < count) ? 0 : stringLength - count

        let index: String.Index = self.index(self.startIndex, offsetBy: substringIndex)

        return String(self[..<index])
    }

    func length() -> Int {
        return self.count
    }
}
extension UIView {
func addshadow(top: Bool,
               left: Bool,
               bottom: Bool,
               right: Bool,
               shadowRadius: CGFloat = 2.0) {

    self.layer.masksToBounds = false
    self.layer.shadowOffset = CGSize(width: 0.0, height: -30.0)
    self.layer.shadowRadius = shadowRadius
    self.layer.shadowOpacity = 0.8
    self.layer.shadowColor = UIColor.white.cgColor
    let path = UIBezierPath()
    var x: CGFloat = 0
    var y: CGFloat = 0
    var viewWidth = self.frame.width
    var viewHeight = self.frame.height

    // here x, y, viewWidth, and viewHeight can be changed in
    // order to play around with the shadow paths.
    if (!top) {
        y+=(shadowRadius+1)
    }
    if (!bottom) {
        viewHeight-=(shadowRadius+1)
    }
    if (!left) {
        x+=(shadowRadius+1)
    }
    if (!right) {
        viewWidth-=(shadowRadius+1)
    }
    // selecting top most point
    path.move(to: CGPoint(x: x, y: y))
    // Move to the Bottom Left Corner, this will cover left edges
    /*
     |☐
     */
    path.addLine(to: CGPoint(x: x, y: viewHeight))
    // Move to the Bottom Right Corner, this will cover bottom edge
    /*
     ☐
     -
     */
    path.addLine(to: CGPoint(x: viewWidth, y: viewHeight))
    // Move to the Top Right Corner, this will cover right edge
    /*
     ☐|
     */
    path.addLine(to: CGPoint(x: viewWidth, y: y))
    // Move back to the initial point, this will cover the top edge
    /*
     _
     ☐
     */
    path.close()
    self.layer.shadowPath = path.cgPath
}
}
