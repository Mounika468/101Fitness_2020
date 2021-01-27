//
//  TraineeInfo.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 26/02/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
struct TraineeInfo  {
    static var details: TraineeInfo = TraineeInfo()
    var trainee_profile_staus: String = ""
     var mobile_no: String = ""
    var country_code: String = ""
    var first_name :String = ""
    var last_name :String = ""
    var date_of_birth :String = ""
    var gender: String = ""
    var age: Int = 0
    var weight:Dictionary = [String : Any]()
    var height:Dictionary = [String : Any]()
    var activityLevel: String = ""
     var primaryGoal: String = ""
     var best_workout_day:Dictionary = [String : Any]()
     var food_preference:Dictionary = [String : Any]()
    var dietary: [String: String] = [:]
    var sleep_duration: String = ""
    var sleep_quality: String = ""
    var smoke_alcohol_consumption: [String: String] = [:]
     var medical_history: [String: String] = [:]
    var previous_workout_history: [String: String] = [:]
     var trainee_timezone: String = ""
     var created_on: String = ""
     var updated_on: String = ""
     var trainee_address: [Any] = []
     var username: String = ""
     var email: String = ""
     var address_submission: Bool = false
     var profile_submission: Bool = false
     var traineeProfileImg: String = ""
    var targetWeight: Float = 0.0
    var notificationCount: Int = 0
}
struct ProgramDetails {
    static var programDetails: ProgramDetails = ProgramDetails()
    var programId: String = ""
    var programStartDate: String = ""
     var workoutId: String = ""
     var exerciseRefId: Int = 0
    var dayWorkOut: DayWorkOuts?
     var selectedWODate: Date = Date()
    var subId: String = ""
}
struct ProgramPaymentDetails {
    static var programPaymentDetails: ProgramPaymentDetails = ProgramPaymentDetails()
    var PaymentInfo: PaymentDetails?
   
}
struct Currrent_Weight: Codable {
    let weight: Double?
     let metric: String?
     let updated_on: String?
    
    init(weight: Double?,
         metric: String?,
          updated_on: String?) {
        self.weight = weight
         self.metric = metric
        self.updated_on = updated_on
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.weight = try container.decodeIfPresent(Double.self, forKey: .weight)
        self.metric = try container.decodeIfPresent(String.self, forKey: .metric)
         self.updated_on = try container.decodeIfPresent(String.self, forKey: .updated_on)
       }
}
struct Trainee_Height: Codable {
    let height: Double?
     let metric: String?
    
    init(height: Double?,
         metric: String?) {
        self.height = height
         self.metric = metric
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.height = try container.decodeIfPresent(Double.self, forKey: .height)
        self.metric = try container.decodeIfPresent(String.self, forKey: .metric)
       }
}
struct Best_workout_day: Codable {
    var days: [String]?
     let time_spent: String?
    
    init(days: [String]?,
         time_spent: String?) {
        self.days = days
         self.time_spent = time_spent
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.days = try container.decodeIfPresent([String].self, forKey: .days)
        self.time_spent = try container.decodeIfPresent(String.self, forKey: .time_spent)
       }
}
struct Food_preference: Codable {
    var food_type: [String]?
     let no_of_meals_day: String?
     var non_veg_preference: [String]?
    
    init(food_type: [String]?,
         no_of_meals_day: String?,
         non_veg_preference: [String]?) {
        self.food_type = food_type
         self.no_of_meals_day = no_of_meals_day
         self.non_veg_preference = non_veg_preference
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.food_type = try container.decodeIfPresent([String].self, forKey: .food_type)
        self.no_of_meals_day = try container.decodeIfPresent(String.self, forKey: .no_of_meals_day)
         self.non_veg_preference = try container.decodeIfPresent([String].self, forKey: .non_veg_preference)
       }
}
struct Smoke_alcohol_consumption: Codable {
    let status: String?
     let alcohol_consumption: String?
     let smoking_consumption: String?
    
    init(status: String?,
         alcohol_consumption: String?,
         smoking_consumption: String?) {
        self.status = status
         self.alcohol_consumption = alcohol_consumption
         self.smoking_consumption = smoking_consumption
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.alcohol_consumption = try container.decodeIfPresent(String.self, forKey: .alcohol_consumption)
         self.smoking_consumption = try container.decodeIfPresent(String.self, forKey: .smoking_consumption)
       }
}
struct Medical_history: Codable {
    let any_disability: String?
     let any_food_allergies: String?
     let any_medical_surgerie_issues: String?
     let any_addictions_or_habits: String?
    
    init(any_disability: String?,
         any_food_allergies: String?,
         any_medical_surgerie_issues: String?,
          any_addictions_or_habits: String?) {
        self.any_disability = any_disability
         self.any_food_allergies = any_food_allergies
         self.any_medical_surgerie_issues = any_medical_surgerie_issues
         self.any_addictions_or_habits = any_addictions_or_habits
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.any_disability = try container.decodeIfPresent(String.self, forKey: .any_disability)
        self.any_food_allergies = try container.decodeIfPresent(String.self, forKey: .any_food_allergies)
         self.any_medical_surgerie_issues = try container.decodeIfPresent(String.self, forKey: .any_medical_surgerie_issues)
         self.any_addictions_or_habits = try container.decodeIfPresent(String.self, forKey: .any_addictions_or_habits)
       }
}
struct Previous_workout_history: Codable {
    let status: String?
     let description: String?
    
    init(status: String?,
         description: String?) {
        self.status = status
         self.description = description
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
       }
}
struct Lat_logAttributes: Codable {
    let latitude: String?
     let longitude: String?
    
    init(latitude: String?,
         longitude: String?) {
        self.latitude = latitude
         self.longitude = longitude
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.latitude = try container.decodeIfPresent(String.self, forKey: .latitude)
        self.longitude = try container.decodeIfPresent(String.self, forKey: .longitude)
       }
}
struct BMIBMR: Codable {
    let bmi_value: Float?
    let bmr_value: Float?
}
struct TraineeDetails: Decodable {
    
    let gender: String?
    let date_of_birth: String?
    let age: Int?
    var currrent_weight: Currrent_Weight?
    var bmi_bmr: BMIBMR?
    var trainee_height: Trainee_Height?
    var best_workout_day: Best_workout_day?
    var food_preference: Food_preference?
    var smoke_alcohol_consumption: Smoke_alcohol_consumption?
    var medical_history: Medical_history?
    var previous_workout_history: Previous_workout_history?
    var lat_logAttributes: Lat_logAttributes?
    var trainee_address: [Address]?
    var traineeProfileImg: TraineeProfileImg?
    let activity_level: String?
    let primary_goal : String?
    let sleep_duration: String?
    let sleep_quality: String?
    let trainee_timezone: String?
    let created_on : String?
    let updated_on: String?
    let program_id : String?
    let program_startdate : String?
    let email: String?
    let country_code: String?
    let username: String?
    let address_submission: Bool?
    let profile_submission: Bool?
    let app_version: Double?
    let user_type: String?
    let trainee_id: String
    let first_name: String?
    let last_name: String?
    let trainee_profile_staus: String?
    let mobile_no: String?
    var targetWeight: Float?
    var dayProgress: DayProgress?
    let notificationCount: Int?
    static var traineeDetails: TraineeDetails?
    init(trainee_id: String,
         first_name: String?,
         last_name: String?,
         gender: String?,
         date_of_birth: String?,
         age: Int?,
         trainee_profile_staus: String?,
         mobile_no: String?,
         activity_level: String?,
         primary_goal : String?,
         sleep_duration: String?,
         sleep_quality: String?,
         trainee_timezone: String?,
         created_on : String?,
         updated_on: String?,
         program_id : String?,
         program_startdate : String?,
         email: String?,
         country_code: String?,
         username: String?,
         address_submission: Bool?,
         profile_submission: Bool?,
         app_version: Double?,
         user_type: String?,
         targetWeight:Float,
         notificationCount: Int?) {
        
        self.trainee_id = trainee_id
        self.targetWeight = targetWeight
        self.first_name = first_name
        self.last_name = last_name
        self.gender = gender
        self.date_of_birth = date_of_birth
        self.age = age
        self.trainee_profile_staus = trainee_profile_staus
        self.mobile_no = mobile_no
        self.activity_level = activity_level
        self.primary_goal = primary_goal
        self.sleep_duration = sleep_duration
        self.sleep_quality = sleep_quality
        self.trainee_timezone = trainee_timezone
        self.created_on = created_on
        self.updated_on = updated_on
        self.program_id  = program_id
        self.program_startdate = program_startdate
        self.email = email
        self.country_code = country_code
        self.username = username
        self.address_submission = address_submission
        self.profile_submission = profile_submission
        self.app_version = app_version
        self.user_type = user_type
        self.notificationCount = notificationCount
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
        self.first_name = try container.decodeIfPresent(String.self, forKey: .first_name)
        self.last_name = try container.decodeIfPresent(String.self, forKey: .last_name)
        self.gender = try container.decodeIfPresent(String.self, forKey: .gender)
        self.date_of_birth = try container.decodeIfPresent(String.self, forKey: .date_of_birth)
        
        self.age = try container.decodeIfPresent(Int.self, forKey: .age)
        self.trainee_profile_staus = try container.decodeIfPresent(String.self, forKey: .trainee_profile_staus)
        self.mobile_no = try container.decodeIfPresent(String.self, forKey: .mobile_no)
        self.activity_level = try container.decodeIfPresent(String.self, forKey: .activity_level)
        self.primary_goal = try container.decodeIfPresent(String.self, forKey: .primary_goal)
        
        self.sleep_duration = try container.decodeIfPresent(String.self, forKey: .sleep_duration)
        self.sleep_quality = try container.decodeIfPresent(String.self, forKey: .sleep_quality)
        self.trainee_timezone = try container.decodeIfPresent(String.self, forKey: .trainee_timezone)
        self.created_on = try container.decodeIfPresent(String.self, forKey: .created_on)
        
        self.updated_on = try container.decodeIfPresent(String.self, forKey: .updated_on)
        self.program_id = try container.decodeIfPresent(String.self, forKey: .program_id)
        self.program_startdate = try container.decodeIfPresent(String.self, forKey: .program_startdate)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.country_code = try container.decodeIfPresent(String.self, forKey: .country_code)
        
        self.username = try container.decodeIfPresent(String.self, forKey: .username)
        self.address_submission = try container.decodeIfPresent(Bool.self, forKey: .address_submission)
        self.profile_submission = try container.decodeIfPresent(Bool.self, forKey: .profile_submission)
        self.app_version = try container.decodeIfPresent(Double.self, forKey: .app_version)
        self.user_type = try container.decodeIfPresent(String.self, forKey: .user_type)
        self.traineeProfileImg = try container.decodeIfPresent(TraineeProfileImg.self, forKey: .traineeProfileImg)
        
        self.targetWeight = try container.decodeIfPresent(Float.self, forKey: .targetWeight)
        self.bmi_bmr = try container.decodeIfPresent(BMIBMR.self, forKey: .bmi_bmr)
        
        self.currrent_weight = try container.decodeIfPresent(Currrent_Weight.self, forKey: .currrent_weight)
        self.trainee_height = try container.decodeIfPresent(Trainee_Height.self, forKey: .trainee_height)
        self.best_workout_day = try container.decodeIfPresent(Best_workout_day.self, forKey: .best_workout_day)
        self.food_preference = try container.decodeIfPresent(Food_preference.self, forKey: .food_preference)
        
        self.smoke_alcohol_consumption = try container.decodeIfPresent(Smoke_alcohol_consumption.self, forKey: .smoke_alcohol_consumption)
        self.medical_history = try container.decodeIfPresent(Medical_history.self, forKey: .medical_history)
        self.previous_workout_history = try container.decodeIfPresent(Previous_workout_history.self, forKey: .previous_workout_history)
        self.lat_logAttributes = try container.decodeIfPresent(Lat_logAttributes.self, forKey: .lat_logAttributes)
        self.trainee_address = try container.decodeIfPresent([Address].self, forKey: .trainee_address)
        self.dayProgress = try container.decodeIfPresent(DayProgress.self, forKey: .dayProgress)
        self.notificationCount = try container.decodeIfPresent(Int.self, forKey: .notificationCount)
        
    }
    
}
extension TraineeDetails {
       
    enum CodingKeys: String, CodingKey {
        
        case trainee_id
        case first_name
        case last_name
        case profileImage
        case rating
        case new
        case currrent_weight
        case trainee_height
        case best_workout_day
        case food_preference
        case smoke_alcohol_consumption
        case medical_history
        case previous_workout_history
        case lat_logAttributes
        case trainee_address
        case gender
        case date_of_birth
        case age
        case activity_level
        case primary_goal
        case sleep_duration
         case sleep_quality
        case trainee_timezone
        case created_on
        case updated_on
        case program_id
        case program_startdate
        case email
        case country_code
        case username
        case address_submission
        case profile_submission
        case app_version
        case user_type
        case mobile_no
        case trainee_profile_staus
        case traineeProfileImg
        case targetWeight
        case bmi_bmr
        case dayProgress
        case notificationCount
    }
}
struct TraineeProfileImg:Codable {
    let profileImageName: String?
    let profileImagePath: String?
    
}
struct DayProgress:Codable {
    let workoutNewPercentage: Double?
    let workoutOtherPercentage: Double?
    let mealNewPercentage: Double?
    let mealOtherPercentage:Double?
    
}
//["first_name": TraineeDetails.traineeDetails?.first_name!,"last_name": TraineeDetails.traineeDetails?.last_name!,"mobile_no": self.phoneTxtField.text!,"gender": TraineeInfo.details.gender,"date_of_birth": TraineeDetails.traineeDetails?.date_of_birth!, "age":TraineeDetails.traineeDetails?.age!,"currrent_weight":currrent_weight, "trainee_height":currrent_height, "activity_level": TraineeInfo.details.activityLevel, "primary_goal":self.primaryGoal, "best_workout_day": TraineeInfo.details.best_workout_day, "food_preference":TraineeInfo.details.food_preference, "smoke_alcohol_consumption":TraineeInfo.details.smoke_alcohol_consumption, "sleep_duration":self.sleepDuration, "sleep_quality":self.sleepQuality,"previous_workout_history":TraineeInfo.details.previous_workout_history,"trainee_timezone":"IST","trainee_address":addressArr[0],"created_on": Date.getCurrentDate() ,"updated_on":Date.getCurrentDate(),"trainee_profile_status":"registered","profile_submission":true,"user_type":"registered","trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"address_submission":TraineeDetails.traineeDetails?.address_submission,"username":TraineeInfo.details.username,"medical_history":TraineeInfo.details.medical_history]
//struct TraineeInfoUpdatePostBoday: Codable {
//    let gender: String?
//    let date_of_birth: String?
//    let age: Int?
//    var currrent_weight: Currrent_Weight?
//    var trainee_height: Trainee_Height?
//    var best_workout_day: Best_workout_day?
//    var food_preference: Food_preference?
//    var smoke_alcohol_consumption: Smoke_alcohol_consumption?
//    var medical_history: Medical_history?
//    var previous_workout_history: Previous_workout_history?
//    var lat_logAttributes: Lat_logAttributes?
//    var trainee_address: [Address]?
//
//    let activity_level: String?
//    let primary_goal : String?
//    let sleep_duration: String?
//    let sleep_quality: String?
//    let trainee_timezone: String?
//    let created_on : String?
//    let updated_on: String?
//    let program_id : String?
//    let program_startdate : String?
//    let email: String?
//    let country_code: String?
//    let username: String?
//    let address_submission: Bool?
//    let profile_submission: Bool?
//    let app_version: Double?
//    let user_type: String?
//    let trainee_id: String
//    let first_name: String?
//    let last_name: String?
//    let trainee_profile_staus: String?
//    let mobile_no: String?
//    static var traineeDetails: TraineeDetails?
//    init(program_id: String,
//         date:String,
//         trainee_id: String,
//         cardioDistanceSet: DisplayVal?,
//         cardioStatus:String)  {
//        self.program_id = program_id
//        self.date = date
//        self.trainee_id = trainee_id
//        self.cardioDistanceSet = cardioDistanceSet
//         self.cardioStatus = cardioStatus
//    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.program_id = try container.decode(String.self, forKey: .program_id)
//        self.date = try container.decode(String.self, forKey: .date)
//        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
//        self.cardioDistanceSet = try container.decode(DisplayVal.self, forKey: .cardioDistanceSet)
//         self.cardioStatus = try container.decode(String.self, forKey: .cardioStatus)
//    }
//}
/*
struct TraineeDetailsUpdatePostBoday: Codable {
    let gender: String?
    let date_of_birth: String?
    let age: Int?
    var currrent_weight: Currrent_Weight?
    var trainee_height: Trainee_Height?
    var best_workout_day: Best_workout_day?
    var food_preference: Food_preference?
    var smoke_alcohol_consumption: Smoke_alcohol_consumption?
    var medical_history: Medical_history?
    var previous_workout_history: Previous_workout_history?
    var lat_logAttributes: Lat_logAttributes?
    var trainee_address: Address?
    
    let activity_level: String?
    let primary_goal : String?
    let sleep_duration: String?
    let sleep_quality: String?
    let trainee_timezone: String?
    let created_on : String?
    let updated_on: String?
    let program_id : String?
    let program_startdate : String?
    let email: String?
    let country_code: String?
    let username: String?
    let address_submission: Bool?
    let profile_submission: Bool?
    let app_version: Double?
    let user_type: String?
    let trainee_id: String
    let first_name: String?
    let last_name: String?
    let trainee_profile_staus: String?
    let mobile_no: String?
    init(trainee_id: String,
         first_name: String?,
         last_name: String?,
         gender: String?,
         date_of_birth: String?,
         age: Int?,
         trainee_profile_staus: String?,
         mobile_no: String?,
         activity_level: String?,
         primary_goal : String?,
         sleep_duration: String?,
         sleep_quality: String?,
         trainee_timezone: String?,
         created_on : String?,
         updated_on: String?,
         program_id : String?,
         program_startdate : String?,
         email: String?,
         country_code: String?,
         username: String?,
         address_submission: Bool?,
         profile_submission: Bool?,
         app_version: Double?,
         user_type: String?,
         currrent_weight: Currrent_Weight?,
         trainee_height: Trainee_Height?,
         best_workout_day: Best_workout_day?,
         food_preference: Food_preference?,
         smoke_alcohol_consumption: Smoke_alcohol_consumption?,
         medical_history: Medical_history?,
         previous_workout_history: Previous_workout_history?,
         lat_logAttributes: Lat_logAttributes?,
         trainee_address: Address?) {
        
        self.trainee_id = trainee_id
        self.first_name = first_name
        self.last_name = last_name
        self.gender = gender
        self.date_of_birth = date_of_birth
        self.age = age
        self.trainee_profile_staus = trainee_profile_staus
        self.mobile_no = mobile_no
        self.activity_level = activity_level
        self.primary_goal = primary_goal
        self.sleep_duration = sleep_duration
        self.sleep_quality = sleep_quality
        self.trainee_timezone = trainee_timezone
        self.created_on = created_on
        self.updated_on = updated_on
        self.program_id  = program_id
        self.program_startdate = program_startdate
        self.email = email
        self.country_code = country_code
        self.username = username
        self.address_submission = address_submission
        self.profile_submission = profile_submission
        self.app_version = app_version
        self.user_type = user_type
        self.currrent_weight = currrent_weight
        self.trainee_height = trainee_height
        self.best_workout_day = best_workout_day
        self.food_preference = food_preference
        self.smoke_alcohol_consumption = smoke_alcohol_consumption
        self.medical_history = medical_history
        self.previous_workout_history = previous_workout_history
        self.lat_logAttributes = lat_logAttributes
        self.trainee_address = trainee_address
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
        self.first_name = try container.decodeIfPresent(String.self, forKey: .first_name)
        self.last_name = try container.decodeIfPresent(String.self, forKey: .last_name)
        self.gender = try container.decodeIfPresent(String.self, forKey: .gender)
        self.date_of_birth = try container.decodeIfPresent(String.self, forKey: .date_of_birth)
        
        self.age = try container.decodeIfPresent(Int.self, forKey: .age)
        self.trainee_profile_staus = try container.decodeIfPresent(String.self, forKey: .trainee_profile_staus)
        self.mobile_no = try container.decodeIfPresent(String.self, forKey: .mobile_no)
        self.activity_level = try container.decodeIfPresent(String.self, forKey: .activity_level)
        self.primary_goal = try container.decodeIfPresent(String.self, forKey: .primary_goal)
        
        self.sleep_duration = try container.decodeIfPresent(String.self, forKey: .sleep_duration)
        self.sleep_quality = try container.decodeIfPresent(String.self, forKey: .sleep_quality)
        self.trainee_timezone = try container.decodeIfPresent(String.self, forKey: .trainee_timezone)
        self.created_on = try container.decodeIfPresent(String.self, forKey: .created_on)
        
        self.updated_on = try container.decodeIfPresent(String.self, forKey: .updated_on)
        self.program_id = try container.decodeIfPresent(String.self, forKey: .program_id)
        self.program_startdate = try container.decodeIfPresent(String.self, forKey: .program_startdate)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.country_code = try container.decodeIfPresent(String.self, forKey: .country_code)
        
        self.username = try container.decodeIfPresent(String.self, forKey: .username)
        self.address_submission = try container.decodeIfPresent(Bool.self, forKey: .address_submission)
        self.profile_submission = try container.decodeIfPresent(Bool.self, forKey: .profile_submission)
        self.app_version = try container.decodeIfPresent(Double.self, forKey: .app_version)
        self.user_type = try container.decodeIfPresent(String.self, forKey: .user_type)
        
        
        
        self.currrent_weight = try container.decodeIfPresent(Currrent_Weight.self, forKey: .currrent_weight)
        self.trainee_height = try container.decodeIfPresent(Trainee_Height.self, forKey: .trainee_height)
        self.best_workout_day = try container.decodeIfPresent(Best_workout_day.self, forKey: .best_workout_day)
        self.food_preference = try container.decodeIfPresent(Food_preference.self, forKey: .food_preference)
        
        self.smoke_alcohol_consumption = try container.decodeIfPresent(Smoke_alcohol_consumption.self, forKey: .smoke_alcohol_consumption)
        self.medical_history = try container.decodeIfPresent(Medical_history.self, forKey: .medical_history)
        self.previous_workout_history = try container.decodeIfPresent(Previous_workout_history.self, forKey: .previous_workout_history)
        self.lat_logAttributes = try container.decodeIfPresent(Lat_logAttributes.self, forKey: .lat_logAttributes)
        self.trainee_address = try container.decodeIfPresent(Address.self, forKey: .trainee_address)
        
    }
}*/
