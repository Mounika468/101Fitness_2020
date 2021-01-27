//
//  CalenderViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 24/04/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import FSCalendar
import CropViewController
import Alamofire
enum CalenderEvents {
    case workout
    case diet
    case call
    case progressPhoto
}
var isFromHomediet : Bool = false
class CalenderViewController: UIViewController {

    @IBOutlet weak var woSubscribeBtn: UIButton!
    @IBOutlet weak var callsNoDataLbl: UILabel!
    @IBOutlet weak var makeCallBtn: UIButton!
    @IBOutlet weak var durationValLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var startTimeValLbl: UILabel!
    @IBOutlet weak var statTimeLbl: UILabel!
    @IBOutlet weak var callHeaderLbl: UILabel!
    @IBOutlet weak var callImgView: UIImageView!
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var progressPhotoView: ProgressPhotoView!
    @IBOutlet weak var dietViewTbleHeight: NSLayoutConstraint!
    @IBOutlet weak var dietView: DietViewL!
    // @IBOutlet weak var dietView: DietView!
    @IBOutlet weak var stackPConstrain: NSLayoutConstraint!
    @IBOutlet weak var stackSconstrain: NSLayoutConstraint!
    @IBOutlet weak var progressBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var dietBtn: UIButton!
    @IBOutlet weak var workOutBtn: UIButton!
    @IBOutlet weak var calender: FSCalendar!
    @IBOutlet weak var workOutView: WorkOutView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var subscribeBtn: UIButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var calenderBtn: UIButton!
    var totalWOArr : DayWorkOuts?
    var slectedDate: Date = Date()
    var calenderSelectionEvent : CalenderEvents = .workout
    var headersImages : Array = ["gdumbel","gdiet","gcall","gcamera"]
     var selctedHeadersImages : Array = ["dumbel","diet","call","camera"]
     var programId = ""
    var xBarHeight :CGFloat  = 0.0
    var subscribeBtnMessage = "Please Sign up to get a free access"
  //  dietSelection: DietSelection, foodItems:FoodItems, quantity: Int
    var dietSelection : DietSelection = .breakFast
    var foodItem : NutritionixFoodItems?
    var quantity: Double = 0.0
    var dietTime : String = ""
    var isTimeUpdateCall : Bool = false
    var callScheduleData : SlotsData?
    var programDaysColour : CalendarDayColours?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgView.backgroundColor = AppColours.popBgColour

        // Do any additional setup after loading the view.
        self.layoutViews()
        callHeaderLbl.textColor = AppColours.textGreen
        statTimeLbl.textColor = AppColours.graphYello
        durationLbl.textColor = AppColours.graphYello
        callImgView.clipsToBounds = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        self.xBarHeight = (navigationController?.navigationBar.frame.maxY)!
        self.navigationController?.isNavigationBarHidden = true
        
        if isFromHomediet == true {
            self.calenderSelectionEvent = .diet
        }
           
//        }else {
//            self.calenderSelectionEvent = .workout
//        }
        self.refreshView(calenderEvent: self.calenderSelectionEvent)
        isFromHomediet = false
        if self.tabBarController?.tabBar.isHidden == true {
            self.tabBarController?.tabBar.isHidden = false
        }
        self.getCalendarColourStatus()
    }
    func layoutViews()
    {
        
        let userdefaults = UserDefaults.standard
        if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin) {
            if  savedValue == UserDefaultsKeys.guestLogin {
                self.bgView.isHidden = false
                self.workOutView.isHidden = true
              //  self.dietView.isHidden = true
                self.view.bringSubviewToFront(self.bgView)
                self.workOutBtn.isEnabled = true
                self.dietBtn.isEnabled = true
                self.progressBtn.isEnabled = true
                self.callBtn.isEnabled = true
            }else {
                self.bgView.isHidden = true
                self.workOutView.isHidden = false
                self.refreshView(calenderEvent: .workout)
                self.workOutBtn.isEnabled = true
                self.dietBtn.isEnabled = true
                self.progressBtn.isEnabled = true
                self.callBtn.isEnabled = true
            }
        }
        
        self.bgView.backgroundColor = AppColours.popBgColour
        self.bgView.layer.cornerRadius = 10
        self.bgView.layer.borderColor = AppColours.popBgColour.cgColor
        self.bgView.layer.borderWidth = 1.0
        self.subscribeBtn.layer.cornerRadius = 10
        self.subscribeBtn.layer.borderColor = AppColours.appGreen.cgColor
        self.subscribeBtn.layer.borderWidth = 1.0
        self.createBtn.layer.cornerRadius = 10
        self.createBtn.layer.borderColor = AppColours.appGreen.cgColor
        self.createBtn.layer.borderWidth = 1.0
        self.headerLbl.textColor = AppColours.textGreen
        self.woSubscribeBtn.layer.cornerRadius = 10
        self.woSubscribeBtn.layer.borderColor = AppColours.appGreen.cgColor
        self.woSubscribeBtn.layer.borderWidth = 1.0
       
        
        self.calenderBtn.layer.cornerRadius = 10
               self.calenderBtn.layer.borderColor = UIColor.lightGray.cgColor
               self.calenderBtn.layer.borderWidth = 0.5
        calender.isHidden = true
        stackPConstrain.isActive = false
        stackSconstrain.isActive = true
        stackPConstrain.priority = UILayoutPriority(rawValue: 999)
        stackSconstrain.priority = UILayoutPriority(rawValue: 1000)
        

        let dateString = self.dateSelected(date: Date())
        self.calenderBtn.setTitle(dateString, for: .normal)
        self.calenderBtn.setTitleColor(AppColours.appGreen, for: .normal)
        if self.workOutView.woViewDelegate == nil {
            self.workOutView.woViewDelegate = self
        }
//        if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.programId) {
//             ProgramDetails.programDetails.programId = id
//         }
        if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                               ProgramDetails.programDetails.subId = id
                           }
        if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
            ProgramDetails.programDetails.programId = id
        }
         if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.programStartdate) {
             ProgramDetails.programDetails.programStartDate = id
         }
        NotificationCenter.default.addObserver(self, selector: #selector(refreshWorkouts), name: NSNotification.Name(rawValue: WorkOutsUpdatedNotification), object: nil)
        if self.dietView.dietviewDelegate == nil {
                  self.dietView.dietviewDelegate = self
              }
        if self.progressPhotoView.progressPhotoDelegate == nil {
           self.progressPhotoView.progressPhotoDelegate = self
        }
        
    }
    
   @objc func refreshWorkouts(notification: Notification) {
       guard let woObject = notification.object as? DayWorkOuts else {
           return
       }
       
       ProgramDetails.programDetails.dayWorkOut = woObject
      self.workOutView.workOutsArr =  ProgramDetails.programDetails.dayWorkOut
      self.workOutView.loadWorkOuts()
       
   }
    @IBAction func progressBtntapped(_ sender: Any) {
        self.refreshView(calenderEvent: .progressPhoto)
    }
    @IBAction func callBtntapped(_ sender: Any) {
        self.refreshView(calenderEvent: .call)
    }
    @IBAction func dietBtntapped(_ sender: Any) {
        self.refreshView(calenderEvent: .diet)
    }
    @IBAction func workOutBtntapped(_ sender: Any) {
        self.refreshView(calenderEvent: .workout)
    }
    
    @IBAction func createBtntapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "CustomAlertVC", bundle: nil)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "CAVC") as! CustomAlertViewController
        alertVC.customAlertDelegate = self
        alertVC.message = "Please Sign up to access the free meal plan"
        alertVC.modalPresentationStyle = .custom
        present(alertVC, animated: false, completion: nil)
    }
  
    func presentAlertForGuest(message:String) {
        let storyboard = UIStoryboard(name: "CustomAlertVC", bundle: nil)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "CAVC") as! CustomAlertViewController
        alertVC.customAlertDelegate = self
        alertVC.message = message
        alertVC.modalPresentationStyle = .custom
        present(alertVC, animated: false, completion: nil)
    }
    @IBAction func subscribeBtnTapped(_ sender: Any) {
        self.presentAlertForGuest(message: subscribeBtnMessage)
    }
  
  
    @IBAction func calenderBtnTapped(_ sender: Any) {
        if calenderBtn.isSelected {
            calender.isHidden = true
            calenderBtn.isSelected = false

            if #available(iOS 13.0, *) {
                stackPConstrain.isActive = false
                stackSconstrain.isActive = true
                stackPConstrain.priority = UILayoutPriority(rawValue: 999)
                stackSconstrain.priority = UILayoutPriority(rawValue: 1000)
            } else {
                // Fallback on earlier versions
                stackPConstrain.isActive = false
                stackSconstrain.isActive = true
                
            }
        }else {
            calender.isHidden = false
            calenderBtn.isSelected = true
            
            if #available(iOS 13.0, *) {
                stackSconstrain.isActive = false
                stackPConstrain.isActive = true
                stackPConstrain.priority = UILayoutPriority(rawValue: 1000)
                stackSconstrain.priority = UILayoutPriority(rawValue: 999)
            } else {
                // Fallback on earlier versions
                stackSconstrain.isActive = false
                stackPConstrain.isActive = true
            }
        }
    }
    func changeViews(calenderEvent : CalenderEvents) {
        switch calenderEvent {
        case .workout:
            self.dietViewDisplay(isActive: false)
            self.callViewDisplay(isActive: false)
            self.workoutViewDisplay(isActive: true)
            self.progressPhotoViewDisplay(isActive: false)
            self.calenderSelectionEvent = .workout
            self.calender.reloadData()
            
        case .diet:
            self.dietViewDisplay(isActive: true)
            self.callViewDisplay(isActive: false)
            self.workoutViewDisplay(isActive: false)
            self.progressPhotoViewDisplay(isActive: false)
            self.calenderSelectionEvent = .diet
            self.calender.reloadData()
            
        case .call:
            self.dietViewDisplay(isActive: false)
            self.callViewDisplay(isActive: true)
            self.workoutViewDisplay(isActive: false)
            self.progressPhotoViewDisplay(isActive: false)
            self.calenderSelectionEvent = .call
            
        case .progressPhoto:
            self.dietViewDisplay(isActive: false)
            self.callViewDisplay(isActive: false)
            self.workoutViewDisplay(isActive: false)
            self.progressPhotoViewDisplay(isActive: true)
            self.calenderSelectionEvent = .progressPhoto
            
        default:
            self.dietViewDisplay(isActive: false)
            self.callViewDisplay(isActive: false)
            self.workoutViewDisplay(isActive: true)
            self.progressPhotoViewDisplay(isActive: false)
            self.calenderSelectionEvent = .workout
            
        }
    }
    func refreshView(calenderEvent : CalenderEvents) {
        self.calenderSelectionEvent = calenderEvent
        if let savedValue = UserDefaults.standard.string(forKey: UserDefaultsKeys.guestLogin) {
            if  savedValue == UserDefaultsKeys.guestLogin {
                self.bgView.isHidden = false
                self.progressPhotoView.isHidden = true
                switch calenderEvent {
                case .workout:
                    self.headerLbl.text = "To Get Workout plan Please Subscribe"
                    self.guestDietViewDisplay(isActive: false)
                    self.guestCallViewDisplay(isActive: false)
                    self.guestProgressPhotoViewDisplay(isActive: false)
                    self.guestWorkoutViewDisplay(isActive: true)

                case .diet:
                    self.headerLbl.text = "To Get Diet Plan"
                    self.guestWorkoutViewDisplay(isActive: false)
                    self.guestCallViewDisplay(isActive: false)
                    self.guestProgressPhotoViewDisplay(isActive: false)
                    self.guestDietViewDisplay(isActive: true)

                case .call:
                    self.headerLbl.text = "To Access Calls"
                    self.guestDietViewDisplay(isActive: false)
                    self.guestWorkoutViewDisplay(isActive: false)
                    self.guestProgressPhotoViewDisplay(isActive: false)
                    self.guestCallViewDisplay(isActive: true)
                case .progressPhoto:
                    self.headerLbl.text = "To Access Progress Photos"
                    self.guestDietViewDisplay(isActive: false)
                    self.guestWorkoutViewDisplay(isActive: false)
                    self.guestCallViewDisplay(isActive: false)
                    self.guestProgressPhotoViewDisplay(isActive: true)
                default:
                    self.headerLbl.text = "To Get Diet Plan"
                }
               
            }else {
                self.bgView.isHidden = true
                self.changeViews(calenderEvent: calenderEvent)
            }
        }else  {
            self.bgView.isHidden = false
            self.changeViews(calenderEvent: calenderEvent)
        }

    }
    @IBAction func makeCallBtnTapped(_ sender: Any) {
        
        self.getRoomStatus(slotId: self.callScheduleData!.slotId!, schedulerId: "")
    }
    
    //MARK -- Button image changes
    func workoutViewDisplay(isActive: Bool) {
       
        if !isActive {
            self.workOutBtn.setImage(UIImage(named: "gdumbel"), for: .normal)
            self.workOutView.isHidden = true
        }
        else
        {
            self.workOutBtn.setImage(UIImage(named: "dumbel"), for: .normal)
                self.workOutView.isHidden = false
                self.getWorkouts(date: self.slectedDate)
                self.bgView.isHidden = true
        }
    }
    func guestWorkoutViewDisplay(isActive: Bool) {
        self.workOutView.isHidden = true
        
        if !isActive {
            self.workOutBtn.setImage(UIImage(named: "gdumbel"), for: .normal)
            self.woSubscribeBtn.isHidden = true
            self.subscribeBtn.isHidden = false
            self.createBtn.isHidden = false
        }
        else
        {
            self.workOutBtn.setImage(UIImage(named: "dumbel"), for: .normal)
            self.woSubscribeBtn.isHidden = false
            self.subscribeBtn.isHidden = true
            self.createBtn.isHidden = true
            subscribeBtnMessage = "Please Sign up to get a free access"
        }
    }
    func dietViewDisplay(isActive: Bool) {
        if !isActive {
            self.dietBtn.setImage(UIImage(named: "gdiet"), for: .normal)
            self.dietView.isHidden = true
        }
        else
        {
             // self.getTrainerPublicVideos()
         //   self.videosView.isHidden = false
            self.dietBtn.setImage(UIImage(named: "diet"), for: .normal)
                self.getDietPlan(date: self.slectedDate)
                self.dietView.isHidden = false
                self.bgView.isHidden = true
        }
    }
    func guestDietViewDisplay(isActive: Bool) {
        self.dietView.isHidden = true
//        self.woSubscribeBtn.isHidden = true
//        self.subscribeBtn.isHidden = false
//        self.createBtn.isHidden = false
        if !isActive {
            self.dietBtn.setImage(UIImage(named: "gdiet"), for: .normal)
        }
        else
        {
             // self.getTrainerPublicVideos()
         //   self.videosView.isHidden = false
            subscribeBtnMessage = "Please Sign up to get a free access"
            self.dietBtn.setImage(UIImage(named: "diet"), for: .normal)
        }
    }
    func guestCallViewDisplay(isActive: Bool) {
        self.callView.isHidden = true

        if !isActive {
            self.callBtn.setImage(UIImage(named: "gcall"), for: .normal)
            self.woSubscribeBtn.isHidden = true
            self.subscribeBtn.isHidden = false
            self.createBtn.isHidden = false
        }
        else
        {
             // self.getTrainerPublicVideos()
         //   self.videosView.isHidden = false
            self.woSubscribeBtn.isHidden = false
            self.subscribeBtn.isHidden = true
            self.createBtn.isHidden = true
            subscribeBtnMessage = "Please Sign up to access the 1o1 call features"
          //  self.presentAlertForGuest(message: "Please Sign up to access the 1o1 call features")
            self.callBtn.setImage(UIImage(named: "call"), for: .normal)
        }
    }
    func callViewDisplay(isActive: Bool) {
        if !isActive {
            self.callBtn.setImage(UIImage(named: "gcall"), for: .normal)
            self.callView.isHidden = true
            // self.displayCallView(hidden: true)
        }
        else
        {
               
                self.getCallDetailsForDate(date:self.slectedDate, successHandler:  { (scheduleArr) in
                    
                    DispatchQueue.main.async {
                        self.callView.isHidden = false
                        LoadingOverlay.shared.hideOverlayView()
                        if scheduleArr?.count ?? 0 > 0 {
                            self.callScheduleData = scheduleArr![0]
                            self.setUpCallView(schedules: scheduleArr![0])
                              self.displayCallView(hidden: false)
                        }else {
                            self.displayCallView(hidden: true)
                            self.callsNoDataLbl.text = messageString
                        }
                    }
                }) { (message) in
                    DispatchQueue.main.async {
                        self.callView.isHidden = false
                         LoadingOverlay.shared.hideOverlayView()
                        self.displayCallView(hidden: true)
                                               self.callsNoDataLbl.text = messageString
                    }
                    
                }
            self.callBtn.setImage(UIImage(named: "call"), for: .normal)
        }
    }
    func getRoomStatus(slotId:String,schedulerId:String) {
        
          let window = UIApplication.shared.windows.first!
          DispatchQueue.main.async {
              LoadingOverlay.shared.showOverlay(view: window)
          }
          let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
          var authenticatedHeaders: [String: String] {
              [
                  HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                  HeadersKeys.contentType: HeaderValues.json
              ]
          }
          if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                       ProgramDetails.programDetails.subId = id
                                   }
                if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
                    ProgramDetails.programDetails.programId = id
                }
         
        GetCallInfoByDateAPI.checkRoomStatus(header: authenticatedHeaders, slotId: slotId, schedulerId: schedulerId, traineeid: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, successHandler:{ [weak self] token in

            if (token != nil) {
                 DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                    self?.tabBarController?.tabBar.isHidden = true
                let storyboard = UIStoryboard(name: "TwilioCallViewController", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "TwilioCallViewController") as! TwilioCallViewController
                    vc.accessToken = (token?.token!)!
                    vc.roomName = token?.roomName ?? ""
                      // let nav = UINavigationController.init(rootViewController: vc)
                      // self?.present(nav, animated: true, completion: nil)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }else {
                  DispatchQueue.main.async {
                      LoadingOverlay.shared.hideOverlayView()
                      self?.presentAlertWithTitle(title: "", message: messageString, options: "OK") {_ in
                      }
                  }
              }
              
          }) { [weak self] error in
              print(" error \(error)")
              DispatchQueue.main.async {
                  LoadingOverlay.shared.hideOverlayView()
                self?.presentAlertWithTitle(title: "", message: error.localizedDescription, options: "OK") {_ in
                }
              }
          }
    
      }
      func fetchTokenForTwilio(roomName:String) {
          let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
                 var authenticatedHeaders: [String: String] {
                     [
                         HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                         HeadersKeys.contentType: HeaderValues.json
                     ]
                 }
                 if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                              ProgramDetails.programDetails.subId = id
                                          }
                       if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
                           ProgramDetails.programDetails.programId = id
                       }
          GetCallInfoByDateAPI.getTokenForCall(header: authenticatedHeaders, roomName: roomName, traineeid: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, successHandler: { [weak self] token in
              print("\(token)")
             // self?.dietView.diet = diet
              if (token != nil) {
                   DispatchQueue.main.async {
                      LoadingOverlay.shared.hideOverlayView()
                  let storyboard = UIStoryboard(name: "TwilioCallViewController", bundle: nil)
                  let vc = storyboard.instantiateViewController(withIdentifier: "TwilioCallViewController") as! TwilioCallViewController
                      vc.accessToken = (token?.token!)!
                     vc.roomName = token?.roomName ?? ""
                      vc.roomName = roomName
                         let nav = UINavigationController.init(rootViewController: vc)
                         self?.present(nav, animated: true, completion: nil)
                  }
              }
              DispatchQueue.main.async {
                 // self?.dietView.reloadDietView()
                  LoadingOverlay.shared.hideOverlayView()
              }
          }) { [weak self] error in
              print(" error \(error)")
              DispatchQueue.main.async {
                  LoadingOverlay.shared.hideOverlayView()

              }
          }
      }
    func guestProgressPhotoViewDisplay(isActive: Bool) {
        self.progressPhotoView.isHidden = true

        if !isActive {
            self.progressBtn.setImage(UIImage(named: "gcamera"), for: .normal)
            self.woSubscribeBtn.isHidden = true
            self.subscribeBtn.isHidden = false
            self.createBtn.isHidden = false
        }
        else
        {
            subscribeBtnMessage = "Please Sign up to access progress photos"
            self.progressBtn.setImage(UIImage(named: "camera"), for: .normal)
           // self.presentAlertForGuest(message: "Please Sign up to access progress photos")
            self.woSubscribeBtn.isHidden = false
            self.subscribeBtn.isHidden = true
            self.createBtn.isHidden = true
        }
    }
    func progressPhotoViewDisplay(isActive: Bool) {
        if !isActive {
            self.progressBtn.setImage(UIImage(named: "gcamera"), for: .normal)
            self.progressPhotoView.isHidden = true
        }
        else
        {
          //  self.getTrainerPackages()
            self.progressBtn.setImage(UIImage(named: "camera"), for: .normal)
                self.progressPhotoView.isHidden = false
                self.getAllPhotosForTheUserByDate(successHandler: { (progressPhotos) in
                    DispatchQueue.main.async {
                        LoadingOverlay.shared.hideOverlayView()
                        self.progressPhotoView.photosArr = progressPhotos
                        self.progressPhotoView.refreshViews()
                    }
                }) { (error) in
                    DispatchQueue.main.async {
                         LoadingOverlay.shared.hideOverlayView()
                       self.progressPhotoView.photosArr = nil
                                    self.progressPhotoView.refreshViews()
                        self.presentAlertWithTitle(title: "", message: error, options: "OK") { _ in
                            
                        }
                    }
                }

        }
    }
    func displayCallView(hidden:Bool) {
       //No Calls scheduled on selected date.
        self.callHeaderLbl.isHidden = hidden
        self.statTimeLbl.isHidden = hidden
        self.startTimeValLbl.isHidden = hidden
        self.durationLbl.isHidden = hidden
        self.durationValLbl.isHidden = hidden
        self.makeCallBtn.isHidden = hidden
        self.callImgView.isHidden = hidden
        self.callsNoDataLbl.isHidden = !hidden
        self.callsNoDataLbl.text = messageString
        let order = Calendar.current.compare(Date(), to: self.slectedDate, toGranularity: .day)
        if order == .orderedDescending && hidden == false {
            self.makeCallBtn.isHidden = true
        }else {
            self.makeCallBtn.isHidden = hidden
        }
        
    }
    func setUpCallView(schedules:SlotsData){
        let imageURl = schedules.profileImage?.profileImagePath
        if imageURl != nil && imageURl?.count ?? 0 > 0 {
            self.callImgView.sd_setImage(with: URL(string:imageURl!)!, placeholderImage: UIImage(named: "chest"))
        }
        self.callHeaderLbl.text = schedules.firstName ?? ""
        let time = (schedules.startTime ?? "") + "-" + (schedules.endTime ?? "")
        self.startTimeValLbl.text = time
        self.durationValLbl.text = schedules.frequency?.name ?? ""
    
        
    }
    func timeComparisionToEnableJoinButton(schedules:SlotsData) {
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//
//            NSDate *startDate = [formatter dateFromString:@"2012-12-07 7:17:58"];
//            NSDate *endDate = [formatter dateFromString:@"2012-12-07 7:17:59"];
//
//
//            if ([startDate compare: endDate] == NSOrderedDescending) {
//                NSLog(@"startDate is later than endDate");
//
//            } else if ([startDate compare:endDate] == NSOrderedAscending) {
//                NSLog(@"startDate is earlier than endDate");
//
//            } else {
//                NSLog(@"dates are the same");
//
//            }
//
//            // Way 2
//            NSTimeInterval timeDifference = [endDate timeIntervalSinceDate:startDate];
//
//            double minutes = timeDifference / 60;
//            double hours = minutes / 60;
//            double seconds = timeDifference;
//            double days = minutes / 1440;
        
        if schedules != nil {
            let formatter = DateFormatter.init()
            formatter.dateFormat = "HH:mm"
            let currentTimedate = formatter.string(from: Date())
            let startTime = formatter.date(from: schedules.startTime!)! as Date
            let endTime = formatter.date(from: schedules.endTime!)! as Date
            let currentTime = formatter.date(from:currentTimedate)! as Date
            let timeInterval = currentTime.timeIntervalSince(startTime)
            print("time difference \(timeInterval)")
        }
        
        

    }
    func getCallDetailsForDate(date:Date,successHandler: @escaping ([SlotsData]?) -> Void,
    errorHandler: @escaping (String) -> Void) {
        let window = UIApplication.shared.windows.first!
        DispatchQueue.main.async {
            LoadingOverlay.shared.showOverlay(view: window)
        }
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                     ProgramDetails.programDetails.subId = id
                                 }
              if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
                  ProgramDetails.programDetails.programId = id
              }
        let timeZone = TimeZone.current.identifier
        let postBody : [String: Any] = ["date": Date.getDateInFormat(format: "yyyy-MM-dd", date: date),"timezone":timeZone]
                let urlString = getCallsByDate + "\(UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!)"
                guard let url = URL(string: urlString) else {return}
                var request        = URLRequest(url: url)
                request.httpMethod = "Post"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("\(HeaderValues.token) \(token!) ", forHTTPHeaderField: "Authorization")
                do {
                    request.httpBody   = try JSONSerialization.data(withJSONObject: postBody)
                } catch let error {
                    print("Error : \(error.localizedDescription)")
                }
        Alamofire.request(request).responseJSON{ (response) in
            print("response is \(response)")
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    if let json = response.result.value as? [String: Any] {
                        print("JSON: \(json)") // serialized json response
                        do {
                            if json["code"] as? Int != 40
                            {
                                if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                    if jsonDict is NSNull {
                                        
                                        if let jsonMessage = json[ResponseKeys.message.rawValue] {

                                            messageString = (jsonMessage as? String)!
                                        }
                                        errorHandler(messageString)
                                        
                                    }else {
                                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                  options: .prettyPrinted)
                                       let schedulesArr = try JSONDecoder().decode([SlotsData]?.self, from: jsonData)
                                        
                                       successHandler(schedulesArr)

                                    }
                                   
                                } else {
                                    errorHandler("Fetching the Schedules failed")

                                    
                                }
                            }else {
                                if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                    messageString = (jsonMessage as? String)!
                                     
                                        errorHandler(messageString)
//
                                }
                               // self.schedulesArr = nil
                            } }catch let error {
                                
//                                    self.presentAlertWithTitle(title: "", message: "Fetching the Schedules failed", options: "OK") {_ in
//                                    }
                                    errorHandler("Fetching the Schedules failed")
                        }
                    }
                    
                default:
                    DispatchQueue.main.async {
                  
                    }
                }
            }
        }
      
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
    //MARK: Get Days Status
    func getCalendarColourStatus() {
        let window = UIApplication.shared.windows.first!
        DispatchQueue.main.async {
            LoadingOverlay.shared.showOverlay(view: window)
        }
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        GetCalenderByDateAPI.getCalendarDayColours(header: authenticatedHeaders, trainee_id: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) as! String) { [weak self] daysColours in
            print(" error \(daysColours)")
            DispatchQueue.main.async {
                self?.programDaysColour = daysColours
                if self?.programDaysColour != nil {
                    self?.calender.reloadData()
                }
            }
            
        } errorHandler: { [weak self] error in
            print(" error \(error)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
        }

    }
    //   MARK: Get workouts
    func getWorkouts(date:Date) {
        let window = UIApplication.shared.windows.first!
        DispatchQueue.main.async {
            LoadingOverlay.shared.showOverlay(view: window)
        }
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                     ProgramDetails.programDetails.subId = id
                                 }
              if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
                  ProgramDetails.programDetails.programId = id
              }
         self.programId = ProgramDetails.programDetails.programId
      //  self.programId = (UserDefaults.standard.value(forKey: UserDefaultsKeys.programId) as? String) ?? ""
        GetCalenderByDateAPI.post(traineeId: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) as! String, programId: self.programId, header: authenticatedHeaders, date: Date.getDateInFormat(format: "dd/MM/yyyy", date: date), successHandler: { [weak self] dayWorks in
            print("day workouts \(dayWorks)")
            ProgramDetails.programDetails.dayWorkOut = dayWorks
            self?.workOutView.workOutsArr = dayWorks
            DispatchQueue.main.async {
                 self?.workOutView.loadWorkOuts()
                LoadingOverlay.shared.hideOverlayView()
                
                if (dayWorks.workouts == nil && dayWorks.cardio == nil) || dayWorks.rest == true {
                    ProgramDetails.programDetails.dayWorkOut = nil
                                  self?.workOutView.workOutsArr = nil
                                  self?.workOutView.loadWorkOuts()
                    if dayWorks.rest == true {
                        self?.workOutView.displayRestView(message:messageString)
                        
                    }else {
                        var message = "No data available for the selected date"
                        if messageString.count > 0 {
                            message = messageString
                        }
                        self?.workOutView.displayNoWorkouts(message:message)
                    }
                    
                }
            }
        }) { [weak self] error in
            print(" error \(error)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                ProgramDetails.programDetails.dayWorkOut = nil
                self?.workOutView.workOutsArr = nil
                self?.workOutView.loadWorkOuts()
                self?.workOutView.displayNoWorkouts(message: error.localizedDescription)
//                self?.presentAlertWithTitle(title: "", message: "Please wait for 24 hours, your program calendar generation in-progress", options: "OK") { (option) in
//
//                }
            }
        }
    }
    func getAllPhotosForTheUserByDate(successHandler: @escaping ([ProgressPhoto]?) -> Void,
    errorHandler: @escaping (String) -> Void)  {
        let window = UIApplication.shared.windows.first!
        DispatchQueue.main.async {
            LoadingOverlay.shared.showOverlay(view: window)
        }
           let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
                  var authenticatedHeaders: [String: String] {
                      [
                          HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                          HeadersKeys.contentType: HeaderValues.json
                      ]
                  }
                  if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                               ProgramDetails.programDetails.subId = id
                                           }
       
                  let postBody : [String: Any] = ["date": Date.getDateInFormat(format: "yyyy-MM-dd", date:  self.slectedDate),"trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!]
                   let urlString = getProgressByDate
                   guard let url = URL(string: urlString) else {return}
                   var request        = URLRequest(url: url)
                   request.httpMethod = "Post"
                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                   request.setValue("\(HeaderValues.token) \(token!) ", forHTTPHeaderField: "Authorization")
                   do {
                       request.httpBody   = try JSONSerialization.data(withJSONObject: postBody)
                   } catch let error {
                       print("Error : \(error.localizedDescription)")
                   }
           //  request.setValue(postBody.capacity, forHTTPHeaderField: "Content-Length")

           Alamofire.request(request).responseJSON{ (response) in
               print("response is \(response)")
               if let status = response.response?.statusCode {
                   switch(status){
                   case 200:
                       if let json = response.result.value as? [String: Any] {
                           print("JSON: \(json)") // serialized json response
                           do {
                               if json["code"] as? Int != 40
                               {
                                   if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                    if jsonDict is NSNull {
                                           
                                        if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                             messageString = (jsonMessage as? String)!
                                             //  self.nodataLbl.text = messageString
                                         }
                                        // self.photosArr = nil
                                         successHandler(nil)
                                           
                                       }else {
                                           let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                     options: .prettyPrinted)
                                           let photosArr = try JSONDecoder().decode([ProgressPhoto]?.self, from: jsonData)
                                           successHandler(photosArr)
                                       }
                                      
                                   } else {
                                       
                                       errorHandler("Fetching the Schedules failed")
                                   }
                               }else {
                                   if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                       messageString = (jsonMessage as? String)!
                                       
                                       errorHandler(messageString)
                                   }
                               } }catch let error {
                                 
                                   errorHandler("Fetching the Schedules failed")
                           }
                       }
                        case 500:
                            errorHandler(response.result.description)
                   default:
                    errorHandler(response.error?.localizedDescription ?? "")

                   }
               }
           }
       }
     //   MARK: Get workouts
        func getDietPlan(date:Date) {
            let window = UIApplication.shared.windows.first!
            DispatchQueue.main.async {
                LoadingOverlay.shared.showOverlay(view: window)
            }
            let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
            var authenticatedHeaders: [String: String] {
                [
                    HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                    HeadersKeys.contentType: HeaderValues.json
                ]
            }
            if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                         ProgramDetails.programDetails.subId = id
                                     }
                  if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
                      ProgramDetails.programDetails.programId = id
                  }
             self.programId = ProgramDetails.programDetails.programId
          //  self.programId = (UserDefaults.standard.value(forKey: UserDefaultsKeys.programId) as? String) ?? ""
            GetDietByDateAPI.post(traineeId: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) as! String, programId: self.programId, header: authenticatedHeaders, date: Date.getDateInFormat(format: "dd/MM/yyyy", date: date), successHandler: { [weak self] diet in
                print("day workouts \(diet)")
                self?.dietView.diet = diet
                DispatchQueue.main.async {
                    self?.dietView.reloadDietView()
                    LoadingOverlay.shared.hideOverlayView()
                    if diet == nil && diet?.mealplan == nil {
                        var message = "No data available for the selected date"
                        if messageString.count > 0 {
                            message = messageString
                        }
                        self?.dietView.diet = nil
                        self?.dietView.reloadDietView()
                        self?.dietView.displayNoDiet(message: message)
                    }
                }
            }) { [weak self] error in
                print(" error \(error)")
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
               
                }
            }
        }
}
//MARK -- Service calls
func getDatesStatus() {
    
}
   extension CalenderViewController: FSCalendarDelegate, FSCalendarDataSource ,FSCalendarDelegateAppearance{

   func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter }()

    let selectedDate   = dateFormatter.string(from: date)
    let dateObj = (dateFormatter.date(from: selectedDate) ?? Date()) as Date

//    if dateObj! > calendar.today! {
//       // Your logic here
//        ProgramDetails.programDetails.dayWorkOut = nil
//        self.workOutView.workOutsArr = nil
//         self.workOutView.loadWorkOuts()
//        self.presentAlertWithTitle(title: "", message: "Can't access future dates data", options: "OK") { (option) in
//        }
//        return
//    }
    
    self.slectedDate = date
    ProgramDetails.programDetails.selectedWODate = date
       let dateString = self.dateSelected(date: date)
              self.calenderBtn.setTitle(dateString, for: .normal)
    switch self.calenderSelectionEvent {
    case .workout:
         self.getWorkouts(date: date)
        case .diet:
        self.getDietPlan(date: date)
    case .call:
                    self.getCallDetailsForDate(date:self.slectedDate, successHandler:  { (scheduleArr) in
                        
                        DispatchQueue.main.async {
                            LoadingOverlay.shared.hideOverlayView()
                            if scheduleArr?.count ?? 0 > 0 {
                                  self.callScheduleData = scheduleArr![0]
                                self.setUpCallView(schedules: scheduleArr![0])
                                self.displayCallView(hidden: false)
                            }else {
                                self.displayCallView(hidden: true)
                                self.callsNoDataLbl.text = messageString
                            }
                           
        //                    self.progressPhotoView.photosArr = progressPhoto
        //                    self.progressPhotoView.refreshViews()
                        }
                    }) { (message) in
                        DispatchQueue.main.async {
                             LoadingOverlay.shared.hideOverlayView()
                            self.displayCallView(hidden: true)
        //                   self.progressPhotoView.photosArr = nil
        //                                self.progressPhotoView.refreshViews()
                            self.presentAlertWithTitle(title: "", message: message, options: "OK") { _ in
                                
                            }
                        }
                        
                    }
       // self.getCallDetailsForDate(date:date,sc)
    case .progressPhoto :
        self.progressBtn.setImage(UIImage(named: "camera"), for: .normal)
            self.progressPhotoView.isHidden = false
            self.getAllPhotosForTheUserByDate(successHandler: { (progressPhotos) in
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                    self.progressPhotoView.photosArr = progressPhotos
                    self.progressPhotoView.refreshViews()
                }
            }) { (error) in
                DispatchQueue.main.async {
                     LoadingOverlay.shared.hideOverlayView()
                   self.progressPhotoView.photosArr = nil
                                self.progressPhotoView.refreshViews()
                    self.presentAlertWithTitle(title: "", message: error, options: "OK") { _ in
                        
                    }
                }
            }
        
    default:
         self.getWorkouts(date: date)
    }
   
   }
func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
    let gregorian: Calendar = Calendar(identifier: .gregorian)
     var dateFormatter1: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateFormat = "dd/MM/yyyy"
       return formatter
   }()
    
    let dateString : String = dateFormatter1.string(from:date)
        if self.calenderSelectionEvent == .workout {
            let newDays = self.programDaysColour?.calendarDays?.filter{$0.dayStatus == "new"}
            let inprogressDays = self.programDaysColour?.calendarDays?.filter{$0.dayStatus == "inprogress"}
            let completedDays = self.programDaysColour?.calendarDays?.filter{$0.dayStatus == "completed"}
           // let inprogressDays = self.programDaysColour?.calendarDays?.filter{$0.dayStatus == "inprogress"}
            if let index = newDays?.firstIndex(where: {$0.date == dateString}) {
                return .white
            }else if let index = inprogressDays?.firstIndex(where: {$0.date == dateString}) {
                return .orange
            }else if let index = completedDays?.firstIndex(where: {$0.date == dateString}) {
                return .green
            }else {
                return .white
            }
        }else {
            let newDays = self.programDaysColour?.mealplanDays?.filter{$0.dayStatus == "new"}
            let inprogressDays = self.programDaysColour?.mealplanDays?.filter{$0.dayStatus == "inprogress"}
            let completedDays = self.programDaysColour?.mealplanDays?.filter{$0.dayStatus == "completed"}
            if let index = newDays?.firstIndex(where: {$0.date == dateString}) {
                return .white
            }else if let index = inprogressDays?.firstIndex(where: {$0.date == dateString}) {
                return .orange
            }else if let index = completedDays?.firstIndex(where: {$0.date == dateString}) {
                return .green
            }else {
                return .white
            }

        }
  
   }
}
//MARK: Delegate Methods
extension CalenderViewController : workOutViewDelegate {
    func workOutSelected(indexPath: NSIndexPath, exercises: Workouts) {
        ProgramDetails.programDetails.workoutId = exercises.workoutId
        let storyboard = UIStoryboard(name: "WorkOut", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "WOVC") as! WorkOutViewController
        controller.woExercisesArr = exercises
        controller.selectedIndex = indexPath.row
       // controller.totalWOArr = self.totalWOArr
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func cardioSelected(indexPath: NSIndexPath, cardio: Cardio) {
        let storyboard = UIStoryboard(name: "CardioUpdateVC", bundle: nil)
        if let presentedViewController = storyboard.instantiateViewController(withIdentifier: "cardioUpdateVC") as? CardioUpdateVC {
            presentedViewController.xBarHeight = 100
            presentedViewController.cardio = cardio
            presentedViewController.modalPresentationStyle = .custom
            self.present(presentedViewController, animated: true, completion: nil)
        }
    }
    func cardioMessageSelected(indexPath : NSIndexPath, cardio: Cardio,commentType: CommentsType) {
        let storyboard = UIStoryboard(name: "CommentsVC", bundle: nil)
               if let presentedViewController = storyboard.instantiateViewController(withIdentifier: "commentsVC") as? CommentsViewController {
                presentedViewController.commentType = commentType
                   presentedViewController.commentsArr = cardio.cardioComments
                 presentedViewController.cardioStatus = cardio.cardioStatus!
                   presentedViewController.xBarHeight = 100
                   presentedViewController.modalPresentationStyle = .custom
                   self.present(presentedViewController, animated: true, completion: nil)
               }
    }
    func workOutMessageSelected(indexPath : NSIndexPath, workOut: Workouts,commentType: CommentsType){
         let storyboard = UIStoryboard(name: "CommentsVC", bundle: nil)
        ProgramDetails.programDetails.workoutId = workOut.workoutId
        if let presentedViewController = storyboard.instantiateViewController(withIdentifier: "commentsVC") as? CommentsViewController {
            presentedViewController.commentType = commentType
            ProgramDetails.programDetails.workoutId = workOut.workoutId
            presentedViewController.commentsArr = workOut.workoutComments
            presentedViewController.xBarHeight = 100
            presentedViewController.workOutStatus = workOut.workoutStatus!
           // presentedViewController.transitioningDelegate = self
            presentedViewController.modalPresentationStyle = .custom
            self.present(presentedViewController, animated: true, completion: nil)
        }
    }
    func completeWOAPI() {
       
        let woStatus = WOStatusUpdatePostBody(program_id: ProgramDetails.programDetails.programId, workoutId: ProgramDetails.programDetails.workoutId, date: Date.getDateInFormat(format: "dd/MM/yyyy", date: ProgramDetails.programDetails.selectedWODate), trainee_id: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, workoutStatus: WOStatus.complete)
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(woStatus)
        WOUpdateCalls.setsUpdatePost(parameters: [:], header: [:], dataParams: jsonData, successHandler:
            { [weak self] dayWorks in
                 ProgramDetails.programDetails.dayWorkOut = dayWorks
                 DispatchQueue.main.async {
                    self?.workOutView.workOutsArr = dayWorks
                    self?.workOutView.loadWorkOuts()
                }
            }, errorHandler: {  error in
                print(" error \(error)")
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                }
        })
    }
    func completeCardioAPI() {
        
        let cardioStatus = CardioStatusUpdatePostBody(program_id: ProgramDetails.programDetails.programId, date: Date.getDateInFormat(format: "dd/MM/yyyy", date: ProgramDetails.programDetails.selectedWODate), trainee_id: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, cardioStatus: WOStatus.complete)
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(cardioStatus)
        WOUpdateCalls.setsUpdatePost(parameters: [:], header: [:], dataParams: jsonData, successHandler:
            { [weak self] dayWorks in
                 ProgramDetails.programDetails.dayWorkOut = dayWorks
                 DispatchQueue.main.async {
                    self?.workOutView.workOutsArr = dayWorks
                    self?.workOutView.loadWorkOuts()
                }
            }, errorHandler: {  error in
                print(" error \(error)")
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                }
        })
    }
    func completeWorkOut() {
        self.presentAlertWithTitle(title: "", message: "Are you sure want to submit the workout", options: "Cancel","Done") { (option) in
            if option == 1 {
                self.completeWOAPI()
            }
        }
    }
    func completeCardio() {
        self.presentAlertWithTitle(title: "", message: "Are you sure want to submit the Cardio", options: "Cancel","Done") { (option) in
            if option == 1 {
                self.completeCardioAPI()
            }
        }
    }
}
extension CalenderViewController:DietSelectionDelegate {
   
    
    func setParentViewHeight(height: CGFloat) {
         DispatchQueue.main.async {
            self.dietViewTbleHeight.constant = height
        }
    }
    
  
    
    func addFoodSelected(dietSelected: DietSelection) {
        let storyboard = UIStoryboard(name: "FoodDetailsVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FoodSearchVC") as! FoodSearchVC
        controller.xBarHeight = self.xBarHeight
        switch dietSelected {
        case .breakFast:
            controller.mealType = "breakfast"
            case .lunch:
            controller.mealType = "lunch"
            case .snack1:
            controller.mealType = "snacks"
            case .dinner:
            controller.mealType = "dinner"
        default:
            controller.mealType = "breakfast"
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func selectedDietOption() {
        
    }
    func completeFoodItem(index:Int, dietSelection: DietSelection, foodItems:NutritionixFoodItems, quantity: Double) {
        if self.isTimeUpdateCall {
//            var foodQty: Double = 0
//            if foodItems.foodStatus == WOStatus.complete {
//                foodQty = Double(foodItems.serving_qty?.consumed ?? 0.0)
//            }else {
//                foodQty = Double(foodItems.serving_qty?.recommended ?? 0.0)
//            }
            let consumedFood = ConsumedFoodItems(refId: foodItems.refId ?? 0, consumedQuantity:0.0, consumedTime: self.dietTime, foodStatus: foodItems.foodStatus ?? "")
        var mealType = "breakfast"
        switch dietSelection {
        case .breakFast:
            mealType = "breakfast"
            case .lunch:
                       mealType = "lunch"
            case .dinner:
            mealType = "dinner"
            case .snack1:
                      mealType = "snacks"
        default:
            mealType = "breakfast"
        }
        let postbody = MealUpdatePostBoday(program_id: ProgramDetails.programDetails.programId, date: Date.getDateInFormat(format: "dd/MM/yyyy", date: ProgramDetails.programDetails.selectedWODate), trainee_id: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, mealType: mealType, consumedFoodItems: [consumedFood])
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(postbody)
        
        GetDietByDateAPI.updateMealPlanAPI(parameters: [:], header: [:], dataParams: jsonData, methodName: "put", successHandler: { [weak self] (diet) in
            print("diet is \(diet)")
            self?.dietView.diet = diet
                            DispatchQueue.main.async {
                               self?.dietView.reloadDietView()
                               LoadingOverlay.shared.hideOverlayView()
                               if diet == nil && diet?.mealplan == nil {
                                   var message = "No data available for the selected date"
                                   if messageString.count > 0 {
                                       message = messageString
                                   }
                                   self?.dietView.diet = nil
                                   self?.dietView.reloadDietView()
                                   self?.dietView.displayNoDiet(message: message)
                               }
                              self?.isTimeUpdateCall = false
                           }
        }, errorHandler: {  error in
                print(" error \(error)")
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                }
        })
        }else {
            
            
            let consumedFood = ConsumedFoodItems(refId: foodItems.refId ?? 0, consumedQuantity: quantity, consumedTime: foodItems.consumedTime ?? foodItems.time ?? "", foodStatus: WOStatus.complete)
        var mealType = "breakfast"
        switch dietSelection {
        case .breakFast:
            mealType = "breakfast"
            case .lunch:
                       mealType = "lunch"
            case .dinner:
            mealType = "dinner"
            case .snack1:
                      mealType = "snacks"
        default:
            mealType = "breakfast"
        }
        let postbody = MealUpdatePostBoday(program_id: ProgramDetails.programDetails.programId, date: Date.getDateInFormat(format: "dd/MM/yyyy", date: ProgramDetails.programDetails.selectedWODate), trainee_id: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, mealType: mealType, consumedFoodItems: [consumedFood])
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(postbody)
        
        GetDietByDateAPI.updateMealPlanAPI(parameters: [:], header: [:], dataParams: jsonData, methodName: "put", successHandler: { [weak self] (diet) in
            print("diet is \(diet)")
            self?.dietView.diet = diet
                            DispatchQueue.main.async {
                               self?.dietView.reloadDietView()
                               LoadingOverlay.shared.hideOverlayView()
                               if diet == nil && diet?.mealplan == nil {
                                   var message = "No data available for the selected date"
                                   if messageString.count > 0 {
                                       message = messageString
                                   }
                                   self?.dietView.diet = nil
                                   self?.dietView.reloadDietView()
                                   self?.dietView.displayNoDiet(message: message)
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
    func deleteFoodItem(dietSelection: DietSelection, foodItems: NutritionixFoodItems) {
        var mealType = "breakfast"
               switch dietSelection {
               case .breakFast:
                   mealType = "breakfast"
                   case .lunch:
                              mealType = "lunch"
                   case .dinner:
                   mealType = "dinner"
                   case .snack1:
                             mealType = "snacks"
               default:
                   mealType = "breakfast"
               }
//        let postBody = DeleteFoodItems(program_id: ProgramDetails.programDetails.programId, date: Date.getDateInFormat(format: "dd/MM/yyyy", date: ProgramDetails.programDetails.selectedWODate), trainee_id: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!)
        
//        let jsonEncoder = JSONEncoder()
//        let jsonData = try! jsonEncoder.encode(postBody)
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        
        GetDietByDateAPI.deleteMealPlanAPI(header: authenticatedHeaders, mealType: mealType, foodRefId: foodItems.refId ?? 0, successHandler: { [weak self] (diet) in
            print("diet is \(diet)")
            self?.dietView.diet = diet
                            DispatchQueue.main.async {
                               self?.dietView.reloadDietView()
                               LoadingOverlay.shared.hideOverlayView()
                               if diet == nil && diet?.mealplan == nil {
                                   var message = "No data available for the selected date"
                                   if messageString.count > 0 {
                                       message = messageString
                                   }
                                   self?.dietView.diet = nil
                                   self?.dietView.reloadDietView()
                                   self?.dietView.displayNoDiet(message: message)
                               }
            
                           }
        }, errorHandler: {  error in
                print(" error \(error)")
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                }
        })
    }
    func foodDetailsSelected(foodItems:NutritionixFoodItems,dietSelection: DietSelection) {
        
        let storyboard = UIStoryboard(name: "FoodDetailsVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FoodDetailsVC") as! FoodDetailsVC
        controller.xBarHeight = self.xBarHeight
        controller.foodItems = foodItems
        controller.isFromSearch = false
        var mealType = "breakfast"
               switch dietSelection {
               case .breakFast:
                   mealType = "breakfast"
                   case .lunch:
                              mealType = "lunch"
                   case .dinner:
                   mealType = "dinner"
                   case .snack1:
                             mealType = "snacks"
               default:
                   mealType = "breakfast"
               }
        controller.mealType = mealType
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func timePickerSelected(index:Int, dietSelection: DietSelection, foodItems:NutritionixFoodItems, quantity:Double) {
        self.dietSelection = dietSelection
        self.foodItem = foodItems
        self.quantity = quantity

        let storyboard = UIStoryboard(name: "TimePickerVC", bundle: nil)
                      let controller = storyboard.instantiateViewController(withIdentifier: "TimePickerVC") as! TimePickerVC
                        controller.modalPresentationStyle = .custom
        controller.timePickerDelegate = self
                         controller.transitioningDelegate = self
                             self.present(controller, animated: true, completion: nil)
    }
}

extension CalenderViewController: TimePickerDelegate {
    func timeSelected(time:String) {
        self.dietTime = time
        self.isTimeUpdateCall = true
        completeFoodItem(index: 0, dietSelection: self.dietSelection, foodItems: self.foodItem!, quantity: Double(self.quantity))
    }
}
extension CalenderViewController: PhotosBottomVCDelegate,CropViewControllerDelegate, ProgressPhotoViewDelegate {
    func viewPhotoTapped(photo: ProgressPhoto) {
        let storyboard = UIStoryboard(name: "PhotoDeleteVC", bundle: nil)
                       let controller = storyboard.instantiateViewController(withIdentifier: "PhotoDeleteVC") as! PhotoDeleteVC
                       controller.modalPresentationStyle = .custom
        controller.deletePhotoDelegate = self
        controller.photos = photo
        self.present(controller, animated: true, completion: nil)
    }
    
    func deletePhotoTapped(photo: ProgressPhoto) {
        
        
         self.presentAlertWithTitle(title: "Delete", message: "Do you want to delete the image", options: "OK","Cancel") { (option) in
            if option == 0 {
                self.deletePhotoCall(photoId: photo.photoId ?? "", successHandler: { (progressPhoto) in
                          
                          DispatchQueue.main.async {
                              LoadingOverlay.shared.hideOverlayView()
                              self.progressPhotoView.photosArr = progressPhoto
                              self.progressPhotoView.refreshViews()
                          }
                      }) { (message) in
                          DispatchQueue.main.async {
                               LoadingOverlay.shared.hideOverlayView()
                             self.progressPhotoView.photosArr = nil
                                          self.progressPhotoView.refreshViews()
                              self.presentAlertWithTitle(title: "", message: message, options: "OK") { _ in
                                  
                              }
                          }
                          
                      }
            }}
        
      
    }
    func deletePhotoCall(photoId:String, successHandler: @escaping ([ProgressPhoto]?) -> Void,
       errorHandler: @escaping (String) -> Void) {
          
           let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
           var authenticatedHeaders: [String: String] {
               [
                   HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                   HeadersKeys.contentType: HeaderValues.json
               ]
           }
           if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                        ProgramDetails.programDetails.subId = id
                                    }
                
           
        let postBody : [String: Any] = ["date": Date.getDateInFormat(format: "yyyy-MM-dd", date: Date()),"isCalendar":true,"photoId":photoId]
                   let urlString = deletePhoto + UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)! + "/progressphotos"
                   guard let url = URL(string: urlString) else {return}
                   var request        = URLRequest(url: url)
                   request.httpMethod = "Post"
                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                   request.setValue("\(HeaderValues.token) \(token!) ", forHTTPHeaderField: "Authorization")
                   do {
                       request.httpBody   = try JSONSerialization.data(withJSONObject: postBody)
                   } catch let error {
                       print("Error : \(error.localizedDescription)")
                   }
           //  request.setValue(postBody.capacity, forHTTPHeaderField: "Content-Length")

           Alamofire.request(request).responseJSON{ (response) in
               print("response is \(response)")
               if let status = response.response?.statusCode {
                   switch(status){
                   case 200:
                       if let json = response.result.value as? [String: Any] {
                           print("JSON: \(json)") // serialized json response
                           do {
                               if json["code"] as? Int != 40
                               {
                                if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                    if jsonDict is NSNull {
                                        
                                        if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                            messageString = (jsonMessage as? String)!
                                        }
                                        successHandler(nil)
                                        
                                    }else {
                                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                  options: .prettyPrinted)
                                        let photosArr = try JSONDecoder().decode([ProgressPhoto]?.self, from: jsonData)
                                        successHandler(photosArr)
                                    }
                                    
                                } else {
                                       
                                       errorHandler("Fetching the Schedules failed")
                                   }
                               }else {
                                   if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                       messageString = (jsonMessage as? String)!
                                      
                                       errorHandler(messageString)
                                   }
                               } }catch let error {
                                  
                                   errorHandler("Fetching the Schedules failed")
                           }
                       }
                       
                   default:
                       DispatchQueue.main.async {
                           LoadingOverlay.shared.hideOverlayView()
                           self.presentAlertWithTitle(title: "", message: "Fetching the Schedules failed", options: "OK") {_ in
                           }
                       }
                   }
               }
           }
         
       }
    
    func addPhotoBtnTapped() {
        let storyboard = UIStoryboard(name: "PhotosBottomVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PhotosBottomVC") as! PhotosBottomVC
        controller.modalPresentationStyle = .custom
        controller.photoPickerDelegate = self
        controller.transitioningDelegate = self
        self.present(controller, animated: true, completion: nil)
    }
    func imageSelected(image:UIImage) {
       // self.dietTime = time
        DispatchQueue.main.async {
           self.presentCropViewController(image: image)
        }
       
    }
     func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
          //    self.profilePicImageView.image = image
        self.uploadPhotoForTrainer(image: image, successHandler: { (progressPhoto) in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                self.progressPhotoView.photosArr = progressPhoto
                self.progressPhotoView.refreshViews()
                cropViewController.dismiss(animated: true, completion: nil)
            }
        }) { (error) in
            DispatchQueue.main.async {
                 LoadingOverlay.shared.hideOverlayView()
               self.progressPhotoView.photosArr = nil
                            self.progressPhotoView.refreshViews()
                cropViewController.dismiss(animated: true, completion: nil)
                self.presentAlertWithTitle(title: "", message: error, options: "OK") { _ in
                    
                }
            }
        }
//              Progress.shared.showProgressView()
//              ProfileUpdateAPI.init().updateProfileImage(img: image) { (msg, issucces) in
//                  cropViewController.dismiss(animated: true, completion: nil)
//                  self.myPickerController.dismiss(animated: true, completion: nil)
//                  Progress.shared.hideProgressView()
//                  var mesg = ""
//                  if issucces{
//                      mesg = "Profile Image Successfully Updated"
//                  }else{
//                      mesg = "Profile Image Successfully Updated"
//                  }
//                  Utility.topViewController()?.view.makeToast(mesg)
//              }
              
          }
          func uploadPhotoForTrainer(image:UIImage, successHandler: @escaping ([ProgressPhoto]?) -> Void,
             errorHandler: @escaping (String) -> Void) {
                
                 let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
                 var authenticatedHeaders: [String: String] {
                     [
                         HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                         HeadersKeys.contentType: HeaderValues.json
                     ]
                 }
                 if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                              ProgramDetails.programDetails.subId = id
                                          }
                       if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
                           ProgramDetails.programDetails.programId = id
                       }
                  let imageName = "iOS" + "\(Date())"
                 let postBody : [String: Any] = ["date": Date.getDateInFormat(format: "yyyy-MM-dd", date: self.slectedDate),"trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"name":imageName,"imgcode":image.toString() as Any,"file_type":"jpg","isCalendar":true]
                         let urlString = savePhoto
                         guard let url = URL(string: urlString) else {return}
                         var request        = URLRequest(url: url)
                         request.httpMethod = "Post"
                         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                         request.setValue("\(HeaderValues.token) \(token!) ", forHTTPHeaderField: "Authorization")
                         do {
                             request.httpBody   = try JSONSerialization.data(withJSONObject: postBody)
                         } catch let error {
                             print("Error : \(error.localizedDescription)")
                         }
                 //  request.setValue(postBody.capacity, forHTTPHeaderField: "Content-Length")

                 Alamofire.request(request).responseJSON{ (response) in
                     print("response is \(response)")
                     if let status = response.response?.statusCode {
                         switch(status){
                         case 200:
                             if let json = response.result.value as? [String: Any] {
                                 print("JSON: \(json)") // serialized json response
                                 do {
                                     if json["code"] as? Int != 40
                                     {
                                        if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                            if jsonDict is NSNull {
                                                
                                                if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                                    messageString = (jsonMessage as? String)!
                                                }
                                                successHandler(nil)
                                                
                                            }else {
                                                let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                          options: .prettyPrinted)
                                                let photosArr = try JSONDecoder().decode([ProgressPhoto]?.self, from: jsonData)
                                                successHandler(photosArr)
                                            }
                                            
                                        } else {
                                             
                                             errorHandler("Uploading the photo is failed")
                                         }
                                     }else {
                                         if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                             messageString = (jsonMessage as? String)!
                                             
                                             errorHandler(messageString)
                                         }
                                        
                                     } }catch let error {
                                      
                                         errorHandler("Uploading the photo is failed")
                                 }
                             }
                             
                         default:
                             DispatchQueue.main.async {
                               //  LoadingOverlay.shared.hideOverlayView()
                                  errorHandler("Uploading the photo is failed as image is too big")
                             }
                         }
                     }
                 }
               
             }
          func presentCropViewController(image :UIImage) {
            let cropViewController = CropViewController(image: image)
              cropViewController.delegate = self
              self.present(cropViewController, animated: true, completion: nil)
          }
}
extension CalenderViewController :UIViewControllerTransitioningDelegate{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController:presented, presenting: presenting)
    }
}

extension CalenderViewController : DeletePhotoDelegate {
    func reloadPhotos() {
       // self.getAllPhotosForTheUser()
        self.getAllPhotosForTheUserByDate(successHandler: { (progressPhotos) in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                self.progressPhotoView.photosArr = progressPhotos
                self.progressPhotoView.refreshViews()
            }
        }) { (error) in
            DispatchQueue.main.async {
                 LoadingOverlay.shared.hideOverlayView()
               self.progressPhotoView.photosArr = nil
                            self.progressPhotoView.refreshViews()
                self.presentAlertWithTitle(title: "", message: error, options: "OK") { _ in
                    
                }
            }
        }
    }
}
extension CalenderViewController: CustomAlertViewDelegate {
    func okBtnTapped() {
    
    }
    
    
    func singUpBtnTapped() {
       // self.navigateToProfile()
        self.tabBarController?.tabBar.isHidden = true
        let registration = SignUpViewController(nibName:"SignUpViewController", bundle:nil)
        self.navigationController?.pushViewController(registration, animated: true)
    }
}
