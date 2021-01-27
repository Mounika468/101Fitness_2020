//
//  WOUpdateViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 18/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
let repTag = 1000
 let weightTag = 10000
 let restTag = 100
class WOUpdateViewController: UIViewController {
    var navigationView = NavigationView()
   // @IBOutlet weak var woUpdateView: WOUpdateView!
    var xBarHeight :CGFloat  = 0.0
    var setsArr : [Sets]?
    @IBOutlet weak var tblView: UITableView!
    var selectedIndexPath : Int?
     var selectedExPath : Int?
    var updatedRest : String?
    var updatedWeight : String?
    var updatedReps : String?
    var modifiedSets : [Sets]?
    var programId : String?
     var workOutId : String?
     var exerciseId : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        let navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight))
        navigationView.titleLbl.text = "WorkOut Update"
        navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        navigationView.saveBtn.isHidden = false
        navigationView.saveBtn .addTarget(self, action: #selector(saveBtnTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(navigationView)
        self.navigationController?.isNavigationBarHidden = true
        let nib = UINib(nibName: "SetsTableViewCell", bundle: nil)
        self.tblView.register(nib, forCellReuseIdentifier: "setsCell")
        self.modifiedSets = self.setsArr
        self.hideKeyboardWhenTappedAround()
    }
    @objc func backBtnTapped(sender : UIButton){
        self.dismiss(animated: true, completion: {
        })
    }
    @objc func saveBtnTapped(sender : UIButton){
          self.hideKeyboardWhenTappedAround()
        self.updateSetsAPICall()
        if let index = self.selectedIndexPath {
        let indexpath = NSIndexPath(row: index, section: 0)
        let cell = self.tblView.cellForRow(at: indexpath as IndexPath) as? SetsTableViewCell
            print("text rep,rest ,wightchanged \(indexpath.row),\(String(describing: cell!.weightTxtField.text)),\(cell!.repTxtField.text ?? ""),\(cell!.restTxtField.text)")
            cell?.repTxtField.resignFirstResponder()
            cell?.weightTxtField.resignFirstResponder()
            cell?.restTxtField.resignFirstResponder()
        }
        self.dismiss(animated: true, completion: {
            
        })
    }

     // MARK: - Navigation
    func updateSetsAPICall() {
//        if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.programId) {
//            ProgramDetails.programDetails.programId = id
//        }
       if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
           ProgramDetails.programDetails.subId = id
       }
        if let id = UserDefaults.standard.string(forKey:ProgramDetails.programDetails.subId) {
            ProgramDetails.programDetails.programId = id
        }
        let woPostBody = WOUpdatePostBody(program_id: ProgramDetails.programDetails.programId, workoutId: ProgramDetails.programDetails.workoutId, date: Date.getDateInFormat(format: "dd/MM/yyyy", date: ProgramDetails.programDetails.selectedWODate), exercise_referenceId: ProgramDetails.programDetails.exerciseRefId, trainee_id: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, exerciseStatus: WOStatus.inProgress,sets: self.modifiedSets!)
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(woPostBody)
        WOUpdateCalls.setsUpdatePost(parameters: [:], header: [:], dataParams: jsonData, successHandler:
            { [weak self] dayWorks in
                ProgramDetails.programDetails.dayWorkOut = dayWorks
                 NotificationCenter.default.post(name:NSNotification.Name(rawValue: WorkOutsUpdatedNotification), object: dayWorks)
        }, errorHandler: {  error in
            print(" error \(error)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
        })
    }
    
}
//extension WOUpdateViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
//            let characterSet = CharacterSet(charactersIn: string)
//            return allowedCharacters.isSuperset(of: characterSet)
//    }
//}
extension WOUpdateViewController: SetsUpdateDelegate {
    func setUpdated(set: Sets) {
        
    }
}
extension WOUpdateViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setsArr?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "setsCell")
            as? SetsTableViewCell
            else {
                return UITableViewCell()
        }
        let set = self.setsArr![indexPath.row]
        cell.recomSet.text = String(describing: indexPath.row + 1)
        cell.recReps.text = String(describing: set.reputationValue!.actual)
        cell.recWeight.text = String(describing: set.maxWeights!.actual)
        cell.recRest.text = String(describing: set.restPeriod!.actual)
        cell.repTxtField.text = "\(set.reputationValue!.completed ?? 0)"
        cell.compSet.text = String(describing: indexPath.row + 1)
         cell.weightTxtField.text = "\(set.maxWeights!.completed ?? 0)"
         cell.restTxtField.text = "\(set.restPeriod!.completed ?? 0)"
        cell.repTxtField.tag = indexPath.row + repTag
        cell.weightTxtField.tag = indexPath.row + weightTag
        cell.restTxtField.tag = indexPath.row + restTag
        cell.restTxtField.addTarget(self, action: #selector(self.restTxtFieldDidChange(_:)), for: .editingDidEnd)
        cell.weightTxtField.addTarget(self, action: #selector(self.weightTxtFieldDidChange(_:)), for: .editingDidEnd)
        cell.repTxtField.addTarget(self, action: #selector(self.repTxtFieldDidChange(_:)), for: .editingDidEnd)
//        cell.restTxtField.delegate = self
//        cell.repTxtField.delegate = self
//         cell.weightTxtField.delegate = self
        self.selectedIndexPath = indexPath.row
         cell.layoutIfNeeded()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0;
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView : SetsHeaderView = SetsHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 80))
        return headerView
    }
    @objc func restTxtFieldDidChange(_ textField: UITextField) {
        let index = textField.tag - restTag
        let indexpath = NSIndexPath(row: index, section: 0)
        let cell = self.tblView.cellForRow(at: indexpath as IndexPath) as? SetsTableViewCell
        self.updatedRest = cell?.restTxtField.text
        var set = self.modifiedSets![index]
        set.restPeriod!.completed = Int(cell?.restTxtField.text ?? "0") ?? 0
        var weight = Int(cell?.weightTxtField.text ?? "0") ?? 0
        if weight == 0 {
            weight = set.maxWeights?.actual ?? 0
        }
        var reputat = Int(cell?.repTxtField.text ?? "0") ?? 0
        if reputat == 0 {
            reputat = set.reputationValue?.actual ?? 0
        }
        set.reputationValue!.completed = reputat
        set.maxWeights!.completed = weight
//        set.reputationValue!.completed = set.reputationValue?.actual
//         set.maxWeights!.completed = set.maxWeights?.actual
        self.modifiedSets![index] = set
        print("modified sets \(set)")
        textField.resignFirstResponder()
    }
    @objc func weightTxtFieldDidChange(_ textField: UITextField) {
           let index = textField.tag - weightTag
           let indexpath = NSIndexPath(row: index, section: 0)
           let cell = self.tblView.cellForRow(at: indexpath as IndexPath) as? SetsTableViewCell
           self.updatedWeight = cell?.weightTxtField.text
        var set = self.modifiedSets![index]
        set.maxWeights!.completed = Int(cell?.weightTxtField.text ?? "0") ?? 0
//        set.reputationValue!.completed = set.reputationValue?.actual
//         set.restPeriod!.completed = set.restPeriod?.actual
        var reputat = Int(cell?.repTxtField.text ?? "0") ?? 0
        if reputat == 0 {
            reputat = set.reputationValue?.actual ?? 0
        }
        var rest = Int(cell?.restTxtField.text ?? "0") ?? 0
        if rest == 0 {
            rest = set.restPeriod?.actual ?? 0
        }
        set.reputationValue!.completed = reputat
         set.restPeriod!.completed = rest
        self.modifiedSets![index] = set
        print("modified sets \(set)")
        textField.resignFirstResponder()
       }
    @objc func repTxtFieldDidChange(_ textField: UITextField) {
             let index = textField.tag - repTag
              let indexpath = NSIndexPath(row: index, section: 0)
              let cell = self.tblView.cellForRow(at: indexpath as IndexPath) as? SetsTableViewCell
              self.updatedReps = cell?.repTxtField.text
        var set = self.modifiedSets![index]
        set.reputationValue!.completed = Int(cell?.repTxtField.text ?? "0") ?? 0
//         set.restPeriod!.completed = set.restPeriod?.actual
//         set.maxWeights!.completed = set.maxWeights?.actual
        
        var weight = Int(cell?.weightTxtField.text ?? "0") ?? 0
        if weight == 0 {
            weight = set.maxWeights?.actual ?? 0
        }
        var rest = Int(cell?.restTxtField.text ?? "0") ?? 0
        if rest == 0 {
            rest = set.restPeriod?.actual ?? 0
        }
        set.maxWeights!.completed = weight
         set.restPeriod!.completed = rest
        self.modifiedSets![index] = set
        print("modified sets \(set)")
        textField.resignFirstResponder()
          }
    
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

