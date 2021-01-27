//
//  WorkOutViewController.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 27/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import SDWebImage

class WorkOutViewController: UIViewController {

    @IBOutlet weak var workOutTblView: UITableView!
    var selectedWorkOutName : String?
    var navigationView = NavigationView()
    var restIndex : Int = 0
    var week : Int = 0
    var workoutday : Int = 0
    var xBarHeight :CGFloat  = 0.0
    var woExercisesArr : Workouts?
    var commentType: CommentsType?
     var selectedIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        xBarHeight = (navigationController?.navigationBar.frame.maxY)!
         navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight))
                     // navigationView.titleLbl.text = "Biceps"
               navigationView.backgroundColor = AppColours.topBarGreen
                      navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
                      self.view.addSubview(navigationView)
               self.navigationController?.isNavigationBarHidden = true
        
        let nib = UINib(nibName: "WorkOutTypeTableViewCell", bundle: nil)
        self.workOutTblView.register(nib, forCellReuseIdentifier: "WOTypeCell")
        let nibRest = UINib(nibName: "RestTableViewCell", bundle: nil)
               self.workOutTblView.register(nibRest, forCellReuseIdentifier: "RestCell")
         workOutTblView.tableFooterView = UIView()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshWorkouts), name: NSNotification.Name(rawValue: WorkOutsUpdatedNotification), object: nil)
        workOutTblView.separatorColor = UIColor.clear
    }
    @objc func refreshWorkouts(notification: Notification) {
        guard let woObject = notification.object as? DayWorkOuts else {
            return
        }
        
        ProgramDetails.programDetails.dayWorkOut = woObject
        self.replaceWorkoutExercises()
        
    }
    override func viewDidAppear(_ _animated: Bool)
       {
          // self.getWorkOutInfo()
        if let name = self.woExercisesArr?.workoutName?.name {
        self.navigationView.titleLbl.text = name
        }
           
       }
    override func viewWillAppear(_ animated: Bool) {
          self.replaceWorkoutExercises()
    }
   
    @objc func backBtnTapped(sender : UIButton){
     self.navigationController?.popViewController(animated: true)
    }

}
extension WorkOutViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 120
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return self.workOutList?.workoutExercises?.count ?? 0
        return self.woExercisesArr?.workoutExercises?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exercises = self.woExercisesArr?.workoutExercises![indexPath.row]
        let name = exercises?.exerciseName.uppercased()
        switch name!.lowercased() {
             case "rest":
                 guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestCell")
                     as? RestTableViewCell
                     else {
                         return UITableViewCell()
                 }
                 self.restIndex = indexPath.row
                 cell.selectionStyle = .none
                 cell.restVal.text = " \(String(describing: exercises?.restPeriodVal!))"
//                 if let restPeriodVal = exercises?[indexPath.row].restPeriodVal.map(String.init) {
//                     cell.restVal.text =  restPeriodVal + "SEC"
//                 }
                 return cell
             default:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "WOTypeCell")
                                         as? WorkOutTypeTableViewCell
                        else {
                            return UITableViewCell()
                            
                    }
                    if exercises?.exerciseStatus == WOStatus.complete{
                        cell.editBtn.isHidden = false
                        cell.editBtn.setImage(UIImage(named: "ccomplete"), for: .normal)
                    }else {
                        cell.editBtn.isHidden = false
                        cell.editBtn.setImage(UIImage(named: "arrow"), for: .normal)
                    }
                    cell.startBtn.isHidden = true
                    cell.selectionStyle = .none
                    cell.workOutNameLbl.text = name
                    // cell.perWOLbl.text = (exercises?.exercisePercentage)! + "% Completed"
                     cell.perWOLbl.text = ""
                    cell.startBtn.tag = indexPath.row
                    cell.startBtn.addTarget(self, action: #selector(startBtnTapped(sender:)), for: .touchUpInside)
                    if  let videoThumNail = exercises?.exerciseVideo?.videoThumbnailPath {
                        cell.workOutImgView.loadImage(url: URL(string: videoThumNail)!)
                    }
                 return cell
             }
    }
    @objc func startBtnTapped(sender : UIButton){
        let indexPath = NSIndexPath(row:sender.tag, section: 0)
         let storyboard = UIStoryboard(name: "WODetailVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "WODetailVC") as! WODetailVC
        controller.woExercise = self.woExercisesArr?.workoutExercises![indexPath.row]
        controller.sections =  [
            Section(name: "Instructions", items: [
                Item(detail: (self.woExercisesArr?.workoutExercises![indexPath.row].instructions)!)
            ]),
            Section(name: "WorkOut Update", items: [
                Item(detail: "iPad Pro delivers epic power, in 12.9-inch and a new 10.5-inch size.")
            ])
        ]
        self.navigationController?.pushViewController(controller, animated: true)

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         let exercises = self.woExercisesArr?.workoutExercises![indexPath.row]
        let name = exercises?.exerciseName.uppercased()
              
        switch name!.lowercased(){
        case "rest":
            return
        default:
            var exercises = self.woExercisesArr?.workoutExercises![indexPath.row]
//            if exercises?.exerciseStatus == WOStatus.complete || exercises?.exerciseStatus == "Completed"{
//                exercises = nil
//                return
//            }
            let storyboard = UIStoryboard(name: "WODetailVC", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "WODetailVC") as! WODetailVC
            controller.woExercise = self.woExercisesArr?.workoutExercises![indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let exercises = self.woExercisesArr?.workoutExercises![indexPath.row]
       let name = exercises?.exerciseName.uppercased()
        switch name!.lowercased() {
        case "rest":
                   let config = UISwipeActionsConfiguration(actions: [])
                   config.performsFirstActionWithFullSwipe = false
                    return config
               default:
                    var exercises = self.woExercisesArr?.workoutExercises![indexPath.row]
                    if exercises?.exercisePercentage ==  "100" || exercises?.exerciseStatus == WOStatus.complete {
                        let config = UISwipeActionsConfiguration(actions: [])
                        config.performsFirstActionWithFullSwipe = false
                         exercises = nil
                         return config
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
                    if exercises?.exerciseStatus ==  WOStatus.notCompleted {
                        edit.image = UIImage(named: "gedit")
                    }else {
                       edit.image = UIImage(named: "edit")
                    }
                    edit.backgroundColor =  UIColor.black
                     let delete = UIContextualAction(style: .normal, title: "") {
                         action, sourceView, completionHandler in
                         let actionPerformed = self.deleteAction(action: action, sourceView: sourceView, indexPath: indexPath)
                         completionHandler(actionPerformed)
                     }
                    if  exercises?.exerciseStatus == WOStatus.notCompleted {
                         delete.image = UIImage(named: "rdelete")
                    }else {
                         delete.image = UIImage(named: "gdelete")
                    }
                   
                   delete.backgroundColor =  UIColor.black
        
        let message = UIContextualAction(style: .normal, title: "") {
                                      action, sourceView, completionHandler in
                                      let actionPerformed = self.messageAction(action: action, sourceView: sourceView, indexPath: indexPath)
                                      completionHandler(actionPerformed)
                                  }
                  //  if exercises?.exerciseComments?.count ?? 0 > 0 || exercises?.exerciseStatus == WOStatus.notCompleted {
                         message.image = UIImage(named: "message")
//                    }else {
//                         message.image = UIImage(named: "gmessage")
//                    }
                               
                                message.backgroundColor =  UIColor.black
                     let config = UISwipeActionsConfiguration(actions: [message,delete,edit,complete])
                     config.performsFirstActionWithFullSwipe = false
               let cell:UITableViewCell = (tableView.cellForRow(at: IndexPath(row: indexPath.row, section: 0)))!
               cell.backgroundColor = UIColor.black
               //action.backgroundColor = UIColor.green
                     return config
        }
      }
    
      func completeAction(action: UIContextualAction, sourceView: UIView,indexPath: IndexPath) -> Bool {
        
        var exercises = self.woExercisesArr?.workoutExercises![indexPath.row]
        if exercises?.exerciseStatus != WOStatus.notCompleted {
             self.presentAlertWithTitle(title: "", message: "Are you sure want to submit the workout", options: "Cancel","Done") { (option) in
                 if option == 1 {
                     self.completeExerciseAPI(indexPath: indexPath)
                 }
             }
        }
        exercises = nil

       print("Complete Actions")
        
          return true //You may need to return false if the action is cancelled
      }
        
      func deleteAction(action: UIContextualAction, sourceView: UIView,indexPath: IndexPath) -> Bool {
          //Do somethiing for "Added" button.
          //...
        print("delete Actions")
         self.commentType = .exercisesDelete
         self.updateComments(indexPath: indexPath)
          return true //You may need to return false if the action is cancelled
      }
    func editAction(action: UIContextualAction, sourceView: UIView,indexPath: IndexPath) -> Bool {
        //Do somethiing for "Added" button.
        //...
      print("editAction Actions")
        var exercises = self.woExercisesArr?.workoutExercises![indexPath.row]
        if exercises?.exerciseStatus != WOStatus.notCompleted {
             self.updateWorkOut(indexPath: indexPath)
        }
        exercises = nil
        return true //You may need to return false if the action is cancelled
    }
    func messageAction(action: UIContextualAction, sourceView: UIView,indexPath: IndexPath) -> Bool {
           //Do somethiing for "Added" button.
           //...
         print("message Actions")
        let exercises = self.woExercisesArr?.workoutExercises![indexPath.row]
//        if exercises?.exerciseComments?.count ?? 0 > 0 || exercises?.exerciseStatus == WOStatus.notCompleted {
//            self.commentType = .exercisesMsg
//             self.updateComments(indexPath: indexPath)
//        }else {
//
//        }
        self.commentType = .exercisesMsg
                    self.updateComments(indexPath: indexPath)
           return true //You may need to return false if the action is cancelled
       }
    func checkIfRestExists()->Bool {
        for exercises in (self.woExercisesArr?.workoutExercises)! {
            let name = exercises.exerciseName
            if name == "rest" {
                return true
            }
        }
        return false
    }
    func completeExerciseAPI(indexPath: IndexPath)  {
    
        var percentage = ""
         var totalCount = (self.woExercisesArr?.workoutExercises!.count)! - 1
        if checkIfRestExists() == true {
            totalCount = totalCount - 1
        }
        if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                               ProgramDetails.programDetails.subId = id
                           }
         if let id = UserDefaults.standard.string(forKey: ProgramDetails.programDetails.subId) {
             ProgramDetails.programDetails.programId = id
         }

        var workoutStatus = WOStatus.inProgress
                for exercises in (self.woExercisesArr?.workoutExercises)! {
                    let status = exercises.exerciseStatus
                    if status == WOStatus.complete {
                        totalCount = totalCount - 1
                    }
                }
        if totalCount > 0 {
              percentage = "\(100/totalCount)"
        }
        if percentage == "100" {
            workoutStatus = WOStatus.complete
        }
      //Date.getCurrentDateInFormat(format: "dd/MM/yyyy")
         let exercises = self.woExercisesArr?.workoutExercises![indexPath.row]
        let exStatus = ExerciseStatusUpdatePostBody(program_id: ProgramDetails.programDetails.programId, workoutId: ProgramDetails.programDetails.workoutId, date: Date.getDateInFormat(format: "dd/MM/yyyy", date: ProgramDetails.programDetails.selectedWODate), trainee_id: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, exerciseStatus: WOStatus.complete,exercise_referenceId: (exercises?.referenceId)!)
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(exStatus)
        WOUpdateCalls.setsUpdatePost(parameters: [:], header: [:], dataParams: jsonData, successHandler:
            { [weak self] dayWorks in
                ProgramDetails.programDetails.dayWorkOut = dayWorks
                 DispatchQueue.main.async {
                NotificationCenter.default.post(name:NSNotification.Name(rawValue: WorkOutsUpdatedNotification), object: dayWorks)
                self?.viewWillAppear(true)
                }
            }, errorHandler: {  error in
                print(" error \(error)")
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                }
        })
    }
    func replaceWorkoutExercises(){
        
        self.woExercisesArr = ProgramDetails.programDetails.dayWorkOut?.workouts?[self.selectedIndex]
        self.workOutTblView.reloadData()
    }
    func updateWorkOut(indexPath: IndexPath) {
         let storyboard = UIStoryboard(name: "WOUpdateVC", bundle: nil)
        if let presentedViewController = storyboard.instantiateViewController(withIdentifier: "WOUpdate") as? WOUpdateViewController {
             let exercises = self.woExercisesArr?.workoutExercises![indexPath.row]
           // ProgramDetails.programDetails.workoutId = self.woExercisesArr!.workoutId
            ProgramDetails.programDetails.workoutId = self.woExercisesArr!.workoutId
            ProgramDetails.programDetails.exerciseRefId = exercises!.referenceId!
            presentedViewController.selectedExPath = indexPath.row
            presentedViewController.xBarHeight = self.xBarHeight
            presentedViewController.setsArr = exercises?.sets
           // presentedViewController.transitioningDelegate = self
            presentedViewController.modalPresentationStyle = .fullScreen
            self.present(presentedViewController, animated: true, completion: nil)
        }
    }
    func updateComments(indexPath: IndexPath) {
             let storyboard = UIStoryboard(name: "CommentsVC", bundle: nil)
            if let presentedViewController = storyboard.instantiateViewController(withIdentifier: "commentsVC") as? CommentsViewController {
                 let exercises = self.woExercisesArr?.workoutExercises![indexPath.row]
                presentedViewController.commentType = self.commentType!
                presentedViewController.exerciseStatus = exercises!.exerciseStatus!
                ProgramDetails.programDetails.workoutId = self.woExercisesArr!.workoutId
                ProgramDetails.programDetails.exerciseRefId = exercises!.referenceId!
                presentedViewController.commentsArr = exercises?.exerciseComments
                presentedViewController.xBarHeight = self.xBarHeight
                presentedViewController.modalPresentationStyle = .fullScreen
                self.present(presentedViewController, animated: true, completion: nil)
            }
        }
}
    
   
extension WorkOutViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}
class HalfSizePresentationController : UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            guard let theView = containerView else {
                return CGRect.zero
            }
            
            if self.presentedViewController.isKind(of: PhotosBottomVC.self) {
                 return CGRect(x: 0, y: theView.bounds.height*0.7, width: theView.bounds.width, height: theView.bounds.height*0.3)
            }else {
                 return CGRect(x: 0, y: theView.bounds.height*0.5, width: theView.bounds.width, height: theView.bounds.height*0.5)
            }

           
        }
    }
}
