//
//  WeightViewController.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 11/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//

import UIKit
protocol WeightBackButtonTapDelegate {
    func updateWeightForProfile()
}
class WeightViewController: UIViewController {

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet  var priHeightConstraint: NSLayoutConstraint!
    @IBOutlet  var secHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var lbBtn: UIButton!
    @IBOutlet weak var kgBtn: UIButton!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var bottomView: ProfileBottomView!
    @IBOutlet weak var headerView: ProfileHeaderView!
    var weightDelegate : WeightBackButtonTapDelegate?
  //  var weightLbl = UILabel()
     let scrollView = UIScrollView()
    var weightVal = 0.0
    var metric = ""
    var isOffsetSet : Bool = false
    var isTargetWeight : Bool = false
     var navigationType: NavigationType = .profileNormal
    override func viewDidLoad() {
        super.viewDidLoad()
         headerView.countLbl.text = "4 / 11"
        bottomView.bottonDelegate = self
        weightLbl.textColor = AppColours.appGreen
        // Do any additional setup after loading the view.
        setScrollView()
        self.lbBtn.layer.cornerRadius = 10
        self.lbBtn.layer.borderWidth = 1
        self.lbBtn.layer.borderColor = AppColours.appGreen.cgColor
        
        
        self.kgBtn.layer.cornerRadius = 10
        self.kgBtn.layer.borderWidth = 1
        self.kgBtn.layer.borderColor = AppColours.appGreen.cgColor
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
         self.kgBtn.isSelected = true
          self.kgBtn.setTitleColor(AppColours.appYellow, for: .normal)
         self.metric = "kg"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        switch self.navigationType {
        case .profileNormal:
            self.headerView.isHidden = false
            self.bottomView.isHidden = false
            self.backBtn.isHidden = true
            self.doneBtn.isHidden = true
            self.priHeightConstraint.priority = UILayoutPriority(rawValue: 999)
            self.secHeightConstraint.priority = UILayoutPriority(rawValue: 500)
//             if IOSVersion.SYSTEM_VERSION_LESS_THAN(version: "13.0") {
////                secHeightConstraint.isActive = false
////                           priHeightConstraint.isActive = true
//                self.priHeightConstraint.priority = UILayoutPriority(rawValue: 999)
//                self.secHeightConstraint.priority = UILayoutPriority(rawValue: 500)
//             }else {
//                secHeightConstraint.priority = UILayoutPriority(rawValue: 999)
//                priHeightConstraint.priority = UILayoutPriority(rawValue: 1000)
//            }
          
        case .profileMenu:
            self.headerView.isHidden = true
            self.bottomView.isHidden = true
            self.backBtn.isHidden = false
            self.doneBtn.isHidden = false
//            if IOSVersion.SYSTEM_VERSION_LESS_THAN(version: "13.0") {
//                priHeightConstraint.isActive = false
//                secHeightConstraint.isActive = true
//                secHeightConstraint.constant = 30.0
                self.priHeightConstraint.priority = UILayoutPriority(rawValue: 500)
                self.secHeightConstraint.priority = UILayoutPriority(rawValue: 999)
//            }else {
//                priHeightConstraint.priority = UILayoutPriority(rawValue: 999)
//                secHeightConstraint.priority = UILayoutPriority(rawValue: 1000)
//            }

            
                        
            self.view.dropShadow(color: UIColor.clear, opacity: 10, offSet: CGSize.init(width: 3, height: 3), radius: 3, scale: true)
            if self.metric == "kg" {
                self.kbBtnTapped(kgBtn as Any)
                
            }else{
                self.lbBtnTapped(self.lbBtn as Any)
            }
        // self.weightLbl.text = String(format: "%.2f", self.weightVal)
        default:
            print(")")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func doneBtnTapped(_ sender: Any) {
        if self.weightVal != nil &&  self.weightVal > 0{
        var val = self.weightVal
        if self.metric == "lbs" {
            val = (1000*(self.weightVal * 2.20)/1000)
        }
            if self.isTargetWeight == false {
                let dict : [String : Any] = ["weight": val ,"metric": self.metric,"updated_on":Date.getCurrentDate()]
                 TraineeInfo.details.weight = dict
                    TraineeDetails.traineeDetails?.currrent_weight = Currrent_Weight(weight: val, metric: self.metric, updated_on: Date.getCurrentDate())
            }else {
                TraineeDetails.traineeDetails?.targetWeight = Float(val)
            }
       
          self.weightDelegate?.updateWeightForProfile()
            self.dismiss(animated: true, completion: nil)
            
        }else {
        presentAlertWithTitle(title: "", message: "Please select weight", options: "OK") { (option) in

                  }
        }
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func lbBtnTapped(_ sender: Any) {
        if self.lbBtn.isSelected  {
             self.lbBtn.isSelected = false
            self.lbBtn.setTitleColor(UIColor.white, for: .normal)
             self.kgBtn.isSelected = true
            self.weightLbl.text = String(format: "%.2f", self.weightVal)
                   self.kgBtn.setTitleColor(AppColours.appYellow, for: .normal)
            self.metric = "kg"
        }
        else {
            self.lbBtn.isSelected = true
            self.kgBtn.isSelected = false
            let weight =  Double(self.weightVal * 2.20)
            self.weightLbl.text = String(format: "%.2f", weight)
            self.metric = "lbs"
            self.lbBtn.setTitleColor(AppColours.appYellow, for: .normal)
             self.kgBtn.setTitleColor(UIColor.white, for: .normal)
        }
        if self.navigationType == .profileMenu && self.isOffsetSet == false {
             let offsetX = CGFloat(self.weightVal * 10) - scrollView.contentInset.left
            scrollView.setContentOffset(CGPoint(x:offsetX , y: scrollView.frame.origin.y), animated: true)
            self.isOffsetSet = true
        }
    }
    @IBAction func kbBtnTapped(_ sender: Any) {
       if self.kgBtn.isSelected  {
             self.kgBtn.isSelected = false
        self.kgBtn.setTitleColor(UIColor.white, for: .normal)
        self.lbBtn.isSelected = true
        let weight =  Double(self.weightVal * 2.20)
        self.weightLbl.text = String(format: "%.2f", weight)
        self.metric = "lbs"
        self.lbBtn.setTitleColor(AppColours.appYellow, for: .normal)
        }
        else {
            self.kgBtn.isSelected = true
           self.lbBtn.isSelected = false
        self.weightLbl.text = String(format: "%.2f", self.weightVal)
        self.kgBtn.setTitleColor(AppColours.appYellow, for: .normal)
        self.lbBtn.setTitleColor(UIColor.white, for: .normal)
        self.metric = "kg"
        }
        if self.navigationType == .profileMenu && self.isOffsetSet == false {
             let offsetX = CGFloat(self.weightVal * 10) - scrollView.contentInset.left
            scrollView.setContentOffset(CGPoint(x:offsetX , y: scrollView.frame.origin.y), animated: true)
            self.isOffsetSet = true
        }
    }
    func setScrollView()
    {
       
        scrollView.translatesAutoresizingMaskIntoConstraints = false
         self.view.addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant:0).isActive = true
        scrollView.topAnchor.constraint(equalTo: headerLbl.topAnchor, constant: 60).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 100).isActive = true
       // scrollView = UIScrollView(frame: CGRect(x: 20, y: Int(self.headerLbl.frame.maxY) + 50, width: Int(self.view.frame.maxX) - 40, height: 100))
        
        let imageView = UIImageView()
        imageView.frame = CGRect(x: Int(scrollView.frame.midX), y: Int(scrollView.frame.minY), width: 1, height: 80)
        imageView.backgroundColor = AppColours.textGreen
      //  self.view.addSubview(imageView)
        
       // weightLbl.frame = CGRect(x: Int(scrollView.frame.midX) - 50, y: Int(imageView.frame.maxY) + 10, width: 100, height: 30)
        weightLbl.textAlignment = .center
        weightLbl.textColor = AppColours.appGreen
               weightLbl.font = UIFont(name: "Lato-Regular", size: 12.0)
     //    self.view.addSubview(weightLbl)
        var origin  = 0
        for i in 1...400 {
            let view = UIView()
            view.backgroundColor = .black
            
            if i % 5 == 0 {
                view.frame = CGRect(x: origin, y: 0, width: 1, height: 80)
                view.backgroundColor = .lightGray
                
            } else {
                view.frame = CGRect(x: origin, y: 15, width: 1, height: 40)
                view.backgroundColor = .lightGray
            }
            scrollView.addSubview(view)
            origin = Int(view.frame.maxX) + 5
        }
       
        scrollView.contentSize = CGSize(width: origin + 150, height: 100)
         scrollView.delegate = self
    }
  
}
extension WeightViewController: UIScrollViewDelegate {
    
    // this is for exactly stop on line
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / 10
        let roundedIndex = round(index)

        offset = CGPoint(x: roundedIndex * 10 - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
     
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset
        let index = (offset.x + scrollView.contentInset.left) / 10
        let roundedIndex = (index)

       let selectedNumber = roundedIndex <= 0 ? 0 : Double(roundedIndex)
        if self.lbBtn.isSelected {
            let weight =  Double((1000 * (selectedNumber * 2.20))/1000)
             weightLbl.text = String(format: "%.2f", weight)
           // self.weightVal = weight
        }else {
            
           
              weightLbl.text = String(format: "%.2f", selectedNumber)
        }
       
         self.weightVal = Double((1000 * selectedNumber)/1000)
      
    }
}

extension WeightViewController : BottomViewDelegate {
    func leftBtnTapped() {
        self.navigationController?.popViewController(animated: true)
        
    }
    func rightBtnTapped() {
        if self.weightVal != nil &&  self.weightVal > 0{
            var val = self.weightVal
            if self.metric == "lbs" {
                val = (1000*(self.weightVal * 2.20)/1000)
            }
            let dict : [String : Any] = ["weight": val ,"metric": self.metric,"updated_on":Date.getCurrentDate()]
             TraineeInfo.details.weight = dict
                   let storyboard = UIStoryboard(name: "HeightViewController", bundle: nil)
                   let controller = storyboard.instantiateViewController(withIdentifier: "heightVC")
                   self.navigationController?.pushViewController(controller, animated: true)
        }
        else {
        presentAlertWithTitle(title: "", message: "Please select weight", options: "OK") { (option) in

                  }
        }
       
    }
}
extension Date {

 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd"
    
        return dateFormatter.string(from: Date())

    }
    static func getCurrentDateInFormat(format:String) -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = format
    
        return dateFormatter.string(from: Date())

    }
    static func getDateInFormat(format:String, date:Date) -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = format
    
        return dateFormatter.string(from: date)

    }
    static func getEndDateInFormat(format:String, week: Int, startDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: startDate)
        Calendar.current.date(byAdding: .weekOfYear, value: week, to: date!)
        return dateFormatter.string(from: Date())
    }
    static func convertToLocalDateFromUTCDate(dateStr : String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let sourceDate = formatter.date(from: dateStr)
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "MMM dd @hh:mm aa"
        let localTime = formatter2.string(from: sourceDate!)
        print("local time %@",localTime)
        return localTime
    }
    
  static  func convertDateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "your_loc_id")
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
}
//"currrent_weight": {
//  "weight": 2.23,
//  "metric": "KG",
//  "updated_on": "22020-04-12"
//}
