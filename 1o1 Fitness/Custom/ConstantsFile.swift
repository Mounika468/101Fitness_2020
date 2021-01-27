// Demo Server
//
//  ConstantsFile.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 27/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//

import Foundation
import UIKit
//13.127.234.22
//15.206.204.136
//13.127.215.167
//let baseHostURL = "http://13.127.234.22:9092/api/guest" //Dev
//let baseHostURL = "http://15.206.204.136:9092/api/guest" // Test Env
//let hostURL = "http://15.206.204.136:9092"
//let devHostURL = "https://dev.1o1.cloudns.asia/"
let devHostURL = "https://demo.1o1fitness.com/"
let demoHostURL = "https://demo.1o1fitness.com/"
let getAllTrainers = "\(devHostURL)traineeservice/api/guest/trainers/all"
let getTrainerByLocation = "\(devHostURL)traineeservice/api/guest/trainers"
let getTrainerPackage = "\(devHostURL)traineeservice/api/guest/trainers/"
let getTrainerProfile = "\(devHostURL)traineeservice/api/guest/trainers/"
let getTrainerVideoList = "\(devHostURL)traineeservice/api/guest/trainer/videos/"
let postTraineeDetails = "\(devHostURL)traineeservice/api/trainees"
let uploadProfilePic = "\(devHostURL)traineeservice/api/trainees/profilephotos"
let getCalenderStatus = "\(devHostURL)traineeservice/api/trainees/calendar/status?"
let getCalenderforDay = "\(devHostURL)traineeservice/api/trainees/calendar/day?"
let getDaysColours = "\(devHostURL)traineeservice/api/trainees/calendar/progress?trainee_id="
let woSetsUpdate = "\(devHostURL)traineeservice/api/trainees/calendar"
let subscribeURL = "\(devHostURL)traineeservice/api/trainees/subscribe"
let OrderIdURL = "\(devHostURL)AppServices/api/orders"
let syncPaymentId = "\(devHostURL)AppServices/api/payments/update"
let addressPostURL = "\(devHostURL)traineeservice/api/trainees/"
let getCountriesList = "\(devHostURL)traineeservice/api/trainees/countries"
let getFoodBySearchList = "\(devHostURL)nutritionservice/NIN/Nutrition/search"
let updateMealPlan = "\(devHostURL)traineeservice/api/trainees/mealplan/day"
let updateWaterPlan = "\(devHostURL)traineeservice/api/trainees/mealplan/self/day"
let deleteMealPlan = "\(devHostURL)traineeservice/api/trainees/mealplan/"

let getAllCallForTrainee = "\(devHostURL)traineeservice/api/trainees/scheduler"
let bookSlotForCall = "\(devHostURL)traineeservice/api/trainees/scheduler/slots"
let getToken = "\(devHostURL)twilioservice/api/twilio/token?"
let cancelCall = "\(devHostURL)traineeservice/api/trainees/scheduler/slots/cancel"
let getCallsByDate = "\(devHostURL)traineeservice/api/trainees/scheduler/"
let getCallsByDateForGuest = "\(devHostURL)traineeservice/api/guest/trainer/scheduler"

let savePhoto = "\(devHostURL)traineeservice/api/trainees/progressphotos"
let getAllPhotos = "\(devHostURL)traineeservice/api/trainees/"
let getProgressByDate = "\(devHostURL)traineeservice/api/trainees/progressphotos/day"
let deletePhoto = "\(devHostURL)traineeservice/api/trainees/"


//Nutrionix API
let searchFoodItems = "https://trackapi.nutritionix.com/v2/search/instant?query="
let searchFoodItemsByBarcode = "https://trackapi.nutritionix.com/v2/search/item?upc="
let getNutrionixCommonFoodDetails = "https://trackapi.nutritionix.com/v2/natural/nutrients"
let getNutrionixBrandedFoodDetails = "https://trackapi.nutritionix.com/v2/search/item?nix_item_id="
let getNutriDietByDate = "\(devHostURL)traineeservice/api/trainees/mealplan/day"


//Programs API
let getPrograms = "\(devHostURL)traineeservice/api/trainees/"
let getDetailsForProgramId = "\(devHostURL)traineeservice/api/trainees/"

//Search API
let trainersSearch = "\(devHostURL)traineeservice/api/guest/trainers/search/"

//Get Success Orders https://demo.1o1fitness.com/traineeservice/api/trainees/{trainee_id)/orders/{order_id}
let getSuccessDetailsAPI = "\(devHostURL)traineeservice/api/trainees/"

//Notifications API
let getNotificationsAPI = "\(devHostURL)notificationservice/api/notifications/notification/"
let postNotificationsURL = "\(devHostURL)/notificationservice/api/notifications/notification?requestedBy=Trainee"

//Contactsus API
let getcontactUs = "\(devHostURL)traineeservice/api/trainees/request/types"
let postContactComments = "\(devHostURL)traineeservice/api/trainees/request"

//Reminders API
let getReminders = "\(devHostURL)traineeservice/api/trainees/reminder/"
let postReminders = "\(devHostURL)traineeservice/api/trainees/reminder"

struct UserPoolCredentials {
  
    static let accessKey = "AKIAUXZP6WV4EEXWBXUY"
    static let secretKey = "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"
    static let groupName = "TraineeIOSGroup"
    static let userPoolId = "us-east-2_FxGxXsrmO"
    
}
struct UserDefaultsKeys {
    static let accessToken = "accessToken"
    static let subId = "sub"
    static let name = "name"
    static let email = "email"
    static let programId = "programId"
    static let programStartdate = "programStartdate"
    static let guestLogin = "guestLogin"
    static let authUser = "authUser"
    static let profile_submission = "profile_submission"
    static let userName = "userName"
    static let password = "password"
    static let googleUser = "googleUser"
}
struct COLORCODES {
    static let green : UIColor = UIColor(red: 8/255, green: 56/255, blue: 28/255, alpha: 1.0)
   static let yellow : UIColor = UIColor(red: (34/255), green: (128/255), blue: (68/255), alpha: 1.0)
    static let transparent : UIColor = UIColor.clear
}
struct WOStatus {
    static let complete : String = "completed"
   static let inProgress : String = "inprogress"
    static let new : String = "new"
    static let notCompleted : String = "not completed"
}
let WorkOutsUpdatedNotification : String = "WorkOutsUpdatedNotification"
let CreatedByTrainee : String = "trainee"

public class IOSVersion {
    class func SYSTEM_VERSION_EQUAL_TO(version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedSame
    }

   class func SYSTEM_VERSION_GREATER_THAN(version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedDescending
    }

  class  func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) != .orderedAscending
    }

   class func SYSTEM_VERSION_LESS_THAN(version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedAscending
    }

  class  func SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) != .orderedDescending
    }
}
