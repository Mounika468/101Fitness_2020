//
//  ActivityViewController.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 11/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {

    @IBOutlet weak var bottomView: ProfileBottomView!
    @IBOutlet weak var headerView: ProfileHeaderView!
    @IBOutlet weak var tblView: UITableView!
    var activityLevel : Array = ["Sedentary (little or no exercise)","Lightly active (light exercise/sports 1-3 days/week)","Moderately active (moderate exercise/sports 3-5 days/week)","Very active (hard exercise/sports 6-7 days a week)","Extra active (very hard exercise/sports & a physical job)"]
     var selectedIndexPath: IndexPath?
    var selectedActivity = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        headerView.countLbl.text = "6 / 11"
               bottomView.bottonDelegate = self
        let nib = UINib(nibName: "BorderCellTableViewCell", bundle: nil)
        self.tblView.register(nib, forCellReuseIdentifier: "borderCell")
        tblView.tableFooterView = UIView()
        
    }
    
    @IBAction func leftBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func rightBtnTapped(_ sender: Any) {
        if  TraineeInfo.details.activityLevel.count != 0 {
        let storyboard = UIStoryboard(name: "PrimaryGoal", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "primaryGoalVC")
        self.navigationController?.pushViewController(controller, animated: true)
        }else {
        presentAlertWithTitle(title: "", message: "Please select activity level", options: "OK") { (option) in

                  }
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

}
// MARK: - UITableView Delegate/Datasource methods

/// Handles the UITableView logic
extension ActivityViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 60
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "borderCell")
            as? BorderCellTableViewCell
            else {
                return UITableViewCell()
        }
        cell.headerLbl.text = activityLevel[indexPath.section]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedActivity =  activityLevel[indexPath.section]
        let selectedActivityArr = self.selectedActivity.components(separatedBy: "(")
        self.selectedActivity = selectedActivityArr[0]
    }
    
    
}
extension ActivityViewController : BottomViewDelegate {
    func leftBtnTapped() {
        self.navigationController?.popViewController(animated: true)
        
    }
    func rightBtnTapped() {
        if  self.selectedActivity.count != 0 {
            TraineeInfo.details.activityLevel = self.selectedActivity.trimmingCharacters(in: .whitespaces)
               let storyboard = UIStoryboard(name: "PrimaryGoal", bundle: nil)
               let controller = storyboard.instantiateViewController(withIdentifier: "primaryGoalVC")
               self.navigationController?.pushViewController(controller, animated: true)
               }else {
               presentAlertWithTitle(title: "", message: "Please select activity level", options: "OK") { (option) in

                         }
               }
       
    }
}
