//
//  WorkOutView.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 15/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
protocol workOutViewDelegate {
    func workOutSelected(indexPath : NSIndexPath, exercises: Workouts)
    func workOutMessageSelected(indexPath : NSIndexPath, workOut: Workouts,commentType: CommentsType)
     func cardioSelected(indexPath : NSIndexPath, cardio: Cardio)
    func cardioMessageSelected(indexPath : NSIndexPath, cardio: Cardio,commentType: CommentsType)
    func completeWorkOut()
    func completeCardio()
}
class WorkOutView: UIView {

    @IBOutlet weak var restLbl: UILabel!
    @IBOutlet weak var restView: UIView!
    @IBOutlet weak var workOutTableView: UITableView!
    @IBOutlet var contentView: UIView!
    var woViewDelegate: workOutViewDelegate?
    var workOutsArr : DayWorkOuts?
     var cardioIndex : Int = 0
    var cardioAvailable : Bool = false
    @IBOutlet weak var nodataLbl: UILabel!
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
            Bundle.main.loadNibNamed("WorkOutView", owner: self, options: nil)
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            contentView.backgroundColor = UIColor.clear
            let nib = UINib(nibName: "WorkOutTypeTableViewCell", bundle: nil)
            self.workOutTableView.register(nib, forCellReuseIdentifier: "WOTypeCell")
            workOutTableView.tableFooterView = UIView()
            workOutTableView.separatorColor = UIColor.clear
            self.nodataLbl.isHidden = true
            self.restLbl.textColor = AppColours.graphYello
    }
    func loadWorkOuts() {
        self.nodataLbl.isHidden = true
        self.restView.isHidden = true
        self.workOutTableView.reloadData()
    }
    func displayNoWorkouts(message:String) {
        self.nodataLbl.isHidden = false
        self.nodataLbl.text = message
        self.restView.isHidden = true
    }
    func displayRestView(message:String) {
        self.nodataLbl.isHidden = true
        //self.nodataLbl.text = message
        self.restView.isHidden = false
    }
    func checkIfCardioExist()->Bool {
        if let cardio = self.workOutsArr?.cardio {
            if let name = cardio.name {
                  return true
            }
            return false
        }else {
            return false
        }
    }
}
extension WorkOutView: UITableViewDelegate,UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 120
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return self.workOutList?.workoutExercises?.count ?? 0
        let cardio = checkIfCardioExist()
        if cardio {
            print("rows \((self.workOutsArr?.workouts?.count ?? 0 + 1))")
           return (self.workOutsArr?.workouts?.count ?? 0) + 1
        }
        else {
        return self.workOutsArr?.workouts?.count ?? 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WOTypeCell")
                           as? WorkOutTypeTableViewCell
                           else {
                            return UITableViewCell()
                            
        }
            cell.selectionStyle = .none
        let cardio = checkIfCardioExist()
        if cardio == true && (indexPath.row == self.workOutsArr?.workouts?.count) {
            let object = self.workOutsArr?.cardio
            if object?.cardioStatus?.lowercased() == WOStatus.complete.lowercased() {
                cell.editBtn.setImage(UIImage(named: "ccomplete"), for: .normal)
                 cell.editBtn.isHidden = false
            }else {
                 cell.editBtn.isHidden = true
            }
            let name = object?.name?.uppercased()
             cell.workOutNameLbl.text = name
           
            cell.startBtn.isHidden = true
            var actual = ""
            if let val = object?.distance?.actual  {
                actual = "\(val)"
            }
            if let metric = object?.metrics {
                actual = actual + " " + metric
            }else {
                actual = ""
            }
           cell.perWOLbl.text = actual
            if let images = object?.imgUrl {
                cell.workOutImgView?.sd_setImage(with: URL(string:images), placeholderImage: UIImage(named: "chest"))
            }
          
            self.cardioIndex = indexPath.row
        }else {
            let object = self.workOutsArr?.workouts?[indexPath.row]
            let name = object?.workoutName?.name.uppercased()
            cell.workOutNameLbl.text = name
            if object?.workoutStatus == "new" {
                cell.editBtn.isHidden = true
                 cell.startBtn.isHidden = false
            }else if object?.workoutStatus == WOStatus.complete {
                cell.editBtn.isHidden = false
                cell.editBtn.setImage(UIImage(named: "ccomplete"), for: .normal)
                cell.startBtn.isHidden = true
            }else {
                cell.editBtn.isHidden = false
                cell.editBtn.setImage(UIImage(named: "arrow"), for: .normal)
                cell.startBtn.isHidden = true
            }
            cell.perExerLbl.text = (object?.workoutPercentage)! + "% Completed"
            let excount = object!.workoutExercises!.count - (self.checkRestCount(workOut: object!))
            cell.perWOLbl.textColor = AppColours.textBlue
            cell.perWOLbl.text = "\(String(describing: excount)) Exercises"
            let images = object?.workoutName?.imgUrl
            cell.workOutImgView?.sd_setImage(with: URL(string:images!), placeholderImage: UIImage(named: "chest"))
        }

        cell.startBtn.tag = indexPath.row
        cell.startBtn.addTarget(self, action: #selector(startBtnTapped(sender:)), for: .touchUpInside)
            return cell
    }
    func checkRestCount(workOut:Workouts)-> Int {
        var count = 0
        for index in 0...(workOut.workoutExercises!.count - 1) {
         let exercises = workOut.workoutExercises![index]
            let name = exercises.exerciseName.uppercased()
            if name.lowercased() == "rest" {
                count = count + 1
            }
            
        }
        return count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != self.cardioIndex {
            let object = self.workOutsArr?.workouts?[indexPath.row]
            if object?.workoutStatus == "new" {
                return
            }
            self.woViewDelegate?.workOutSelected(indexPath:indexPath as NSIndexPath,exercises:(self.workOutsArr?.workouts?[indexPath.row])!)
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.row != self.cardioIndex {
            var object = self.workOutsArr?.workouts?[indexPath.row]
            if object?.workoutStatus == "new" || (object?.workoutStatus == WOStatus.complete || object?.workoutPercentage == "100") {
                return nil
            }
            object = nil
        }else  {
            if self.checkIfCardioExist() {
                let object = self.workOutsArr?.cardio
               if object?.cardioStatus?.lowercased() == WOStatus.complete.lowercased() {
                   return nil
               }
            }
            
        }
        let complete = UIContextualAction(style: .normal, title: "") {
                         action, sourceView, completionHandler in
                       let actionPerformed = self.completeAction(action: action, sourceView: sourceView, indexPath: indexPath)
                         completionHandler(actionPerformed)
                     }
                   complete.image = UIImage(named: "complete")
                   complete.backgroundColor =  UIColor.black
        
        let edit = UIContextualAction(style: .normal, title: "") {
                                action, sourceView, completionHandler in
                                let actionPerformed = self.editAction(action: action, sourceView: sourceView, indexPath: indexPath)
                                completionHandler(actionPerformed)
                            }
        if indexPath.row != self.cardioIndex {
             let object = self.workOutsArr?.workouts?[indexPath.row]
            if  object?.workoutStatus == WOStatus.notCompleted {
                                   edit.image = UIImage(named: "gedit")
            }else {
                                 edit.image = UIImage(named: "edit")
            }
        }else {
            let object = self.workOutsArr?.cardio
            if  object?.cardioStatus == WOStatus.notCompleted {
                                 edit.image = UIImage(named: "gedit")
            }else {
                                  edit.image = UIImage(named: "edit")
            }
        }
                          
                          edit.backgroundColor =  UIColor.black
                         
                     let delete = UIContextualAction(style: .normal, title: "") {
                         action, sourceView, completionHandler in
                         let actionPerformed = self.deleteAction(action: action, sourceView: sourceView, indexPath: indexPath)
                         completionHandler(actionPerformed)
                     }

        if indexPath.row != self.cardioIndex {
             let object = self.workOutsArr?.workouts?[indexPath.row]
            if   object?.workoutStatus == WOStatus.notCompleted {
                                   delete.image = UIImage(named: "rdelete")
            }else {
                                  delete.image = UIImage(named: "gdelete")
            }
        }else {
            let object = self.workOutsArr?.cardio
            if  object?.cardioStatus == WOStatus.notCompleted {
                                  delete.image = UIImage(named: "rdelete")
            }else {
                                   delete.image = UIImage(named: "gdelete")
            }
        }
                   delete.backgroundColor =  UIColor.black
        
        let message = UIContextualAction(style: .normal, title: "") {
                                      action, sourceView, completionHandler in
                                      let actionPerformed = self.messageAction(action: action, sourceView: sourceView, indexPath: indexPath)
                                      completionHandler(actionPerformed)
                                  }
        if indexPath.row != self.cardioIndex {
//             let object = self.workOutsArr?.workouts?[indexPath.row]
//            if  object?.workoutComments?.count ?? 0 > 0  || object?.workoutStatus == WOStatus.notCompleted {
                message.image = UIImage(named: "message")
//            }else {
//                message.image = UIImage(named: "gmessage")
//            }
        }else {
             message.image = UIImage(named: "message")
//            let object = self.workOutsArr?.cardio
//            if  object?.cardioComments?.count ?? 0 > 0 || object?.cardioStatus == WOStatus.notCompleted {
//                message.image = UIImage(named: "message")
//            }else {
//                message.image = UIImage(named: "gmessage")
//            }
        }
                                message.backgroundColor =  UIColor.black
                     let config = UISwipeActionsConfiguration(actions: [message,delete,edit,complete])
                     config.performsFirstActionWithFullSwipe = false
               let cell:UITableViewCell = (tableView.cellForRow(at: IndexPath(row: indexPath.row, section: 0)))!
               cell.backgroundColor = UIColor.black
               //action.backgroundColor = UIColor.green
                     return config
       // }
      }
    @objc func startBtnTapped(sender : UIButton){
        let indexPath = NSIndexPath(row:sender.tag, section: 0)
        self.woViewDelegate?.workOutSelected(indexPath:indexPath as NSIndexPath,exercises: (self.workOutsArr?.workouts?[sender.tag])!)

    }
      func completeAction(action: UIContextualAction, sourceView: UIView,indexPath: IndexPath) -> Bool {
        
        if indexPath.row != self.cardioIndex  {
             var object = self.workOutsArr?.workouts?[indexPath.row]
            ProgramDetails.programDetails.workoutId = object!.workoutId
            if object?.workoutStatus !=  WOStatus.notCompleted  {
                 self.woViewDelegate?.completeWorkOut()
            }
          object = nil
        }else {
            if self.checkIfCardioExist() {
            var object = self.workOutsArr?.cardio
            if object?.cardioStatus !=  WOStatus.notCompleted  {
                  self.woViewDelegate?.completeCardio()
            }
          object = nil
        }
        }
       print("Complete Actions")
          return true //You may need to return false if the action is cancelled
      }
        
      func deleteAction(action: UIContextualAction, sourceView: UIView,indexPath: IndexPath) -> Bool {
          //Do somethiing for "Added" button.
          //...
        print("delete Actions")
        if indexPath.row != self.cardioIndex {
            self.woViewDelegate?.workOutMessageSelected(indexPath:indexPath as NSIndexPath, workOut: (self.workOutsArr?.workouts?[indexPath.row])! ,commentType: .workoutDelete)
        }else {
            if self.checkIfCardioExist() {
                let object = self.workOutsArr?.cardio
                self.woViewDelegate?.cardioMessageSelected(indexPath: indexPath as NSIndexPath, cardio: object!,commentType: .cardioDelete)
            }
           
        }
          return true //You may need to return false if the action is cancelled
      }
    func editAction(action: UIContextualAction, sourceView: UIView,indexPath: IndexPath) -> Bool {
        //Do somethiing for "Added" button.
        //...
      print("editAction Actions")
        if indexPath.row == self.cardioIndex && self.checkIfCardioExist() {
             let object = self.workOutsArr?.cardio
            if object?.cardioStatus != WOStatus.notCompleted {
                self.woViewDelegate?.cardioSelected(indexPath: indexPath as NSIndexPath, cardio: object!)
            }
        }else {
           
            let object = self.workOutsArr?.workouts?[indexPath.row]
            if object?.workoutStatus != WOStatus.notCompleted {
               self.woViewDelegate?.workOutSelected(indexPath:indexPath as NSIndexPath,exercises:(self.workOutsArr?.workouts?[indexPath.row])! )
            }
        }
        return true //You may need to return false if the action is cancelled
    }
    func messageAction(action: UIContextualAction, sourceView: UIView,indexPath: IndexPath) -> Bool {
           //Do somethiing for "Added" button.
           //...
         print("message Actions")
  
        if indexPath.row != self.cardioIndex {
                    let object = self.workOutsArr?.workouts?[indexPath.row]
             self.woViewDelegate?.workOutMessageSelected(indexPath:indexPath as NSIndexPath, workOut: (self.workOutsArr?.workouts?[indexPath.row])! ,commentType: .workoutMsg)
//                   if  object?.workoutComments?.count ?? 0 > 0 || object?.workoutStatus == WOStatus.notCompleted {
//                    self.woViewDelegate?.workOutMessageSelected(indexPath:indexPath as NSIndexPath, workOut: (self.workOutsArr?.workouts?[indexPath.row])! ,commentType: .workoutMsg)
//                   }else {
//                   }
               }else {
                if self.checkIfCardioExist() {
                    let object = self.workOutsArr?.cardio
                     self.woViewDelegate?.cardioMessageSelected(indexPath: indexPath as NSIndexPath, cardio: object!,commentType: .cardioMsg)
                }
               }
        
           return true //You may need to return false if the action is cancelled
       }


}
