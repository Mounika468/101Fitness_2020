//
//  WorkOutDaysViewController.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 11/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//

import UIKit
enum NavigationType {
    case profileMenu
    case profileNormal
}
class WorkOutDaysViewController: UIViewController {

    @IBOutlet  var firstPriority: NSLayoutConstraint!
    @IBOutlet  var secPriority: NSLayoutConstraint!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var bottomView: ProfileBottomView!
    @IBOutlet weak var headerView: ProfileHeaderView!
   // @IBOutlet weak var norealTimeBtn: UIButton!
    @IBOutlet weak var timeCV: UICollectionView! {
        didSet {
            timeCV.showsVerticalScrollIndicator = false
            timeCV.showsHorizontalScrollIndicator = false
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    var days : Array = ["sun","mon","tue","wed","thu","fri","sat"]
     var workOutLevel : Array = ["< 30 mins","60 mins","","30 mins","75 mins","> 90 mins","45 mins"," 90 mins"]
    var selectedDays = [Int] ()
    var lastSelectedIndex  = -1
    var lastSelectedTime  = -1
    var selectedTime: String = ""
    var selectedDayNames : Array = [String] ()
    var navigationType: NavigationType = .profileNormal
    
     var selectedTimeIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        headerView.countLbl.text = "8 / 11"
        bottomView.bottonDelegate = self
        let nib = UINib(nibName: "DaysCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier:"dayCV")
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = flowLayout
        
        
        let timeNib = UINib(nibName: "WorkOuttimeCollectionViewCell", bundle: nil)
        self.timeCV.register(timeNib, forCellWithReuseIdentifier:"workoutCV")
        let timeFlowLayout = UICollectionViewFlowLayout()
        timeFlowLayout.scrollDirection = .horizontal
        self.timeCV.collectionViewLayout = timeFlowLayout
          self.backBtn.isHidden = true
       // self.norealTimeBtn.layer.cornerRadius = 8.0
      //  self.norealTimeBtn.layer.borderWidth = 0.5
      //  self.norealTimeBtn.layer.borderColor = AppColours.appGreen.cgColor
        
//        if self.navigationType == .profileMenu {
//
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        switch self.navigationType {
        case .profileNormal:
            self.headerView.isHidden = false
            self.bottomView.isHidden = false
            self.backBtn.isHidden = true
            secPriority.priority = UILayoutPriority(rawValue: 999)
             firstPriority.priority = UILayoutPriority(rawValue: 1000)
//            secPriority.isActive = false
//            firstPriority.isActive = true
           
        case .profileMenu:
            self.headerView.isHidden = true
            self.bottomView.isHidden = true
            self.backBtn.isHidden = false
            firstPriority.priority = UILayoutPriority(rawValue: 999)
            secPriority.priority = UILayoutPriority(rawValue: 1000)
//            firstPriority.isActive = false
//            secPriority.isActive = true
             self.view.dropShadow(color: UIColor.white, opacity: 10, offSet: CGSize.init(width: 3, height: 3), radius: 3, scale: true)
             self.selectedDayNames = []
            for i in 0 ..< self.selectedDays.count {
                self.selectedDayNames.append(days[self.selectedDays[i]])
            }
        default:
            print(")")
        }
    }
    @IBAction func backBtnTapped(_ sender: Any) {
         if self.selectedTime.count != 0 && self.selectedDayNames.count > 0{
        let unique = Array(Set(self.selectedDayNames))
               TraineeInfo.details.best_workout_day = ["days" : unique, "time_spent": self.selectedTime]
        self.dismiss(animated: true, completion: nil)
         }else {
            presentAlertWithTitle(title: "", message: "Please select workout days and time", options: "OK") { (option) in
                             }
        }
    }
    @IBAction func btnLeftTapped(_ sender: Any) {
       
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnRightTapped(_ sender: Any) {
        
//        if self.selectedTime.count != 0 {
//
//            for dayName in self.selectedDayNames {
//
//                let dict = ["day":dayName,"spentTime":self.selectedTime]
//                TraineeInfo.details.days.append(dict)
//            }
//
//            let storyboard = UIStoryboard(name: "DieteryOptions", bundle: nil)
//            let controller = storyboard.instantiateViewController(withIdentifier: "dietOptions")
//            self.navigationController?.pushViewController(controller, animated: true)
//        }else {
//        presentAlertWithTitle(title: "", message: "Please select workout days and time", options: "OK") { (option) in
//
//                  }
//        }
        
        
        
    }
    
    @IBAction func norealTimeBtnTapped(_ sender: Any) {
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
extension WorkOutDaysViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.collectionView:
            return days.count
        default:
            return workOutLevel.count
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.collectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCV", for: indexPath) as! DaysCollectionViewCell
            cell.dayLabel.text = days[indexPath.row].capitalized
            cell.dayBtn.tag = indexPath.row
            cell.dayBtn.addTarget(self, action: #selector(dayBtnTapped(sender:)), for: .touchUpInside)
            if self.navigationType == .profileMenu {
                if self.selectedDayNames.contains(days[indexPath.row]) {
                     cell.dayBtn.backgroundColor = AppColours.appGreen
                    cell.dayBtn.isSelected = true
                }else {
                    cell.dayBtn.backgroundColor = UIColor.clear
                     cell.dayBtn.isSelected = false
                                     
                }
                
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "workoutCV", for: indexPath) as! WorkOuttimeCollectionViewCell
            cell.timeBtn .setTitle(workOutLevel[indexPath.row], for: .normal)
                //   cell.timeBtn.text = workOutLevel[indexPath.row]
            cell.timeBtn.tag = indexPath.row
            cell.timeBtn.addTarget(self, action: #selector(timeBtnTapped(sender:)), for: .touchUpInside)
            if indexPath.row == 2 {
                cell.isHidden = true
            }
            if self.navigationType == .profileMenu {
                if self.selectedTimeIndex == indexPath.row {
                    cell.timeBtn.isSelected = true
                    lastSelectedTime = cell.timeBtn.tag
                    cell.timeBtn.backgroundColor = AppColours.appGreen
                    cell.bgView.backgroundColor = AppColours.appGreen
                    self.selectedTime = self.workOutLevel[ cell.timeBtn.tag]
                }
            }
          return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case self.collectionView:
             let noOfCellsInRow = 7

                       let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

                       let totalSpace = flowLayout.sectionInset.left
                           + flowLayout.sectionInset.right
                           + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

                       let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

                       return CGSize(width: size, height: 50)
        default:
            let noOfCellsInRow = 3

                   let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

                   let totalSpace = flowLayout.sectionInset.left
                       + flowLayout.sectionInset.right
                       + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

                   let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

                   return CGSize(width: size, height: 30)
        }
       
        
       // return CGSize.init(width: collectionView.frame.width/7 - 5, height: 80)
    }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

    func checkConsecutiveDays(sender : UIButton) -> Bool
    {
        if selectedDays.count != 0 && sender.tag != lastSelectedIndex{
            
            for index in selectedDays
            {
                if index != 0 && (index + 1 == sender.tag ||  index - 1 == sender.tag)
                {
                    return true
                }
                else if index + 1 == sender.tag
                {
                    return true
                }

            }
            
            selectedDays.append(sender.tag)
             lastSelectedIndex = sender.tag
        }
        else
        {
            selectedDays.append(sender.tag)
            lastSelectedIndex = sender.tag
        }
        return false
    }
    @objc func dayBtnTapped(sender : UIButton){
       

        if sender.isSelected == true {
                  sender.isSelected = false
            sender.backgroundColor = UIColor.clear
            self.selectedDayNames.removeAll(where: { $0 == days[sender.tag] })
            self.selectedDays.removeAll(where: { $0 == sender.tag })
                }else {
                  sender.isSelected = true
            sender.backgroundColor = AppColours.appGreen
            self.selectedDayNames.append(days[sender.tag])
            self.selectedDays.append(sender.tag)
                }
        let myIndexPath = IndexPath(row: sender.tag, section: 0)
        self.collectionView.reloadItems(at: [myIndexPath])
    }
    @objc func timeBtnTapped(sender : UIButton){
           let myIndexPath = IndexPath(row: sender.tag, section: 0)
         let selectedCell = self.timeCV.cellForItem(at: myIndexPath) as! WorkOuttimeCollectionViewCell
               if sender.isSelected == true {
                  sender.isSelected = false
               sender.backgroundColor = UIColor.clear
                 selectedCell.bgView.backgroundColor = UIColor.clear
                
                }else {
                if lastSelectedTime != -1
                {
                    let myIndexPath = IndexPath(row: lastSelectedTime, section: 0)
                    let cell = self.timeCV.cellForItem(at: myIndexPath) as! WorkOuttimeCollectionViewCell
                    cell.timeBtn.backgroundColor = UIColor.clear
                    selectedCell.bgView.backgroundColor = UIColor.clear
                    let prevIndexPath = IndexPath(row: lastSelectedTime, section: 0)
                    let prevSelectedCell = self.timeCV.cellForItem(at: prevIndexPath) as! WorkOuttimeCollectionViewCell
                    prevSelectedCell.bgView.backgroundColor = UIColor.clear
                    
                }
                sender.isSelected = true
                lastSelectedTime = sender.tag
                sender.backgroundColor = AppColours.appGreen
                selectedCell.bgView.backgroundColor = AppColours.appGreen
                self.selectedTime = self.workOutLevel[sender.tag]
                }

    }
    func reloadDaysSelection() {
        if self.selectedDays.count > 0 {
           // var slectedIndexPaths = [IndexPath]()
            for i in 0 ..< self.selectedDays.count {
                let selectedCell = self.collectionView.cellForItem(at: IndexPath(row: self.selectedDays[i], section: 0)) as! DaysCollectionViewCell
                selectedCell.dayBtn.backgroundColor = AppColours.appGreen
                self.selectedDayNames.append(days[i])
           // slectedIndexPaths.append(IndexPath(row: i, section: 0))
            }
           // self.collectionView.reloadItems(at: slectedIndexPaths)
        }
    }
}
extension WorkOutDaysViewController : BottomViewDelegate {
    func leftBtnTapped() {
        self.navigationController?.popViewController(animated: true)
        
    }
    func rightBtnTapped() {
        if self.selectedTime.count != 0 && self.selectedDayNames.count > 0{
//            for dayName in self.selectedDayNames {
//                let dict = ["day":dayName,"spentTime":self.selectedTime]
//                TraineeInfo.details.days.append(dict)
//            }
            let unique = Array(Set(self.selectedDayNames))
            TraineeInfo.details.best_workout_day = ["days" : unique, "time_spent": self.selectedTime]
            let storyboard = UIStoryboard(name: "FoodPreferenceVC", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "foodPreferVC")
            self.navigationController?.pushViewController(controller, animated: true)
        }else {
        presentAlertWithTitle(title: "", message: "Please select workout days and time", options: "OK") { (option) in
                  }
        }
    }
}

