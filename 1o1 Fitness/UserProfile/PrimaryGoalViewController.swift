//
//  PrimaryGoalViewController.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 16/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class PrimaryGoalViewController: UIViewController {

    @IBOutlet weak var bottomView: ProfileBottomView!
    @IBOutlet weak var headerView: ProfileHeaderView!
    @IBOutlet weak var tableView: UITableView!
    let array1 : Array = ["Lose weight","Maintain weight","Gain weight"]
    let array2 : Array = ["Your meal plan will be focused on fat loss if you have secondary goals like building muscle, getting stronger, or just being more fit your routine will address those as well.","Get leaner, stronger, and fitter by losing fat and building muscles at the same time while maintaining your weight.","Your meal plan will be focused on gaining muscle. If you have secondary goals like getting generally fitter/stronger your routine will address those as well."]
    var selectedPrimaryGoal  = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "BorderTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "primaryCell")
        headerView.countLbl.text = "7 / 11"
                      bottomView.bottonDelegate = self
        tableView.tableFooterView = UIView()
        
        
    }
    
    @IBAction func leftBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func rightBtnTapped(_ sender: Any) {
        if TraineeInfo.details.primaryGoal.count != 0 {
            let storyboard = UIStoryboard(name: "WorkOutStoryboard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "workoutVC") as! WorkOutDaysViewController
             controller.navigationType = .profileNormal
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
        presentAlertWithTitle(title: "", message: "Please select primary goal", options: "OK") { (option) in

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
extension PrimaryGoalViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
        return 95
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
         let cell = tableView.dequeueReusableCell(withIdentifier: "primaryCell",
                                                       for: indexPath) as! BorderTableViewCell
        cell.headerLbl.text = array1[indexPath.section]
        cell.detailLbl.text = array2[indexPath.section]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPrimaryGoal =  array1[indexPath.section]
    }
}
extension PrimaryGoalViewController : BottomViewDelegate {
    func leftBtnTapped() {
        self.navigationController?.popViewController(animated: true)
        
    }
    func rightBtnTapped() {
        if   self.selectedPrimaryGoal.count != 0 {
        TraineeInfo.details.primaryGoal = self.selectedPrimaryGoal
                   let storyboard = UIStoryboard(name: "WorkOutStoryboard", bundle: nil)
                   let controller = storyboard.instantiateViewController(withIdentifier: "workoutVC")
                   self.navigationController?.pushViewController(controller, animated: true)
               } else {
               presentAlertWithTitle(title: "", message: "Please select primary goal", options: "OK") { (option) in

                         }
               }
}
}
