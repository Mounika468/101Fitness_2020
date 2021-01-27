//
//  ProfileViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 25/06/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import Foundation
import AWSMobileClient
import Alamofire
import CropViewController

class ProfileViewController: UIViewController {

    @IBOutlet weak var countryCode2Btn: UIButton!
    @IBOutlet weak var countryCode1Btn: UIButton!
    @IBOutlet weak var phoneBg: UIView!
    @IBOutlet weak var heightBtn: UIButton!
    @IBOutlet weak var weightBtn: UIButton!
    @IBOutlet weak var addProfileBtn: UIButton!
    @IBOutlet weak var profileNtSubmittedLbl: UILabel!

    @IBOutlet weak var medicalNoBtn: UIButton!
    
    @IBOutlet weak var habbitsTxtField: UITextView!{
        didSet {
            habbitsTxtField.text = "List any other addictions or habbits"
            habbitsTxtField.textColor = UIColor.lightGray
        }
    }
    @IBOutlet weak var medicalTxtField: UITextView!{
        didSet {
            medicalTxtField.text = "List any other medical issue(s)"
            medicalTxtField.textColor = UIColor.lightGray
        }
    }
    @IBOutlet weak var foodATxtField: UITextView!{
        didSet {
            foodATxtField.text = "List any food item(s) you're allergic to"
            foodATxtField.textColor = UIColor.lightGray
        }
    }
    @IBOutlet weak var diableTxtField: UITextView! {
        didSet {
            diableTxtField.text = "List any disabilities* you have"
            diableTxtField.textColor = UIColor.lightGray
        }
    }
    @IBOutlet weak var updateBtn: UIButton! 
    @IBOutlet weak var medicalYesBtn: UIButton!
    @IBOutlet weak var gainBtn: UIButton!
    @IBOutlet weak var maintainBtn: UIButton!
    @IBOutlet weak var looseBtn: UIButton!
    @IBOutlet weak var hr1Btn: UIButton!
    
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var hr8Btn: UIButton!
    
    @IBOutlet weak var hr10Btn: UIButton!
    
    @IBOutlet weak var averageBtn: UIButton!
    @IBOutlet weak var badBtn: UIButton!
    
    @IBOutlet weak var goodBtn: UIButton!
    
    @IBOutlet weak var alcoholNoBtn: UIButton!
    @IBOutlet weak var alcoholYesBtn: UIButton!
    @IBOutlet weak var foodPreCV: UICollectionView! {
        didSet {
            foodPreCV.showsVerticalScrollIndicator = false
            foodPreCV.showsHorizontalScrollIndicator = false
        }
    }
    @IBOutlet weak var mealsBtn: UIButton!{
        didSet {
            mealsBtn.layer.cornerRadius = 12
            mealsBtn.layer.borderColor = AppColours.appGreen.cgColor
            mealsBtn.layer.borderWidth = 1
           
        }
    }
    @IBOutlet weak var phoneTxtField: UITextField! {
        didSet {
//            phoneTxtField.layer.cornerRadius = 15
//            phoneTxtField.layer.borderColor = AppColours.appGreen.cgColor
//            phoneTxtField.layer.borderWidth = 1
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            phoneTxtField.leftView = leftView
            phoneTxtField.leftViewMode = .always
        }
    }
    @IBOutlet weak var jainBtn: UIButton!{
        didSet {
            jainBtn.layer.cornerRadius = 15
            jainBtn.layer.borderColor = AppColours.appGreen.cgColor
            jainBtn.layer.borderWidth = 1
           
        }
    }
    @IBOutlet weak var veganBtn: UIButton!{
        didSet {
            veganBtn.layer.cornerRadius = 15
            veganBtn.layer.borderColor = AppColours.appGreen.cgColor
            veganBtn.layer.borderWidth = 1
           
        }
    }
    @IBOutlet weak var eggBtn: UIButton!{
        didSet {
            eggBtn.layer.cornerRadius = 15
            eggBtn.layer.borderColor = AppColours.appGreen.cgColor
            eggBtn.layer.borderWidth = 1
           
        }
    }
    @IBOutlet weak var nonVegBtn: UIButton!{
        didSet {
            nonVegBtn.layer.cornerRadius = 15
            nonVegBtn.layer.borderColor = AppColours.appGreen.cgColor
            nonVegBtn.layer.borderWidth = 1
           
        }
    }
    @IBOutlet weak var vegBtn: UIButton!{
        didSet {
            vegBtn.layer.cornerRadius = 15
            vegBtn.layer.borderColor = AppColours.appGreen.cgColor
            vegBtn.layer.borderWidth = 1
           
        }
    }
    @IBOutlet weak var workOutDaysBtn: UIButton!{
        didSet {
            workOutDaysBtn.layer.cornerRadius = 12
            workOutDaysBtn.layer.borderColor = AppColours.appGreen.cgColor
            workOutDaysBtn.layer.borderWidth = 1
           
        }
    }
    @IBOutlet weak var activityCV: UICollectionView!
    @IBOutlet weak var heightView: UIView!{
        didSet {
            heightView.layer.cornerRadius = 15
            heightView.layer.borderColor = AppColours.appGreen.cgColor
            heightView.layer.borderWidth = 1
           
        }
    }
    @IBOutlet weak var weightView: UIView!{
        didSet {
            weightView.layer.cornerRadius = 15
            weightView.layer.borderColor = AppColours.appGreen.cgColor
            weightView.layer.borderWidth = 1
           
        }
    }
    @IBOutlet weak var emailTxtField: UITextField!{
        didSet {
            emailTxtField.layer.cornerRadius = 15
            emailTxtField.layer.borderColor = AppColours.appGreen.cgColor
            emailTxtField.layer.borderWidth = 1
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            emailTxtField.leftView = leftView
            emailTxtField.leftViewMode = .always
        }
    }
    @IBOutlet weak var phoneBtn: UIButton!{
        didSet {
            phoneBtn.layer.cornerRadius = 15
            phoneBtn.layer.borderColor = AppColours.appGreen.cgColor
            phoneBtn.layer.borderWidth = 1
           
        }
    }
    @IBOutlet weak var heightTxtField: UITextField!
    @IBOutlet weak var ftBtn: UIButton!
    @IBOutlet weak var cmBtn: UIButton!
    @IBOutlet weak var weightTxtField: UITextField!
    @IBOutlet weak var lbBtn: UIButton!
    @IBOutlet weak var kgBtn: UIButton!
    @IBOutlet weak var dob: UIButton!{
        didSet {
            dob.layer.cornerRadius = 15
            dob.layer.borderColor = AppColours.appGreen.cgColor
            dob.layer.borderWidth = 1
           
        }
    }
    @IBOutlet weak var genderImgView: UIImageView!
    @IBOutlet weak var genderimgView: UIImageView!
    @IBOutlet weak var profileimgView: UIImageView!
        {
        didSet {
            self.profileimgView.layer.cornerRadius = 0.5 * profileimgView.bounds.size.width
                   self.profileimgView.clipsToBounds = true
                   self.profileimgView.layer.borderColor = AppColours.appGreen.cgColor
                   self.profileimgView.layer.borderWidth = 1.0
            profileimgView.contentMode = .scaleAspectFill
            profileimgView.clipsToBounds = true
        }
    }
    @IBOutlet weak var fNameTxtField: UITextField! {
        didSet {
            fNameTxtField.layer.cornerRadius = 15
            fNameTxtField.layer.borderColor = AppColours.appGreen.cgColor
            fNameTxtField.layer.borderWidth = 1
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            fNameTxtField.leftView = leftView
            fNameTxtField.leftViewMode = .always
        }
    }
    @IBOutlet weak var lNametxtField: UITextField!{
        didSet {
            lNametxtField.layer.cornerRadius = 15
            lNametxtField.layer.borderColor = AppColours.appGreen.cgColor
            lNametxtField.layer.borderWidth = 1
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            lNametxtField.leftView = leftView
            lNametxtField.leftViewMode = .always
        }
    }
    // @IBOutlet weak var fnameTxtField: CustomTextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
     var meatSelectedArr :[String] = []
    var sleepQuality = ""
       var sleepDuration = ""
    var workOutDesc = ""
    var height : Double = 0.00
    var heightMetric = ""
    var noOfMeals = ""
    var foodType = ""
    var weight : Double = 0.00
    var weightMetric = ""
    var selectedTimeIndex: Int = 0
      var selectedDays = [Int] ()
       var alcoholChoice = ""
    var primaryGoal = ""
          var smokeChoice = ""
       var NoSelected : Bool  = true
     var activityArr : Array = ["gsedentary","glightly","gmoderate","gactive","gextra"]
     var selActivityArr : Array = ["csedentary","clightly","cmoderate","cactive","cextra"]
    var textActivityArr : Array = ["Sedentary","Lightly active","Moderately active","Very active","Extra active"]
    //var activityNames : Array = ["Sedentary","Lightly","Moderate","Active","Extra"]
     var foodTypesArr : Array = ["veg","vegan","non veg","jain","eggetarian"]
    let activityNames : Array = ["Sedentary (little or no exercise)","Lightly active (light exercise/sports 1-3 days/week)","Moderately active (moderate exercise/sports 3-5 days/week)","Very active (hard exercise/sports 6-7 days a week)","Extra active (very hard exercise/sports & a physical job)"]
    var activityLevelIndex = -1
     var foodTypeIndex = -1
    //Picker
   // fileprivate let pickerView = ToolbarPickerView()
    let days : Array = ["sun","mon","tue","wed","thu","fri","sat"]
           let workOutLevel : Array = ["< 30 mins","60 mins","","30 mins","75 mins","> 90 mins","45 mins"," 90 mins"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "MeatCollectionViewCell", bundle: nil)
              self.activityCV.register(nib, forCellWithReuseIdentifier:"meatCV")
        let activityLayout = UICollectionViewFlowLayout()
            activityLayout.scrollDirection = .horizontal
            self.activityCV.collectionViewLayout = activityLayout
        
        let timeNib = UINib(nibName: "SingleSelectionCV", bundle: nil)
        self.foodPreCV.register(timeNib, forCellWithReuseIdentifier:"singleCV")
        let timeFlowLayout = UICollectionViewFlowLayout()
        timeFlowLayout.scrollDirection = .horizontal
        self.foodPreCV.collectionViewLayout = timeFlowLayout
        
        self.alcoholNoBtn.layer.cornerRadius = 10
        self.alcoholNoBtn.layer.borderWidth = 1
        self.alcoholNoBtn.layer.borderColor = AppColours.appGreen.cgColor
        self.alcoholYesBtn.layer.cornerRadius = 10
        self.alcoholYesBtn.layer.borderWidth = 1
        self.alcoholYesBtn.layer.borderColor = AppColours.appGreen.cgColor
        
        self.medicalYesBtn.layer.cornerRadius = 10
        self.medicalYesBtn.layer.borderWidth = 1
        self.medicalYesBtn.layer.borderColor = AppColours.textGreen.cgColor
        self.medicalNoBtn.layer.cornerRadius = 10
        self.medicalNoBtn.layer.borderWidth = 1
        self.medicalNoBtn.layer.borderColor = AppColours.textGreen.cgColor
        
//        self.logOutBtn.layer.cornerRadius = 10
//        self.logOutBtn.layer.borderWidth = 1
//        self.logOutBtn.layer.borderColor = AppColours.textGreen.cgColor
        
    //   self.diableTxtField.attributedPlaceholder = NSAttributedString(string: "List any disabilities* you have",
     //  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.diableTxtField.layer.borderWidth = 0.5
        self.diableTxtField.layer.cornerRadius = 5.0
        self.diableTxtField.layer.borderColor = AppColours.textGreen.cgColor
     //    self.foodATxtField.attributedPlaceholder = NSAttributedString(string: "List any food item(s) you're allergic to",
        //     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.foodATxtField.layer.borderWidth = 0.5
        self.foodATxtField.layer.cornerRadius = 5.0
               self.foodATxtField.layer.borderColor = AppColours.textGreen.cgColor
     //  self.medicalTxtField.attributedPlaceholder = NSAttributedString(string: "List any other medical issue(s)",
     //  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.medicalTxtField.layer.borderWidth = 0.5
        self.medicalTxtField.layer.cornerRadius = 5.0
               self.medicalTxtField.layer.borderColor = AppColours.textGreen.cgColor
      //  self.habbitsTxtField.attributedPlaceholder = NSAttributedString(string: "List any other addictions or habbits",
       // attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.habbitsTxtField.layer.borderWidth = 0.5
        self.habbitsTxtField.layer.cornerRadius = 5.0
        self.habbitsTxtField.layer.borderColor = AppColours.textGreen.cgColor
//      //Pickerview setup
//        self.pickerView.dataSource = self
//        self.pickerView.delegate = self
//        self.pickerView.toolbarDelegate = self
//
//        self.pickerView.reloadAllComponents()
        
         self.hideKeyboardWhenTappedAround()
        self.phoneBg.layer.cornerRadius = 15.0
        self.phoneBg.layer.borderColor = AppColours.textGreen.cgColor
        self.phoneBg.layer.borderWidth = 0.5
       
    }
    
    @IBAction func countryCode1BtnTapped(_ sender: Any) {
        //        if countryCode1Btn.isSelected {
        //            countryCode1Btn.isSelected = false
        //            countryCode2Btn.isHidden = true
        //        }else {
                    countryCode1Btn.isSelected = true
                    countryCode2Btn.isHidden = false
                    if countryCode1Btn.titleLabel?.text ?? "" == "+91"{
                        countryCode2Btn.setTitle("+1", for: .normal)
                    }else {
                        countryCode2Btn.setTitle("+91", for: .normal)
                    }
                //}
                
            }
    @IBAction func countryCode2BtnTapped(_ sender: Any) {
      
                    countryCode2Btn.isSelected = true
                    if countryCode1Btn.titleLabel?.text ?? "" == "+91"{
                        countryCode1Btn.setTitle("+1", for: .normal)
                    }else {
                        countryCode1Btn.setTitle("+91", for: .normal)
                    }
                    countryCode2Btn.isHidden = true
                
            }
    @IBAction func uploadImageTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "PhotosBottomVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PhotosBottomVC") as! PhotosBottomVC
        controller.modalPresentationStyle = .custom
        controller.photoPickerDelegate = self
        controller.transitioningDelegate = self
        self.present(controller, animated: true, completion: nil)
    }
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:sssZ"

        if let date = inputFormatter.date(from: dateString) {

            let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = format

            return outputFormatter.string(from: date)
        }

        return nil
    }
    override func viewWillAppear(_ animated: Bool) {
        self.updateBtn.backgroundColor = AppColours.topBarGreen
        let userdefaults = UserDefaults.standard
        if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin) {
            if  savedValue != UserDefaultsKeys.guestLogin  {
                if TraineeInfo.details.profile_submission == true {
                   self.profileNtSubmittedLbl.isHidden = true
                 self.scrollView.isHidden = false
                    self.updateBtn.isHidden = false
                    self.addProfileBtn.isHidden = true
                      self.setUpView()
                }else {
                    self.profileNtSubmittedLbl.text = "You haven't added your profile"
                 self.profileNtSubmittedLbl.isHidden = false
                 self.scrollView.isHidden = true
                    self.updateBtn.isHidden = true
                     self.addProfileBtn.isHidden = false
                    self.addProfileBtn.isUserInteractionEnabled = true
                }
            }else {
                self.profileNtSubmittedLbl.text = "You haven't added your profile"
                self.profileNtSubmittedLbl.isHidden = false
                self.scrollView.isHidden = true
                self.updateBtn.isHidden = true
                self.addProfileBtn.isHidden = false
            }
            
        }
    }
    func setUpView() {
        let gender = TraineeDetails.traineeDetails?.gender
        switch gender?.lowercased() {
        case "male":
            genderImgView.image = UIImage(named: "cmale")
             TraineeInfo.details.gender = "male"
            case "female":
            genderImgView.image = UIImage(named: "cfemale")
            TraineeInfo.details.gender = "female"
            case "other":
                       genderImgView.image = UIImage(named: "cmixGen")
            TraineeInfo.details.gender = "other"
        default:
             genderImgView.image = UIImage(named: "")
        }
         let name = TraineeDetails.traineeDetails?.first_name
        fNameTxtField.text = name
        if let last = TraineeDetails.traineeDetails?.last_name {
             lNametxtField.text = last
        }
        if let mobile = TraineeDetails.traineeDetails?.mobile_no {
             phoneTxtField.text = mobile
        }
        if let countryCode = TraineeDetails.traineeDetails?.country_code {
            countryCode1Btn.setTitle(countryCode, for: .normal)
        }
        if let email = TraineeDetails.traineeDetails?.email {
             emailTxtField.text = email
        }
       // let dob = formattedDateFromString(dateString: TraineeDetails.traineeDetails!.date_of_birth!, withFormat: "MMM dd, yyyy")
        let dob = String(TraineeDetails.traineeDetails!.date_of_birth!.prefix(10)) as String
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dob)
        let date1 = Date.getDateInFormat(format: "MMM d, yyyy", date: date!)
        self.dob.setTitle(date1, for: .normal)
        
        if  let activityLevel = TraineeDetails.traineeDetails?.activity_level?.trimmingCharacters(in: .whitespaces) {
            self.activityLevelIndex = self.textActivityArr.firstIndex(of: activityLevel) ?? 0
             TraineeInfo.details.activityLevel = activityLevel

        }
        if TraineeInfo.details.traineeProfileImg.count > 0 {
            self.profileimgView.sd_setImage(with: URL(string: TraineeInfo.details.traineeProfileImg), completed: nil)
        }
    
        let foodTypeArr = TraineeDetails.traineeDetails?.food_preference!.food_type
        self.foodType = foodTypeArr![0].lowercased()
        self.foodTypeIndex = self.foodTypesArr.firstIndex(of: foodTypeArr![0].lowercased()) ?? 0
        
        let mealsArray = TraineeDetails.traineeDetails?.food_preference!.no_of_meals_day!
        self.noOfMeals = String(mealsArray!.prefix(1))
        self.mealsBtn.setTitle( self.noOfMeals, for: .normal)
        
        if let nonVegSel = TraineeDetails.traineeDetails?.food_preference?.non_veg_preference {
            self.meatSelectedArr = nonVegSel
        }
        
        
        let habits = TraineeDetails.traineeDetails?.smoke_alcohol_consumption
        if habits?.status?.lowercased() == "yes" {
            self.alcoholYesBtn.isSelected = true
            self.alcoholYesBtn.backgroundColor = AppColours.appGreen
            self.alcoholYesBtn.setTitleColor(UIColor.black, for: .normal)
            self.alcoholNoBtn.isSelected = false
            self.alcoholNoBtn.backgroundColor = UIColor.clear
            self.alcoholNoBtn.setTitleColor(UIColor.white, for: .normal)
        }else {
            self.alcoholNoBtn.isSelected = true
            self.alcoholNoBtn.backgroundColor = AppColours.appGreen
            self.alcoholNoBtn.setTitleColor(UIColor.black, for: .normal)
            self.alcoholYesBtn.isSelected = false
            self.alcoholYesBtn.backgroundColor = UIColor.clear
            self.alcoholYesBtn.setTitleColor(UIColor.white, for: .normal)
            
        }
        if let smoke = habits?.smoking_consumption {
             self.smokeChoice = smoke
        }
        if let alcohol = habits?.alcohol_consumption {
                    self.alcoholChoice = alcohol
               }
       
      //  self.alcoholChoice = habits!.al
        
        
        
         let sleepQuality = TraineeDetails.traineeDetails?.sleep_quality
        switch sleepQuality {
        case "good":
            self.goodBtn.isSelected = true
            self.goodBtn.setImage(UIImage(named: "wradio"),  for: .normal)
            self.averageBtn.isSelected = false
            self.averageBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.badBtn.isSelected = false
            self.averageBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.sleepQuality = "good"
        case "bad":
            self.badBtn.isSelected = true
            self.badBtn.setImage(UIImage(named: "wradio"),  for: .normal)
            self.averageBtn.isSelected = false
            self.averageBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.goodBtn.isSelected = false
            self.goodBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.sleepQuality = "bad"
        case "average":
            self.averageBtn.isSelected = true
            self.averageBtn.setImage(UIImage(named: "wradio"),  for: .normal)
            self.badBtn.isSelected = false
            self.badBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.goodBtn.isSelected = false
            self.goodBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.sleepQuality = "average"
        default:
            self.sleepQuality = "average"
        }
         let sleepDur = TraineeDetails.traineeDetails?.sleep_duration
        switch sleepDur {
        case "10+ hours":
            self.sleepDuration = "10+ hours"
            self.moreBtn.isSelected = true
            self.moreBtn.setImage(UIImage(named: "wradio"),  for: .normal)
            self.hr1Btn.isSelected = false
            self.hr1Btn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.hr8Btn.isSelected = false
            self.hr8Btn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.hr10Btn.isSelected = false
            self.hr10Btn.setImage(UIImage(named: "cradio"),  for: .normal)
        case "8hrs to 10hrs":
            self.sleepDuration = "8hrs to 10hrs"
            self.hr10Btn.isSelected = true
            self.hr10Btn.setImage(UIImage(named: "wradio"),  for: .normal)
            self.hr1Btn.isSelected = false
            self.hr1Btn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.hr8Btn.isSelected = false
            self.hr8Btn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.moreBtn.isSelected = false
            self.moreBtn.setImage(UIImage(named: "cradio"),  for: .normal)
        case "4hrs to 8hrs":
            self.sleepDuration = "4hrs to 8hrs"
            self.hr8Btn.isSelected = true
            self.hr8Btn.setImage(UIImage(named: "wradio"),  for: .normal)
            self.hr1Btn.isSelected = false
            self.hr1Btn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.hr10Btn.isSelected = false
            self.hr10Btn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.moreBtn.isSelected = false
            self.moreBtn.setImage(UIImage(named: "cradio"),  for: .normal)
        case "1hr to 4hrs":
            self.sleepDuration = "1hr to 4hrs"
            self.hr1Btn.isSelected = true
            self.hr1Btn.setImage(UIImage(named: "wradio"),  for: .normal)
            self.hr8Btn.isSelected = false
            self.hr8Btn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.hr10Btn.isSelected = false
            self.hr10Btn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.moreBtn.isSelected = false
            self.moreBtn.setImage(UIImage(named: "cradio"),  for: .normal)
        default:
            self.moreBtn.setImage(UIImage(named: "cradio"),  for: .normal)
        }
        if let medicalHistory = TraineeDetails.traineeDetails?.medical_history {
            self.diableTxtField.text = medicalHistory.any_disability
                   self.foodATxtField.text = medicalHistory.any_food_allergies
                   self.habbitsTxtField.text = medicalHistory.any_addictions_or_habits
                   self.medicalTxtField.text = medicalHistory.any_medical_surgerie_issues
            self.habbitsTxtField.text = medicalHistory.any_addictions_or_habits
        }
       
        
        let workOutHistory = TraineeDetails.traineeDetails?.previous_workout_history
        if workOutHistory?.status == "yes" {
            self.medicalYesBtn.isSelected = true
            self.medicalYesBtn.backgroundColor = AppColours.appGreen
            self.medicalYesBtn.setTitleColor(UIColor.black, for: .normal)
            self.medicalNoBtn.isSelected = false
            self.medicalNoBtn.backgroundColor = UIColor.clear
            self.medicalNoBtn.setTitleColor(UIColor.white, for: .normal)
            if let desc = workOutHistory?.description {
                self.workOutDesc = desc
            }
            
        }else {
            self.medicalNoBtn.isSelected = true
            self.medicalNoBtn.backgroundColor = AppColours.appGreen
            self.medicalNoBtn.setTitleColor(UIColor.black, for: .normal)
            self.medicalYesBtn.isSelected = false
            self.medicalYesBtn.backgroundColor = UIColor.clear
            self.medicalYesBtn.setTitleColor(UIColor.white, for: .normal)
            
        }
         let height = TraineeDetails.traineeDetails?.trainee_height
        if height?.metric! == "cm" {
           self.cmBtn.isSelected = true
            self.cmBtn.setTitleColor(AppColours.appGreen, for: .normal)
            self.ftBtn.isSelected = false
            self.ftBtn.setTitleColor(UIColor.white, for: .normal)
            self.heightMetric = "cm"
        }else {
             self.ftBtn.isSelected = true
                       self.ftBtn.setTitleColor(AppColours.appGreen, for: .normal)
                       self.cmBtn.isSelected = false
                       self.cmBtn.setTitleColor(UIColor.white, for: .normal)
            self.heightMetric = "feet"
           
        }
        self.height = Double((height?.height)!) as! Double
        self.heightBtn.setTitle(String(format: "%.2f", self.height), for: .normal)
      //  self.heightTxtField.text =
        let weight = TraineeDetails.traineeDetails?.currrent_weight
        if weight?.metric! == "kg" {
            self.kgBtn.isSelected = true
            self.kgBtn.setTitleColor(AppColours.appGreen, for: .normal)
            self.lbBtn.isSelected = false
            self.lbBtn.setTitleColor(UIColor.white, for: .normal)
            self.weightMetric = "kg"
        }else {
            self.lbBtn.isSelected = true
            self.lbBtn.setTitleColor(AppColours.appGreen, for: .normal)
            self.kgBtn.isSelected = false
            self.kgBtn.setTitleColor(UIColor.white, for: .normal)
             self.weightMetric = "lbs"
        }
        self.weight = (weight?.weight)!
         self.weightBtn.setTitle(String(format: "%.2f", self.weight), for: .normal)
       // self.weightTxtField.text = String(format: "%.2f", self.weight)
       
        let bestWoDay = TraineeDetails.traineeDetails?.best_workout_day
        let timeSpent = bestWoDay?.time_spent!
        self.selectedTimeIndex = workOutLevel.firstIndex(of: timeSpent ?? "") ?? 0
        if bestWoDay?.days?.count ?? 0 > 0 {

            for i in 0 ..< bestWoDay!.days!.count {
                let index = days.firstIndex(of: bestWoDay?.days?[i] ?? "")
                if index != nil {
                    self.selectedDays.append(index!)
                }
            }
        }
        let unique = Array(Set(bestWoDay!.days!))
        TraineeInfo.details.best_workout_day = ["days" : unique, "time_spent": timeSpent]
        let primaryGoal = TraineeDetails.traineeDetails?.primary_goal
        switch primaryGoal?.lowercased() {
        case "maintain weight":
            self.maintainBtn.isSelected = true
                self.maintainBtn.setImage(UIImage(named: "wradio"),  for: .normal)
             self.gainBtn.isSelected = false
                self.gainBtn.setImage(UIImage(named: "cradio"),  for: .normal)
               self.looseBtn.isSelected = false
                self.looseBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.primaryGoal = "maintain weight"
            case "lose weight":
            self.looseBtn.isSelected = true
                self.looseBtn.setImage(UIImage(named: "wradio"),  for: .normal)
             self.gainBtn.isSelected = false
                self.gainBtn.setImage(UIImage(named: "cradio"),  for: .normal)
               self.maintainBtn.isSelected = false
                self.maintainBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.primaryGoal = "lose weight"
            case "gain weight":
             self.gainBtn.isSelected = true
                        self.gainBtn.setImage(UIImage(named: "wradio"),  for: .normal)
                     self.maintainBtn.isSelected = false
                        self.maintainBtn.setImage(UIImage(named: "cradio"),  for: .normal)
                       self.looseBtn.isSelected = false
                        self.looseBtn.setImage(UIImage(named: "cradio"),  for: .normal)
                    self.primaryGoal = "gain weight"
        default:
             self.primaryGoal = "maintain weight"
        }
    }
    @IBAction func updateBtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if self.phoneTxtField.text?.count == 0 {
            self.presentAlertWithTitle(title: "", message: "Please enter phone number", options: "OK") {_ in
            }
        }
        let currrent_weight : [String : Any] = ["weight": self.weight ,"metric": self.weightMetric,"updated_on":Date.getCurrentDate()]
         let  currrent_height : [String : Any] = ["height": "\(self.height)" ,"metric": self.heightMetric]
        
        
        TraineeInfo.details.food_preference = ["food_type": [self.foodType],"non_veg_preference": self.meatSelectedArr,"no_of_meals_day": self.noOfMeals]
        var selection = "no"
        if self.alcoholYesBtn.isSelected == true {
            selection = "yes"
        }
            TraineeInfo.details.smoke_alcohol_consumption = ["status":selection,"alcohol_consumption":self.alcoholChoice,"smoking_consumption":self.smokeChoice]
       
        
        let surgery = self.medicalTxtField.text
        let allergy = self.foodATxtField.text
        let disability = self.diableTxtField.text
        let addictions = self.habbitsTxtField.text
        let sur = surgery?.isEmpty ?? false
        let all = allergy?.isEmpty ?? false
        let dis = disability?.isEmpty ?? false
         let habbits = addictions?.isEmpty ?? false
        TraineeInfo.details.medical_history = ["any_medical_surgerie_issues": sur ? "no" : surgery!,"any_food_allergies": all ? "no" : allergy!, "any_disability": dis ? "no" : disability!,"any_addictions_or_habits": habbits ? "no" : addictions!]
        if self.workOutDesc.count > 0 {
            TraineeInfo.details.previous_workout_history = ["status" : "yes","description":self.workOutDesc ]
        }else {
             TraineeInfo.details.previous_workout_history = [ "status" : "no","description":"" ]
        }
        TraineeInfo.details.country_code = self.countryCode1Btn.titleLabel?.text ?? ""
        
        let postBody : [String: Any] = ["first_name": TraineeDetails.traineeDetails?.first_name!,"last_name": TraineeDetails.traineeDetails?.last_name!,"mobile_no": self.phoneTxtField.text!,"gender": TraineeInfo.details.gender,"date_of_birth": TraineeDetails.traineeDetails?.date_of_birth!, "age":TraineeDetails.traineeDetails?.age!,"currrent_weight":currrent_weight, "trainee_height":currrent_height, "activity_level": TraineeInfo.details.activityLevel, "primary_goal":self.primaryGoal, "best_workout_day": TraineeInfo.details.best_workout_day, "food_preference":TraineeInfo.details.food_preference, "smoke_alcohol_consumption":TraineeInfo.details.smoke_alcohol_consumption, "sleep_duration":self.sleepDuration, "sleep_quality":self.sleepQuality,"previous_workout_history":TraineeInfo.details.previous_workout_history,"trainee_timezone":"IST","created_on": Date.getCurrentDate() ,"updated_on":Date.getCurrentDate(),"profile_submission":true,"user_type":"registered","trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"address_submission":TraineeDetails.traineeDetails?.address_submission,"username":TraineeInfo.details.username,"medical_history":TraineeInfo.details.medical_history,"targetWeight":TraineeDetails.traineeDetails?.targetWeight,"country_code":TraineeInfo.details.country_code]
            
            let jsonData = try! JSONSerialization.data(withJSONObject: postBody)
       
            let window = UIApplication.shared.windows.first!
            DispatchQueue.main.async {
                LoadingOverlay.shared.showOverlay(view: window)
            }
            let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
            if token == nil {
                AWSUserSingleton.shared.getUserattributes()
            }
            var authenticatedHeaders: [String: String] {
                [
                    HeadersKeys.authorization: "\(HeaderValues.token) \(token!) "
                    
                ]
            }
            
            let urlString = postTraineeDetails
            guard let url = URL(string: urlString) else {return}
            var request        = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("\(HeaderValues.token) \(token!) ", forHTTPHeaderField: "Authorization")
            do {
                request.httpBody   = try JSONSerialization.data(withJSONObject: postBody)
            } catch let error {
                print("Error : \(error.localizedDescription)")
            }
            Alamofire.request(request).responseJSON{ (response) in
                
                print("response is \(response)")
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                }
                
                if let status = response.response?.statusCode {
                    switch(status){
                    case 200:
                        if let json = response.result.value as? [String: Any] {
                            print("JSON: \(json)") // serialized json response
                            do {
                                if json[ResponseKeys.data.rawValue] != nil
                                {
                                    if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                        if jsonDict != nil {
                                            let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                      options: .prettyPrinted)
                                            TraineeDetails.traineeDetails = try JSONDecoder().decode(TraineeDetails.self, from: jsonData)
                                        }else {
                                            
                                        }
                                        
                                    } else {
                                         DispatchQueue.main.async {
                                        self.presentAlertWithTitle(title: "", message: "Profile Update failed", options: "OK") {_ in
                                        }
                                        }
                                    }
                                } }catch let error {
                                    DispatchQueue.main.async {
                                                       LoadingOverlay.shared.hideOverlayView()
                                        self.presentAlertWithTitle(title: "", message: "Profile Update failed", options: "OK") {_ in
                                                                           }
                                                   }
                                   
                            }
                        }
                        
                    default:
                        DispatchQueue.main.async {
                      
                        }
                    }
                }
            }
        }
    @IBAction func heightBtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        let storyboard = UIStoryboard(name: "HeightViewController", bundle: nil)
               let controller = storyboard.instantiateViewController(withIdentifier: "heightVC") as! HeightViewController
               controller.navigationType = .profileMenu
                controller.metric = self.heightMetric
               if self.heightMetric == "cm" {
                controller.weightVal = self.height
               }else {
                  controller.weightVal = self.height * 30.48
               }
              controller.heightDelegate = self
               controller.modalPresentationStyle = .custom
               controller.transitioningDelegate = self
               controller.view.backgroundColor = UIColor.black
               self.present(controller, animated: true, completion: nil)
    }
    @IBAction func addProfileBtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        let storyboard = UIStoryboard(name: "StartVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "startVC") as! StartViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func weightBtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        let storyboard = UIStoryboard(name: "WeightVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "weightVC") as! WeightViewController
        controller.navigationType = .profileMenu
         controller.metric = self.weightMetric
        if self.weightMetric == "lbs" {
            controller.weightVal = self.weight/2.20
        }else {
           controller.weightVal = self.weight
        }
        controller.weightDelegate = self
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = self
        controller.view.backgroundColor = UIColor.black
        self.present(controller, animated: true, completion: nil)
    }
    @IBAction func gainBtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if self.gainBtn.isSelected {
            self.gainBtn.isSelected = false
            self.gainBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.primaryGoal = ""
        }else {
            self.gainBtn.isSelected = true
             self.gainBtn.setImage(UIImage(named: "wradio"),  for: .normal)
          self.maintainBtn.isSelected = false
             self.maintainBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.looseBtn.isSelected = false
             self.looseBtn.setImage(UIImage(named: "cradio"),  for: .normal)
         self.primaryGoal = "gain weight"
        }
    }
    @IBAction func maintainBtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if self.maintainBtn.isSelected {
            self.maintainBtn.isSelected = false
            self.maintainBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.primaryGoal = ""
        }else {
            self.maintainBtn.isSelected = true
             self.maintainBtn.setImage(UIImage(named: "wradio"),  for: .normal)
          self.gainBtn.isSelected = false
             self.gainBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.looseBtn.isSelected = false
             self.looseBtn.setImage(UIImage(named: "cradio"),  for: .normal)
         self.primaryGoal = "maintain weight"
        }
    }
    @IBAction func looseBtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if self.looseBtn.isSelected {
            self.looseBtn.isSelected = false
            self.looseBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.primaryGoal = ""
        }else {
            self.looseBtn.isSelected = true
             self.looseBtn.setImage(UIImage(named: "wradio"),  for: .normal)
          self.gainBtn.isSelected = false
             self.gainBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.maintainBtn.isSelected = false
             self.maintainBtn.setImage(UIImage(named: "cradio"),  for: .normal)
         self.primaryGoal = "lose weight"
        }
    }
    @IBAction func goodBtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if self.goodBtn.isSelected {
            self.goodBtn.isSelected = false
            self.goodBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.sleepQuality = ""
        }else {
            self.goodBtn.isSelected = true
             self.goodBtn.setImage(UIImage(named: "wradio"),  for: .normal)
          self.averageBtn.isSelected = false
             self.averageBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.badBtn.isSelected = false
             self.averageBtn.setImage(UIImage(named: "cradio"),  for: .normal)
         self.sleepQuality = "good"
        }
    }
    @IBAction func averageBtntapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if self.averageBtn.isSelected {
            self.averageBtn.isSelected = false
            self.averageBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.sleepQuality = ""
        }else {
            self.averageBtn.isSelected = true
           self.averageBtn.setImage(UIImage(named: "wradio"),  for: .normal)
            self.badBtn.isSelected = false
            self.badBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.goodBtn.isSelected = false
            self.goodBtn.setImage(UIImage(named: "cradio"),  for: .normal)
           self.sleepQuality = "average"
        }
    }
    @IBAction func badBtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if self.badBtn.isSelected {
            self.badBtn.isSelected = false
            self.badBtn.setImage(UIImage(named: "cradio"),  for: .normal)
         self.sleepQuality = ""
        }else {
            self.badBtn.isSelected = true
            self.badBtn.setImage(UIImage(named: "wradio"),  for: .normal)
            self.averageBtn.isSelected = false
           self.averageBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.goodBtn.isSelected = false
            self.goodBtn.setImage(UIImage(named: "cradio"),  for: .normal)
           self.sleepQuality = "bad"
        }
    }
    @IBAction func hrBtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if self.hr1Btn.isSelected {
            self.hr1Btn.isSelected = false
            self.hr1Btn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.sleepDuration = ""
        }else {
            self.sleepDuration = "1hr to 4hrs"
            self.hr1Btn.isSelected = true
            self.hr1Btn.setImage(UIImage(named: "wradio"),  for: .normal)
            self.hr8Btn.isSelected = false
             self.hr8Btn.setImage(UIImage(named: "cradio"),  for: .normal)
                      self.hr10Btn.isSelected = false
                        self.hr10Btn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.moreBtn.isSelected = false
             self.moreBtn.setImage(UIImage(named: "cradio"),  for: .normal)
        }
    }
    
    
    @IBAction func hr8BtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if self.hr8Btn.isSelected {
            self.hr8Btn.isSelected = false
            self.hr8Btn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.sleepDuration = ""
        }else {
            self.sleepDuration = "4hrs to 8hrs"
            self.hr8Btn.isSelected = true
            self.hr8Btn.setImage(UIImage(named: "wradio"),  for: .normal)
            self.hr1Btn.isSelected = false
             self.hr1Btn.setImage(UIImage(named: "cradio"),  for: .normal)
                      self.hr10Btn.isSelected = false
                        self.hr10Btn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.moreBtn.isSelected = false
             self.moreBtn.setImage(UIImage(named: "cradio"),  for: .normal)
        }
    }
    
    @IBAction func hr10BtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if self.hr10Btn.isSelected {
            self.hr10Btn.isSelected = false
            self.hr10Btn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.sleepDuration = ""
        }else {
            self.sleepDuration = "8hrs to 10hrs"
            self.hr10Btn.isSelected = true
            self.hr10Btn.setImage(UIImage(named: "wradio"),  for: .normal)
            self.hr1Btn.isSelected = false
             self.hr1Btn.setImage(UIImage(named: "cradio"),  for: .normal)
                      self.hr8Btn.isSelected = false
                        self.hr8Btn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.moreBtn.isSelected = false
             self.moreBtn.setImage(UIImage(named: "cradio"),  for: .normal)
        }
    }
    
    @IBAction func moreBtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if self.moreBtn.isSelected {
            self.moreBtn.isSelected = false
            self.moreBtn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.sleepDuration = ""
        }else {
            self.sleepDuration = "10+ hours"
            self.moreBtn.isSelected = true
            self.moreBtn.setImage(UIImage(named: "wradio"),  for: .normal)
            self.hr1Btn.isSelected = false
             self.hr1Btn.setImage(UIImage(named: "cradio"),  for: .normal)
                      self.hr8Btn.isSelected = false
                        self.hr8Btn.setImage(UIImage(named: "cradio"),  for: .normal)
            self.hr10Btn.isSelected = false
             self.hr10Btn.setImage(UIImage(named: "cradio"),  for: .normal)
        }
    }
    
    
    
    @IBAction func medicalYesTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if self.medicalYesBtn.isSelected {
            self.medicalYesBtn.isSelected = false
            self.medicalYesBtn.backgroundColor = UIColor.clear
            self.medicalYesBtn.setTitleColor(UIColor.white, for: .normal)
        }else {
            self.medicalYesBtn.isSelected = true
            self.medicalYesBtn.backgroundColor = AppColours.appGreen
            self.medicalYesBtn.setTitleColor(UIColor.black, for: .normal)
            self.medicalNoBtn.isSelected = false
            self.medicalNoBtn.backgroundColor = UIColor.clear
            self.medicalNoBtn.setTitleColor(UIColor.white, for: .normal)
            self.showWorkOutHistory()
        }
    }
    
    func showWorkOutHistory() {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
           let storyboard = UIStoryboard(name: "WorkOutHistoryVC", bundle: nil)
                   let alertVC = storyboard.instantiateViewController(withIdentifier: "wohVC") as! WorkOutHistoryVC
           alertVC.workOutDelegate = self
            alertVC.workOutDesc = self.workOutDesc
               alertVC.modalPresentationStyle = .overCurrentContext
                   present(alertVC, animated: false, completion: nil)
       }
    @IBAction func medicalNoTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if self.medicalNoBtn.isSelected {
                   self.medicalNoBtn.isSelected = false
                   self.medicalNoBtn.backgroundColor = UIColor.clear
                   self.medicalNoBtn.setTitleColor(UIColor.white, for: .normal)
               }else {
                self.workOutDesc = ""
                   self.medicalNoBtn.isSelected = true
                   self.medicalNoBtn.backgroundColor = AppColours.appGreen
                   self.medicalNoBtn.setTitleColor(UIColor.black, for: .normal)
                   self.medicalYesBtn.isSelected = false
                   self.medicalYesBtn.backgroundColor = UIColor.clear
                   self.medicalYesBtn.setTitleColor(UIColor.white, for: .normal)
                   
               }
    }
    
    
    @IBAction func doBTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        let storyboard = UIStoryboard(name: "DatePickerVC", bundle: nil)
               let controller = storyboard.instantiateViewController(withIdentifier: "dateVC") as! DatePickerViewController
               controller.navigationType = .profileMenu
                      self.overlayBlurredBackgroundView()
                 controller.modalPresentationStyle = .custom
                  controller.transitioningDelegate = self
                    //  controller.view.backgroundColor = UIColor.black
                      self.present(controller, animated: true, completion: nil)
    }
    // MARK: - Button Actions
    @IBAction func alcoholNoBtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if self.alcoholNoBtn.isSelected {
            self.alcoholNoBtn.isSelected = false
            self.alcoholNoBtn.backgroundColor = UIColor.clear
            self.alcoholNoBtn.setTitleColor(UIColor.white, for: .normal)
           // self.NoSelected = false
        }else {
            self.alcoholNoBtn.isSelected = true
           // self.NoSelected = true
            self.alcoholNoBtn.backgroundColor = AppColours.appGreen
            self.alcoholNoBtn.setTitleColor(UIColor.black, for: .normal)
            self.alcoholYesBtn.isSelected = false
            self.alcoholYesBtn.backgroundColor = UIColor.clear
            self.alcoholYesBtn.setTitleColor(UIColor.white, for: .normal)
        }
    }
    @IBAction func alcoholYesBtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        
//        if self.alcoholYesBtn.isSelected {
//            self.alcoholYesBtn.isSelected = false
//            self.alcoholYesBtn.backgroundColor = UIColor.clear
//            self.alcoholYesBtn.setTitleColor(UIColor.white, for: .normal)
//           
//        }else {
            self.alcoholYesBtn.isSelected = true
            self.alcoholYesBtn.backgroundColor = AppColours.appGreen
            self.alcoholYesBtn.setTitleColor(UIColor.black, for: .normal)
            self.alcoholNoBtn.isSelected = false
            self.alcoholNoBtn.backgroundColor = UIColor.clear
            self.alcoholNoBtn.setTitleColor(UIColor.white, for: .normal)
           // self.NoSelected = false
            self.showHabitsChoice()
       // }
    }
    func showHabitsChoice() {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
           let storyboard = UIStoryboard(name: "HabitChoiceVC", bundle: nil)
           let alertVC = storyboard.instantiateViewController(withIdentifier: "habitChoiceVC") as! HabitChoiceViewController
           alertVC.habitsDelegate = self
        alertVC.navigationType = .profileMenu
        alertVC.alcoholChoice = self.alcoholChoice
        alertVC.smokeChoice = self.smokeChoice
           alertVC.modalPresentationStyle = .custom
           present(alertVC, animated: false, completion: nil)
       }
    @IBAction func ftBtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if self.ftBtn.isSelected {
            self.ftBtn.isSelected = false
            self.ftBtn.setTitleColor(UIColor.white, for: .normal)
            self.heightMetric = "cm"
             let text = self.heightBtn.titleLabel?.text!
             let cms =  Double(text!)!
            self.height = Double(1000 * (cms * 30.48) / 1000)
            self.heightBtn.setTitle( String(format: "%.1f", self.height), for: .normal)
        }else {
            self.ftBtn.isSelected = true
            self.ftBtn.setTitleColor(AppColours.appGreen, for: .normal)
            self.cmBtn.isSelected = false
            self.cmBtn.setTitleColor(UIColor.white, for: .normal)
              let text = self.heightBtn.titleLabel?.text!
            self.height = Double(text!)!
            self.heightMetric = "feet"
            let cms = Double(self.height)
                       self.height = Double(1000 * (cms / 30.48) / 1000)
             self.heightBtn.setTitle( String(format: "%.1f", self.height), for: .normal)
        }
    }
    @IBAction func cmBtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if self.cmBtn.isSelected {
            self.cmBtn.isSelected = false
            self.cmBtn.setTitleColor(UIColor.white, for: .normal)
            self.heightMetric = "feet"
            let text = self.heightBtn.titleLabel?.text!
             self.height = Double(text!)!
          let fts =    Double(1000 * (height / 30.48) / 1000)
            self.height = fts
            // self.heightTxtField.text = String(format: "%.2f", fts)
            self.heightBtn.setTitle( String(format: "%.1f", fts), for: .normal)
        }else {
            self.cmBtn.isSelected = true
            self.cmBtn.setTitleColor(AppColours.appGreen, for: .normal)
            self.ftBtn.isSelected = false
            self.ftBtn.setTitleColor(UIColor.white, for: .normal)
            let text = self.heightBtn.titleLabel?.text!
            self.height = Double(text!)!
            self.heightMetric = "cm"
            let fts =    Double(1000 * (height * 30.48) / 1000)
                       self.height = fts
            self.heightBtn.setTitle( String(format: "%.1f", fts), for: .normal)
        }
    }
    @IBAction func lbBtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if self.lbBtn.isSelected {
            self.lbBtn.isSelected = false
            self.lbBtn.setTitleColor(UIColor.white, for: .normal)
             self.weightMetric = "kg"
             let text = self.weightBtn.titleLabel?.text!
             let kgs = Double(text!)!
            self.weight =  Double((1000 * (kgs / 2.20))/1000)
          //  self.weightTxtField.text = String(format: "%.2f", self.weight)
            self.weightBtn.setTitle( String(format: "%.2f", self.weight), for: .normal)
        }else {
            self.lbBtn.isSelected = true
            self.lbBtn.setTitleColor(AppColours.appGreen, for: .normal)
            self.kgBtn.isSelected = false
            self.kgBtn.setTitleColor(UIColor.white, for: .normal)
             let text = self.weightBtn.titleLabel?.text!
            let lbs = Double(text!)!
            self.weight =  Double((1000 * (lbs * 2.20))/1000)
             self.weightMetric = "lbs"
           // self.weightTxtField.text = String(format: "%.2f", self.weight)
             self.weightBtn.setTitle( String(format: "%.2f", self.weight), for: .normal)
               
        }
    }
    @IBAction func kgBtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        if self.kgBtn.isSelected {
            self.kgBtn.isSelected = false
            self.kgBtn.setTitleColor(UIColor.white, for: .normal)
             let text = self.weightBtn.titleLabel?.text!
            let lbs = Double(text!)!
            self.weightMetric = "lbs"
               self.weight =  Double((1000 * (lbs * 2.20))/1000)
         //   self.weightTxtField.text = String(format: "%.2f", self.weight)
             self.weightBtn.setTitle( String(format: "%.2f", self.weight), for: .normal)
        }else {
            self.kgBtn.isSelected = true
            self.kgBtn.setTitleColor(AppColours.appGreen, for: .normal)
            self.lbBtn.isSelected = false
            self.lbBtn.setTitleColor(UIColor.white, for: .normal)
             let text = self.weightBtn.titleLabel?.text!
            let kgs =  Double(text!)!
            self.weightMetric = "kg"
             self.weight =  Double((1000 * (kgs / 2.20))/1000)
            // self.weightTxtField.text = String(format: "%.2f", self.weight)
             self.weightBtn.setTitle( String(format: "%.2f", self.weight), for: .normal)
        }
    }
    
    
    @IBAction func activityInfoBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ProfileMenuVC", bundle: nil)
                       let controller = storyboard.instantiateViewController(withIdentifier: "PickerVC") as! PickerVC
        controller.popType = .activityPicker
         controller.pickerDelegate = self
                      // controller.navigationType = .profileMenu
        //               self.definesPresentationContext = true
        //                      self.providesPresentationContextTransitionStyle = true
                             // self.overlayBlurredBackgroundView()
                         controller.modalPresentationStyle = .custom
                          controller.transitioningDelegate = self
                              controller.view.backgroundColor = UIColor.black
                              self.present(controller, animated: true, completion: nil)
        
    }
    @IBAction func mealsTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        
        let storyboard = UIStoryboard(name: "ProfileMenuVC", bundle: nil)
               let controller = storyboard.instantiateViewController(withIdentifier: "PickerVC") as! PickerVC
         controller.popType = .morePicker
        controller.selectedMeals =  self.noOfMeals
        controller.pickerDelegate = self
              // controller.navigationType = .profileMenu
//               self.definesPresentationContext = true
//                      self.providesPresentationContextTransitionStyle = true
                     // self.overlayBlurredBackgroundView()
                 controller.modalPresentationStyle = .custom
                  controller.transitioningDelegate = self
                      controller.view.backgroundColor = UIColor.black
                      self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func workoutBtnTapped(_ sender: Any) {
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
        let bestWoDay = TraineeInfo.details.best_workout_day
        let timeSpent = bestWoDay["time_spent"]
        self.selectedDays = []
        self.selectedTimeIndex = workOutLevel.firstIndex(of: timeSpent as! String)!
        var arr = bestWoDay["days"] as! [Any]
        if arr.count > 0 {
            for i in 0 ..< arr.count {
                let index = days.firstIndex(of: arr[i] as! String)
                self.selectedDays.append(index ?? 0)
            }
        }
         let unique = Array(Set(self.selectedDays))
        self.selectedDays = unique
      //  arr = nil
        let storyboard = UIStoryboard(name: "WorkOutStoryboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "workoutVC") as! WorkOutDaysViewController
        controller.navigationType = .profileMenu
        controller.selectedTimeIndex = self.selectedTimeIndex
        controller.selectedDays = self.selectedDays
       // self.definesPresentationContext = true
//               self.providesPresentationContextTransitionStyle = true
//               self.overlayBlurredBackgroundView()
          controller.modalPresentationStyle = .custom
           controller.transitioningDelegate = self
               controller.view.backgroundColor = UIColor.black
               self.present(controller, animated: true, completion: nil)
    }
    func overlayBlurredBackgroundView() {
        
        let blurredBackgroundView = UIVisualEffectView()
        
        blurredBackgroundView.frame = view.frame
        blurredBackgroundView.effect = UIBlurEffect(style: .dark)
        
        view.addSubview(blurredBackgroundView)
        
    }
}
//class CustomTextField: UITextField {
//
//    convenience init() {
//        self.init(frame: .zero)
//        let border = CALayer()
//        let width = CGFloat(2.0)
//        border.frame = CGRect(x: 0, y: frame.size.height - width, width: frame.size.width, height: frame.size.height)
//        border.cornerRadius = 10
//        border.borderColor = AppColours.textGreen.cgColor
//        border.borderWidth = width
//        layer.addSublayer(border)
//        layer.masksToBounds = true
//    }
//
//}
 @IBDesignable
    open class CustomTextField: UITextField {

        func setup() {
            let border = CALayer()
            let width = CGFloat(2.0)
            border.cornerRadius = 10
        border.borderColor = AppColours.textGreen.cgColor
        border.frame = CGRect(x: 1, y: self.frame.size.height - width, width: self.frame.size.width - 1, height: self.frame.size.height - 1)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.weightTxtField || textField == self.heightTxtField {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }else if textField == self.phoneTxtField {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
                       let characterSet = CharacterSet(charactersIn: string)
                       return allowedCharacters.isSuperset(of: characterSet)
        }else if textField == self.phoneTxtField   {
            let maxLength = 10
               let currentString: NSString = textField.text! as NSString
               let newString: NSString =
                   currentString.replacingCharacters(in: range, with: string) as NSString
               return newString.length <= maxLength
        }else if textField == self.diableTxtField || textField == self.foodATxtField || textField == self.medicalTxtField || textField == self.habbitsTxtField  {
            let maxLength = 100
               let currentString: NSString = textField.text! as NSString
               let newString: NSString =
                   currentString.replacingCharacters(in: range, with: string) as NSString
               return newString.length <= maxLength
        }
        else {
            return true
        }
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        if self.countryCode2Btn.isHidden == false {
            self.countryCode2Btn.isHidden = true
        }
    }
}
extension ProfileViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch collectionView {
    case self.foodPreCV:
        return self.foodTypesArr.count
        case self.activityCV:
            return self.activityArr.count
    default:
        return 1
    }
}
func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
}
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    
    switch collectionView {
    case self.foodPreCV:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "singleCV", for: indexPath) as! SingleSelectionCV
        cell.singleBtn.text = self.foodTypesArr[indexPath.row].capitalized
        if indexPath.row == self.foodTypeIndex {
            cell.singleBtn.layer.backgroundColor = AppColours.appGreen.cgColor
        }else {
             cell.singleBtn.layer.backgroundColor = UIColor.clear.cgColor
        }
        
        return cell
    case self.activityCV:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "meatCV", for: indexPath) as! MeatCollectionViewCell
        cell.imgView.image = UIImage(named: activityArr[indexPath.row])
        cell.nameLbl.text = textActivityArr[indexPath.row]
        cell.contentView.layer.cornerRadius = 0
        if indexPath.row == self.activityLevelIndex {
            cell.imgView.image = UIImage(named: selActivityArr[indexPath.row])
        }
        return cell
    default:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCV", for: indexPath) as! HeaderCollectionViewCell
        
        return cell
    }
    
   
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 5
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 5
}
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case self.foodPreCV:
            let noOfCellsInRow = 3
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
            
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            
            return CGSize(width: size, height: 40)
        case self.activityCV:
            let noOfCellsInRow = 5
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
            
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            
            return CGSize(width: size, height: 90)
        default:
            return CGSize(width: 60, height: 30)
        }
    }
 func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    switch collectionView {
    case self.foodPreCV:
      
        let cell = collectionView.cellForItem(at: indexPath) as! SingleSelectionCV
        cell.singleBtn.layer.backgroundColor = AppColours.appGreen.cgColor
     
        if "non veg" == foodTypesArr[indexPath.row] {
            self.showFoodPreferences()
        }
        self.foodType = foodTypesArr[indexPath.row].lowercased()
        if self.foodTypeIndex != -1{
            let cell1 = collectionView.cellForItem(at: IndexPath(row: self.foodTypeIndex, section: 0)) as! SingleSelectionCV
            cell1.singleBtn.layer.backgroundColor = UIColor.clear.cgColor
            self.foodTypeIndex = -1
        }
        
    case self.activityCV:
       let cell = collectionView.cellForItem(at: indexPath) as! MeatCollectionViewCell
         cell.imgView.image = UIImage(named: selActivityArr[indexPath.row])
       if self.activityLevelIndex != -1{
        let cell1 = collectionView.cellForItem(at: IndexPath(row: self.activityLevelIndex, section: 0)) as! MeatCollectionViewCell
        cell1.imgView.image = UIImage(named: activityArr[self.activityLevelIndex])
        self.activityLevelIndex = -1
       }
      
       TraineeInfo.details.activityLevel = self.textActivityArr[indexPath.row]
    default:
        print("default statement")
    }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        switch collectionView {
           case self.foodPreCV:
             let cell = collectionView.cellForItem(at: indexPath) as! SingleSelectionCV
             cell.singleBtn.layer.backgroundColor = UIColor.clear.cgColor
          self.foodType = ""
           case self.activityCV:
              let cell = collectionView.cellForItem(at: indexPath) as! MeatCollectionViewCell
            cell.imgView.image = UIImage(named: activityArr[indexPath.row])
             TraineeInfo.details.activityLevel = ""
           default:
               print("default statement")
           }
        
    }
    func showFoodPreferences() {
        let storyboard = UIStoryboard(name: "MeatChoiceVC", bundle: nil)
                   let alertVC = storyboard.instantiateViewController(withIdentifier: "meatChoiceVC") as! MeatChoiceViewController
                   alertVC.delegate = self
        alertVC.navigationType = .profileMenu
           alertVC.selectedMeatArr = self.meatSelectedArr
                   alertVC.modalPresentationStyle = .custom
                   present(alertVC, animated: false, completion: nil)
    }
}

extension ProfileViewController : MeatChoiceDelegate ,UIViewControllerTransitioningDelegate{
    func meatSelected(meat: [String]) {
       // self.isMeatChoiceDone = true
        self.meatSelectedArr = meat
    }
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController:presented, presenting: presenting)
    }
}

extension ProfileViewController: HabitsDelegate,workOutDelegate,SelectedValuesFromPickerDelegate {
    func smokeSelected(smoke: String) {
        self.smokeChoice = smoke
    }
    func alcoholSelected(alcohol: String) {
        self.alcoholChoice = alcohol
    }
    func workoutHistroy(descr: String) {
           self.workOutDesc = descr
       }
    func selectedActivity(index:Int, value:String) {
        TraineeInfo.details.activityLevel = value
    }
    func noOfMealsday(mealsNo:String) {
        self.noOfMeals = mealsNo
        DispatchQueue.main.async {
        self.mealsBtn.setTitle( self.noOfMeals, for: .normal)
        }
    }
}




extension ProfileViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        if text == "\n"
        {
            textView.resignFirstResponder()
            return false
        }
        return numberOfChars < 300    // 10 Limit Value
    }
    func textViewDidBeginEditing(_ textView: UITextView) {

        if textView.textColor == UIColor.lightGray {
            switch textView {
            case self.diableTxtField:
                diableTxtField.text = ""
                diableTxtField.textColor = UIColor.white
            case self.habbitsTxtField:
                habbitsTxtField.text = ""
                habbitsTxtField.textColor = UIColor.white
            case self.foodATxtField:
                foodATxtField.text = ""
                foodATxtField.textColor = UIColor.white
            case self.medicalTxtField:
                medicalTxtField.text = ""
                medicalTxtField.textColor = UIColor.white
            default:
                textView.text = ""
                textView.textColor = UIColor.white
            }
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text == "" {
            
            if textView.textColor == UIColor.white {
                switch textView {
                case self.diableTxtField:
                    diableTxtField.text = "List any disabilities* you have"
                    diableTxtField.textColor = UIColor.lightGray
                case self.habbitsTxtField:
                    habbitsTxtField.text = "List any other addictions or habbits"
                    habbitsTxtField.textColor = UIColor.lightGray
                case self.foodATxtField:
                    foodATxtField.text = "List any food item(s) you're allergic to"
                    foodATxtField.textColor = UIColor.lightGray
                case self.medicalTxtField:
                    medicalTxtField.text = "List any other medical issue(s)"
                    medicalTxtField.textColor = UIColor.lightGray
                default:
                    textView.text = ""
                    textView.textColor = UIColor.lightGray
                }
            }
        }
    }
}
extension ProfileViewController: PhotosBottomVCDelegate,CropViewControllerDelegate {
    func imageSelected(image:UIImage) {
        // self.dietTime = time
        DispatchQueue.main.async {
            self.presentCropViewController(image: image)
        }
        
    }
    func presentCropViewController(image :UIImage) {
        let cropViewController = CropViewController(image: image)
        cropViewController.delegate = self
        self.present(cropViewController, animated: true, completion: nil)
    }
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        //    self.profilePicImageView.image = image
        self.uploadProfilePics(image: image, successHandler: { (url) in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
//                self.progressPhotoView.photosArr = progressPhoto
//                self.progressPhotoView.refreshViews()
                cropViewController.dismiss(animated: true, completion: nil)
                if url?.count ?? 0 > 0 {
                     TraineeInfo.details.traineeProfileImg = url!
                     self.profileimgView.sd_setImage(with: URL(string: TraineeInfo.details.traineeProfileImg), completed: nil)
                }else {
                    self.presentAlertWithTitle(title: "", message: "Photo upload failed", options: "OK") { _ in
                        
                    }
                }
            }
        }) { (error) in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
//                self.progressPhotoView.photosArr = nil
//                self.progressPhotoView.refreshViews()
                cropViewController.dismiss(animated: true, completion: nil)
                self.presentAlertWithTitle(title: "", message: error, options: "OK") { _ in
                    
                }
            }
        }
       
        
    }
    func uploadProfilePics(image:UIImage, successHandler: @escaping (String?) -> Void,
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
     
           let postBody : [String: Any] = ["uploadedOn": Date.getDateInFormat(format: "yyyy-MM-dd", date: Date()),"trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"profileImageName":imageName,"imgcode":image.toString() as Any,"file_type":"jpg"]
                   let urlString = uploadProfilePic
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
                                        let jsonData = try JSONSerialization.data(withJSONObject: json as Any, options: .prettyPrinted)
                                        let url = json["data"] as? String
                                          successHandler(url)
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
}
extension ProfileViewController : HeightBackButtonTapDelegate,WeightBackButtonTapDelegate {
    func updateHeightForProfile() {
        DispatchQueue.main.async {
            let height = TraineeDetails.traineeDetails?.trainee_height
           if height?.metric! == "cm" {
              self.cmBtn.isSelected = true
               self.cmBtn.setTitleColor(AppColours.appGreen, for: .normal)
               self.ftBtn.isSelected = false
               self.ftBtn.setTitleColor(UIColor.white, for: .normal)
               self.heightMetric = "cm"
           }else {
                self.ftBtn.isSelected = true
                          self.ftBtn.setTitleColor(AppColours.appGreen, for: .normal)
                          self.cmBtn.isSelected = false
                          self.cmBtn.setTitleColor(UIColor.white, for: .normal)
               self.heightMetric = "feet"
              
           }
           self.height = Double((height?.height)!) as! Double
           self.heightBtn.setTitle(String(format: "%.2f", self.height), for: .normal)
        }
    }
    func updateWeightForProfile() {
        DispatchQueue.main.async {
            let weight = TraineeDetails.traineeDetails?.currrent_weight
            if weight?.metric! == "kg" {
                self.kgBtn.isSelected = true
                self.kgBtn.setTitleColor(AppColours.appGreen, for: .normal)
                self.lbBtn.isSelected = false
                self.lbBtn.setTitleColor(UIColor.white, for: .normal)
                self.weightMetric = "kg"
            }else {
                self.lbBtn.isSelected = true
                self.lbBtn.setTitleColor(AppColours.appGreen, for: .normal)
                self.kgBtn.isSelected = false
                self.kgBtn.setTitleColor(UIColor.white, for: .normal)
                 self.weightMetric = "lbs"
            }
            self.weight = (weight?.weight)!
             self.weightBtn.setTitle(String(format: "%.2f", self.weight), for: .normal)
        }
    }
    
    
}
