//
//  CommentsViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 03/06/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
enum CommentsType{
    case workoutDelete
    case exercisesDelete
    case cardioDelete
    case workoutMsg
    case exercisesMsg
    case cardioMsg
}
class CommentsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var txtPost: UITextField!
    @IBOutlet weak var postBtn: UIButton!
    var commentType : CommentsType?
    var selectedExId : Int?
     var navigationView = NavigationView()
    var comments: Comments?
    var commentsArr: [Comments]?
     var xBarHeight :CGFloat  = 0.0
    var exerciseStatus: String = ""
    var cardioStatus: String = ""
     var workOutStatus: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        let navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight))
        navigationView.titleLbl.text = "Comments"
        navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        navigationView.saveBtn.isHidden = true
        navigationView.saveBtn .addTarget(self, action: #selector(saveBtnTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(navigationView)
        self.navigationController?.isNavigationBarHidden = true
        self.bgView.layer.borderColor = AppColours.appGreen.cgColor
        self.bgView.layer.borderWidth = 1.0
        self.bgView.layer.cornerRadius = 20
//       tableView.estimatedRowHeight = 44.0
//        tableView.rowHeight = UITableView.automaticDimension
        self.tableView.isHidden = false
        let nib = UINib(nibName: "CardStyleTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cardCell")
        tableView.tableFooterView = UIView()
        
    }
    @objc func backBtnTapped(sender : UIButton){
        self.dismiss(animated: true, completion: {
        })
    }
    @objc func saveBtnTapped(sender : UIButton){
        self.dismiss(animated: true, completion: {
        })
    }
    @IBAction func postBtnUpdated(_ sender: Any) {
        if self.txtPost.text?.count ?? 0 > 0 {
            self.updateCommentsAPICall()
        }else {
            self.presentAlertWithTitle(title: "", message: "Please enter comments to post", options: "OK") { (_) in
                
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
        let count = self.commentsArr?.count ?? 0
        if count > 0 {
            let comment = self.commentsArr?[count - 1]
           // self.txtPost.text = comment?.comment!
        }
        
    }
   // MARK: - API Call
    func updateCommentsAPICall() {
        
        let newComment = PostComments(commentDate: Date.getDateInFormat(format: "yyyy-MM-dd", date: ProgramDetails.programDetails.selectedWODate), comment: self.txtPost.text)
        let newComment1 = Comments(commentId: "", commentDate: Date.getDateInFormat(format: "yyyy-MM-dd", date: ProgramDetails.programDetails.selectedWODate), comment: self.txtPost.text)
//        if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.programId) {
//            ProgramDetails.programDetails.programId = id
//        }
        if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
            ProgramDetails.programDetails.subId = id
        }
        if let id = UserDefaults.standard.string(forKey: ProgramDetails.programDetails.subId) {
            ProgramDetails.programDetails.programId = id
        }
        switch self.commentType {
        case .workoutMsg:
            self.postWOComment(comment: newComment1,postComment: newComment)
        case .exercisesMsg:
            self.postExerComment(comment:newComment1,postComment: newComment)
        case .cardioMsg:
            self.postCardioComment(comment:newComment1,postComment: newComment)
            case .cardioDelete:
            self.postCardioComment(comment:newComment1,postComment: newComment)
        case .exercisesDelete:
            self.postExerComment(comment:newComment1,postComment: newComment)
        default:
            self.postWOComment(comment: newComment1,postComment: newComment)
        }
        
    }
    func postWOComment(comment: Comments, postComment: PostComments) {
       var status = WOStatus.notCompleted
              if self.commentType! == .workoutMsg {
                  status = exerciseStatus
              }
        let woComments = WOCommentsUpdatePostBody(program_id: ProgramDetails.programDetails.programId, workoutId: ProgramDetails.programDetails.workoutId, date:  Date.getDateInFormat(format: "dd/MM/yyyy", date: ProgramDetails.programDetails.selectedWODate), trainee_id: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, workoutComment: postComment,workoutStatus: status)
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(woComments)
        WOUpdateCalls.setsUpdatePost(parameters: [:], header: [:], dataParams: jsonData, successHandler:
            { [weak self] dayWorks in
               DispatchQueue.main.async {
                if dayWorks.workouts == nil && dayWorks.cardio == nil {
                    var message = "No data available for the selected date"
                    if messageString.count > 0 {
                        message = messageString
                    }
                    self?.presentAlertWithTitle(title: "", message: message, options: "OK") { (option) in
                               }
                }else {
                    NotificationCenter.default.post(name:NSNotification.Name(rawValue: WorkOutsUpdatedNotification), object: dayWorks)
                                   self?.commentsArr?.append(comment)
                    self?.txtPost.text = ""
                                   self?.tableView.reloadData()
                    self?.dismiss(animated: true, completion: {
                    })
                }
                }
            }, errorHandler: {  error in
                print(" error \(error)")
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                }
        })
    }
    func postExerComment(comment: Comments, postComment: PostComments){
        
        var status = WOStatus.notCompleted
        if self.commentType! == .exercisesMsg {
            status = exerciseStatus
        }
       
        let exComments = ExercisesCommentsUpdatePostBody(program_id: ProgramDetails.programDetails.programId, workoutId: ProgramDetails.programDetails.workoutId, date:  Date.getDateInFormat(format: "dd/MM/yyyy", date: ProgramDetails.programDetails.selectedWODate), trainee_id: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, exerciseComment: postComment, exercise_referenceId: ProgramDetails.programDetails.exerciseRefId,exerciseStatus: status)
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(exComments)
        WOUpdateCalls.setsUpdatePost(parameters: [:], header: [:], dataParams: jsonData, successHandler:
            { [weak self] dayWorks in
                DispatchQueue.main.async {
                if dayWorks.workouts == nil && dayWorks.cardio == nil {
                    var message = "No data available for the selected date"
                    if messageString.count > 0 {
                        message = messageString
                    }
                    self?.presentAlertWithTitle(title: "", message: message, options: "OK") { (option) in
                               }
                }else {
                    NotificationCenter.default.post(name:NSNotification.Name(rawValue: WorkOutsUpdatedNotification), object: dayWorks)
                                   self?.commentsArr?.append(comment)
                    self?.txtPost.text = ""
                                   self?.tableView.reloadData()
                    self?.dismiss(animated: true, completion: {
                    })
                }
                }
            }, errorHandler: {  error in
                print(" error \(error)")
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                }
        })
    }
    func postCardioComment(comment: Comments, postComment: PostComments) {
       var status = WOStatus.notCompleted
                    if self.commentType! == .cardioMsg {
                        status = cardioStatus
                    }
        let woComments = CardioCommentsUpdatePostBody(program_id:  ProgramDetails.programDetails.programId, date:  Date.getDateInFormat(format: "dd/MM/yyyy", date: ProgramDetails.programDetails.selectedWODate), trainee_id: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, cardioComment: postComment,cardioStatus: status)
          let jsonEncoder = JSONEncoder()
          let jsonData = try! jsonEncoder.encode(woComments)
          WOUpdateCalls.setsUpdatePost(parameters: [:], header: [:], dataParams: jsonData, successHandler:
              { [weak self] dayWorks in
                  DispatchQueue.main.async {
                  if dayWorks.workouts == nil && dayWorks.cardio == nil {
                      var message = "No data available for the selected date"
                      if messageString.count > 0 {
                          message = messageString
                      }
                      self?.presentAlertWithTitle(title: "", message: message, options: "OK") { (option) in
                                 }
                  }else {
                      NotificationCenter.default.post(name:NSNotification.Name(rawValue: WorkOutsUpdatedNotification), object: dayWorks)
                                     self?.commentsArr?.append(comment)
                    self?.txtPost.text = ""
                                     self?.tableView.reloadData()
                    self?.dismiss(animated: true, completion: {
                    })
                  }
                  }
          }, errorHandler: {  error in
              print(" error \(error)")
              DispatchQueue.main.async {
                  LoadingOverlay.shared.hideOverlayView()
              }
          })
    }
}
extension CommentsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {

 func numberOfSections(in tableView: UITableView) -> Int {
     return 1
 }
 
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
    }
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return commentsArr?.count ?? 0
 }
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

     let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! CardStyleTableViewCell
    let comment = self.commentsArr?[indexPath.row]
    cell.headerLbl.text = comment?.comment!
    cell.imgView?.isHidden = true
    cell.layoutIfNeeded()
     return cell
 }
 
 
 func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
     return 0;
 }
}
