//
//  GetCalenderAPI.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 04/02/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation

var messageString = ""
final class GetCalenderStatusAPI: API
{
    static func post(traineeId: String,programId: String,header:[String: String],
                     successHandler: @escaping (CalenderStatus) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        
       // ?trainee_id=37aa26f0-14a4-40e5-ba78-a6825c36d3e5&program_id=5ec8cbcb71038065bb3dc8a2
        let urlString = getCalenderStatus + "trainee_id=" + traineeId + "&program_id=" + programId
        //let request = APIRequest((method: .post, url: urlString, parameters: parameters, headers: header, data))
        let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)

        sendAPIRequest(request,
                       successHandler: { (json: JSON) in
                        do {
                            if  let jsonDict = json[ResponseKeys.data.rawValue] {
                                let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                 let calender = try JSONDecoder().decode(CalenderStatus.self, from: jsonData)
                                                               successHandler(calender)
                            } else {
                                successHandler(CalenderStatus(calendar_id: "", trainee_id: "", program_id: ""))
                            }
                        } catch let error {
                            errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                        }
                        
        }, errorHandler: { error in
            errorHandler(error)
        })

    }
}
final class GetCalenderByDateAPI: API
{
    static func post(traineeId: String,programId: String,header:[String: String],date: String,
                     successHandler: @escaping (DayWorkOuts) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        
       // ?trainee_id=37aa26f0-14a4-40e5-ba78-a6825c36d3e5&program_id=5ec8cbcb71038065bb3dc8a2
        let urlString = getCalenderforDay + "trainee_id=" + traineeId  + "&date=" + date
        //let request = APIRequest((method: .post, url: urlString, parameters: parameters, headers: header, data))
        let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)

        sendAPIRequest(request,
                       successHandler: { (json: JSON) in
                        do {
                            if  let jsonDict = json[ResponseKeys.data.rawValue] {
                                if jsonDict != nil {
                                    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                    let workouts = try JSONDecoder().decode(DayWorkOuts.self, from: jsonData)
                                    successHandler(workouts)
                                }else {
                                    if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                        messageString = (jsonMessage as? String)!
                                        successHandler(DayWorkOuts(day: 0, rest: false))
                                    }
                                }
                                
                            } else {
                                
                                successHandler(DayWorkOuts(day: 0, rest: false))
                            }
                        } catch let error {
                            errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                        }
                        
        }, errorHandler: { error in
            errorHandler(error)
        })

    }
    static func getCalendarDayColours(header:[String: String],trainee_id:String,
                                        successHandler: @escaping (CalendarDayColours?) -> Void,
                                        errorHandler: @escaping (APIError) -> Void) {
        
         let urlString = getDaysColours + trainee_id
         let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)

         sendAPIRequest(request,
                        successHandler: { (json: JSON) in
                         do {
                            if  let jsonDict = json[ResponseKeys.data.rawValue] {
                                if jsonDict != nil {
                                    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                    let days = try JSONDecoder().decode(CalendarDayColours.self, from: jsonData)
                                    successHandler(days)
                                }else {
                                    if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                        messageString = (jsonMessage as? String)!
                                        successHandler(nil)
                                    }
                                }
                                
                            } else {
                                
                                  successHandler(nil)
                            }
                        } catch let error {
                             errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                         }
                         
         }, errorHandler: { error in
             errorHandler(error)
         })

     }
}
final class GetDietByDateAPI: API
{
    static func post(traineeId: String,programId: String,header:[String: String],date: String,
                     successHandler: @escaping (Diet?) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        messageString = ""
        let urlString = getNutriDietByDate + "?trainee_id=" + traineeId + "&date=" + date
       
        let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)

        sendAPIRequest(request,
                       successHandler: { (json: JSON) in
                        do {
                            if  let jsonDict = json[ResponseKeys.data.rawValue] {
                                if jsonDict != nil {
                                    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                    let diet = try JSONDecoder().decode(Diet.self, from: jsonData)
                                    successHandler(diet)
                                }else {
                                    if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                        messageString = (jsonMessage as? String)!
                                        successHandler(nil)
                                    }
                                }
                                
                            } else {
                                
                                  successHandler(nil)
                            }
                        } catch let error {
                            errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                        }
                        
        }, errorHandler: { error in
            errorHandler(error)
        })

    }
    static func updateMealPlanAPI(parameters: [String: Any],header:[String: String],dataParams:Data,methodName:String,
                        successHandler: @escaping (Diet?) -> Void,
                        errorHandler: @escaping (APIError) -> Void) {
           
          // ?trainee_id=37aa26f0-14a4-40e5-ba78-a6825c36d3e5&program_id=5ec8cbcb71038065bb3dc8a2
           let urlString = updateMealPlan
           //let request = APIRequest((method: .post, url: urlString, parameters: parameters, headers: header, data))
         //  let request = APIRequest(method: .put, url: urlString, parameters: parameters, headers: header, dataParams: dataParams)
        
        
        var request = APIRequest(method: .put, url: urlString, parameters: parameters, headers: header, dataParams: dataParams)
        switch methodName {
        case "post":
            request = APIRequest(method: .post, url: urlString, parameters: parameters, headers: header, dataParams: dataParams)
            case "put":
            request = APIRequest(method: .put, url: urlString, parameters: parameters, headers: header, dataParams: dataParams)
        default:
            request = APIRequest(method: .put, url: urlString, parameters: parameters, headers: header, dataParams: dataParams)
        }
        
        
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        if token == nil {
            AWSUserSingleton.shared.getUserattributes()
        }
        

           sendAPIRequestBody(request, token: "\(HeaderValues.token) \(token!) ", successHandler: { (json: JSON) in
                      do {
                          if  let jsonDict = json[ResponseKeys.data.rawValue] {
                              if jsonDict != nil {
                                  let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                  let diet = try JSONDecoder().decode(Diet.self, from: jsonData)
                                  successHandler(diet)
                              }else {
                                  if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                      messageString = (jsonMessage as? String)!
                                      successHandler(nil)
                                  }
                              }
                             
                          } else {
                              successHandler(nil)
                          }
                      } catch let error {
                          errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                      }
                      
                  }, errorHandler: { error in
                                 errorHandler(error)
                             })

       }
    static func deleteMealPlanAPI(header:[String: String],mealType: String,foodRefId:Int,
                     successHandler: @escaping (Diet?) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        
        let urlString = String(format: "%@%@/%@?trainee_id=%@&date=%@", deleteMealPlan,mealType,"\(foodRefId)",UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,Date.getDateInFormat(format: "dd/MM/yyyy", date: ProgramDetails.programDetails.selectedWODate))
     
     let request = APIRequest(method: .delete, url: urlString, parameters: nil, headers: header, dataParams: nil)
     

        sendAPIRequest(request,
                       successHandler: { (json: JSON) in
                        do {
                            if  let jsonDict = json[ResponseKeys.data.rawValue] {
                                if jsonDict != nil {
                                    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                    let diet = try JSONDecoder().decode(Diet.self, from: jsonData)
                                    successHandler(diet)
                                }else {
                                    if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                        messageString = (jsonMessage as? String)!
                                        successHandler(nil)
                                    }
                                }

                            } else {
                                successHandler(nil)
                            }
                        } catch let error {
                            errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                        }
                        
        }, errorHandler: { error in
            errorHandler(error)
        })


//        sendAPIRequestBody(request, token: "\(HeaderValues.token) \(token!) ", successHandler: { (json: JSON) in
//                   do {
//                       if  let jsonDict = json[ResponseKeys.data.rawValue] {
//                           if jsonDict != nil {
//                               let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
//                               let diet = try JSONDecoder().decode(Diet.self, from: jsonData)
//                               successHandler(diet)
//                           }else {
//                               if let jsonMessage = json[ResponseKeys.message.rawValue] {
//                                   messageString = (jsonMessage as? String)!
//                                   successHandler(nil)
//                               }
//                           }
//
//                       } else {
//                           successHandler(nil)
//                       }
//                   } catch let error {
//                       errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
//                   }
//
//               }, errorHandler: { error in
//                              errorHandler(error)
//                          })

    }
    static func updateWaterAPI(parameters: [String: Any],header:[String: String],dataParams:Data,
                      successHandler: @escaping (Diet?) -> Void,
                      errorHandler: @escaping (APIError) -> Void) {
         
         let urlString = updateMealPlan
         let request = APIRequest(method: .put, url: urlString, parameters: parameters, headers: header, dataParams: dataParams)
    var token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
      if token == nil {
          AWSUserSingleton.shared.getUserattributes()
      }

         sendAPIRequestBody(request, token: "\(HeaderValues.token) \(token!) ", successHandler: { (json: JSON) in
                    do {
                        if  let jsonDict = json[ResponseKeys.data.rawValue] {
                            if jsonDict != nil {
                                let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                let diet = try JSONDecoder().decode(Diet.self, from: jsonData)
                                successHandler(diet)
                            }else {
                                if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                    messageString = (jsonMessage as? String)!
                                    successHandler(nil)
                                }
                            }
                           
                        } else {
                            successHandler(nil)
                        }
                    } catch let error {
                        errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                    }
                    
                }, errorHandler: { error in
                               errorHandler(error)
                           })

     }
    static func getNutritionixFoodItemsByBarcode(header:[String: String],searchString: String,
                                        successHandler: @escaping (FullNutritionixFoodData?) -> Void,
                                        errorHandler: @escaping (APIError) -> Void) {
        
        // ?trainee_id=37aa26f0-14a4-40e5-ba78-a6825c36d3e5&program_id=5ec8cbcb71038065bb3dc8a2
         let urlString = searchFoodItemsByBarcode + searchString
         //let request = APIRequest((method: .post, url: urlString, parameters: parameters, headers: header, data))
         let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)

         sendAPIRequest(request,
                        successHandler: { (json: JSON) in
                         do {
                          if json.count > 0 {
                              let jsonData = try JSONSerialization.data(withJSONObject: json as Any, options: .prettyPrinted)
                              let foodDetails = try JSONDecoder().decode(FullNutritionixFoodData.self, from: jsonData)
                               successHandler(foodDetails)
                              
                          }else {
                              successHandler(nil)
                          }
                         } catch let error {
                             errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                         }
                         
         }, errorHandler: { error in
             errorHandler(error)
         })

     }
    static func getNutritionixFoodItems(header:[String: String],searchString: String,
                                        successHandler: @escaping (PartialNutritionixFoodData?) -> Void,
                                        errorHandler: @escaping (APIError) -> Void) {
        
        // ?trainee_id=37aa26f0-14a4-40e5-ba78-a6825c36d3e5&program_id=5ec8cbcb71038065bb3dc8a2
         var urlString = searchFoodItems + searchString
         //let request = APIRequest((method: .post, url: urlString, parameters: parameters, headers: header, data))
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? urlString

        let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)

         sendAPIRequest(request,
                        successHandler: { (json: JSON) in
                         do {
                          if json.count > 0 {
                              let jsonData = try JSONSerialization.data(withJSONObject: json as Any, options: .prettyPrinted)
                              let foodDetails = try JSONDecoder().decode(PartialNutritionixFoodData.self, from: jsonData)
                               successHandler(foodDetails)
                              
                          }else {
                              successHandler(nil)
                          }
                         } catch let error {
                             errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                         }
                         
         }, errorHandler: { error in
             errorHandler(error)
         })

     }
    static func getNutritionixBrandedFoodDetails(header:[String: String],nixID:String,
                                        successHandler: @escaping (FullNutritionixFoodData?) -> Void,
                                        errorHandler: @escaping (APIError) -> Void) {
        
        // ?trainee_id=37aa26f0-14a4-40e5-ba78-a6825c36d3e5&program_id=5ec8cbcb71038065bb3dc8a2
         let urlString = getNutrionixBrandedFoodDetails + nixID
         //let request = APIRequest((method: .post, url: urlString, parameters: parameters, headers: header, data))
         let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)

         sendAPIRequest(request,
                        successHandler: { (json: JSON) in
                         do {
                          if json.count > 0 {
                              let jsonData = try JSONSerialization.data(withJSONObject: json as Any, options: .prettyPrinted)
                              let foodDetails = try JSONDecoder().decode(FullNutritionixFoodData.self, from: jsonData)
                               successHandler(foodDetails)
                              
                          }else {
                              successHandler(nil)
                          }
                         } catch let error {
                             errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                         }
                         
         }, errorHandler: { error in
             errorHandler(error)
         })

     }
   

 
}
